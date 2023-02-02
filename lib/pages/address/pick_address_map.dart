import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ifood_delivery/base/custom_button.dart';
import 'package:ifood_delivery/controllers/location_controller.dart';
import 'package:ifood_delivery/routes/route_helper.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/dimensions.dart';

import '../../base/show_custom_snackbar.dart';
import '../../models/address_model.dart';
import '../location/location_search_dialogue.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final bool canRoute;
  final String route;
  final GoogleMapController? googleMapController;
  const PickAddressMap({
    Key? key,
    required this.fromSignup,
    required this.fromAddress,
    this.googleMapController,
    required this.canRoute,
    required this.route,
  }) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition ;//= CameraPosition(target: LatLng(double.parse(Get.find<LocationController>().getAddress["latitude"]), double.parse(Get.find<LocationController>().getAddress["longitude"]))  /*LatLng(45.521563, -122.677433)*/,zoom: 17);
  late LatLng _initialPosition;

  @override
  void initState() {
    // TODO: implement setState
    super.initState();
    if(widget.fromAddress) {
      Get.find<LocationController>().setPickData();
    }
    if(Get.find<LocationController>().addressList.isEmpty){
      //print("isEmty");
      _initialPosition =  const LatLng(/*45.521563, -122.677433 10.7379632,106.6409313*/ 10.7961488,106.6667848);
    }else{
      if(Get.find<LocationController>().getUserAddress().address.isNotEmpty){
        //print("My address is "+Get.find<LocationController>().getUserAddress().address);
        //print("Lat is "+Get.find<LocationController>().getAddress["latitude"].toString());

        _cameraPosition = CameraPosition(
            target:  LatLng(
                double.parse(Get.find<LocationController>().getAddress["latitude"]),
                double.parse(Get.find<LocationController>().getAddress["longitude"])),zoom: 17);
        _initialPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress["latitude"]),
            double.parse(Get.find<LocationController>().getAddress["longitude"]));
      }/*else{
       print("Are we here");
       _initialPosition =  LatLng(45.521563, -122.677433);
     }*/
    }
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: GetBuilder<LocationController>(builder: (locationController){
                print('--------------${'${locationController.pickPlaceMark.name ?? ''} '
                    '${locationController.pickPlaceMark.locality ?? ''} '
                    '${locationController.pickPlaceMark.postalCode ?? ''}'
                    '${locationController.pickPlaceMark.country ?? ''}'}');
                return Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: widget.fromAddress ?_initialPosition /*LatLng(locationController.position.latitude, locationController.position.longitude)*/
                            : _initialPosition,
                        zoom: 17,
                      ),
                      onMapCreated: (GoogleMapController mapController) {
                        _mapController = mapController;
                        if(!widget.fromAddress) {
                          print("pick from web");
                          Get.find<LocationController>().getCurrentLocation(false, mapController: mapController);
                        }
                      },
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition cameraPosition){
                        _cameraPosition = cameraPosition;
                      },
                      onCameraMoveStarted: () {
                        locationController.disableButton();
                      },
                      onCameraIdle: () {
                        Get.find<LocationController>()
                            .updatePosition(_cameraPosition, false);

                      },
                    ),
                    Center(
                        child: !locationController.loading
                            ? Image.asset("assets/image/pick_marker.png",
                          height: 50,
                          width: 50,
                        ): const CircularProgressIndicator()
                    ),
                    Positioned(
                      top: Dimensions.height45,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: InkWell(
                        onTap: () => Get.dialog(LocationSearchDialog(mapController: _mapController)),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: Dimensions.width20),
                          height: 50,
                          decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(Dimensions.radius20/2)
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.location_on,size: 25,color: AppColors.yellowColor,),
                              Expanded(child: Text(
                                '${locationController.pickPlaceMark.name ?? ''} '
                                    '${locationController.pickPlaceMark.locality ?? ''} '
                                    '${locationController.pickPlaceMark.postalCode ?? ''} '
                                    '${locationController.pickPlaceMark.country ?? ''}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Dimensions.font16
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )),
                              Icon(Icons.search, size: 20, color: Theme.of(context).textTheme.bodyText1!.color),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 80,
                      right: Dimensions.width20,
                      child: FloatingActionButton(
                        mini: true, backgroundColor: Theme.of(context).cardColor,
                        onPressed: () => _checkPermission(() {
                          Get.find<LocationController>().getCurrentLocation(false, mapController: _mapController);
                        }),
                        child: Icon(Icons.my_location, color: Theme.of(context).primaryColor),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      child: !locationController.isLoading
                          ? CustomButton(
                        buttonText: locationController.inZone
                            ? widget.fromAddress
                            ? 'Chọn địa chỉ'
                            : 'Chọn vị trí'
                            : 'Dịch vụ không có sẵn trong khu vực của bạn',
                        onPressed: (locationController.buttonDisabled || locationController.loading)
                            ? null
                            :(){

                          if(locationController.pickPosition.latitude != 0 &&
                              locationController.pickPlaceMark.name != null){
                            if(widget.fromAddress){
                              if(widget.googleMapController!=null){
                                print("--------Now you can clicked on this");
                                widget.googleMapController!.moveCamera(
                                    CameraUpdate.newCameraPosition(
                                        CameraPosition(
                                            target: LatLng(
                                              locationController.pickPosition.latitude,
                                              locationController.pickPosition.longitude,
                                            ), zoom: 17)));
                                locationController.setAddAddressData();

                                //print(locationController.setAddAddressData());
                              }
                              //Get.toNamed(RouteHelper.getAddressPage());
                              Get.back();
                            } else {
                              AddressModel _address = AddressModel(
                                latitude: locationController.pickPosition.latitude.toString(),
                                longitude: locationController.pickPosition.longitude.toString(),
                                addressType: 'others',
                                address: '${locationController.pickPlaceMark.name ?? ''} '
                                    '${locationController.pickPlaceMark.locality ?? ''} '
                                    '${locationController.pickPlaceMark.postalCode ?? ''} ${locationController.pickPlaceMark.country ?? ''}',
                              );
                              locationController.saveAddressAndNavigate(_address, widget.fromSignup, widget.route, widget.canRoute);
                            }
                          } else {
                            showCustomSnackBar('Chọn một địa chỉ'.tr);
                          }
                        },
                      )
                          : Center(child: CircularProgressIndicator(),),
                    ),
                  ],
                );},
              ),
            ),
          ),
        ),
      );
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.denied) {
      showCustomSnackBar('Bạn phải cho phép'.tr);
    }else if(permission == LocationPermission.deniedForever) {
      print("permission denied");
    }else {
      onTap();
    }
  }
}
