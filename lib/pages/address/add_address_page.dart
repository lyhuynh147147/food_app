import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ifood_delivery/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/controllers/location_controller.dart';
import 'package:ifood_delivery/controllers/user_controller.dart';
import 'package:ifood_delivery/models/address_model.dart';
import 'package:ifood_delivery/pages/address/pick_address_map.dart';
import 'package:ifood_delivery/pages/location/permission_dialogue.dart';
import 'package:ifood_delivery/utils/colors.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/widgets/app_text_field.dart';
import 'package:ifood_delivery/widgets/big_text.dart';

import '../../base/show_custom_snackbar.dart';
import '../../routes/route_helper.dart';
import '../../widgets/app_icon.dart';


class AddAddressPage extends StatefulWidget {
  const AddAddressPage({Key? key}) : super(key: key);

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  var _contactPersonName = TextEditingController();
  var _contactPersonNumber = TextEditingController();
  late bool _isLogged;

  late CameraPosition _cameraPosition = CameraPosition(
      target: LatLng(
        //45.51563,-122.677433
        10.7961488,106.6667848
        // 10.7379632,106.6409313
  ), zoom: 17);
  late LatLng _initialPosition ;

  @override
  void initState() {
    super.initState();

    _isLogged = Get.find<AuthController>().userLoggedIn();
    if(_isLogged && Get.find<UserController>().userModel == null) {
      print("pug");
      Get.find<UserController>().getUserInfo();
    }
    if(Get.find<LocationController>().addressList.isEmpty){
      _initialPosition =  LatLng(/*45.521563, -122.677433, 10.7379632,106.6409313*/10.7961488,106.6667848);
    } else {
      if (Get.find<LocationController>().getUserAddress().address.isNotEmpty){
        print("My address is "+Get.find<LocationController>().getUserAddress().address);
        print("Lat is "+Get.find<LocationController>().getAddress["latitude"].toString());

        _cameraPosition=
            CameraPosition(target:
            LatLng(
              double.parse(Get.find<LocationController>().getAddress["latitude"]),
              double.parse(Get.find<LocationController>().getAddress["longitude"]),
            ), zoom: 17,);
        _initialPosition =
            LatLng(
              double.parse(Get.find<LocationController>().getAddress["latitude"]),
              double.parse(Get.find<LocationController>().getAddress["longitude"]),
            );
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Trang địa chỉ"),
        backgroundColor: AppColors.mainColor,
      ),
      body: _isLogged ? GetBuilder<UserController>(builder: (userController) {
        _contactPersonName.text = '${userController.userModel?.name}';
        _contactPersonNumber.text = '${userController.userModel?.phone}';
        if(Get.find<LocationController>().addressList.isNotEmpty){
          _addressController.text = Get.find<LocationController>().getUserAddress().address;
          print("address from database"+_addressController.text);

        }
        return GetBuilder<LocationController>(builder: (locationController){
          _addressController.text =
          '${locationController.placeMark.name??''}'
              '${locationController.placeMark.locality??''}'
              '${locationController.placeMark.postalCode??''}'
              '${locationController.placeMark.country??''}';
          print("address in my view is " + _addressController.text);
          return Scrollbar(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        width: 2,
                        color: AppColors.mainColor,
                      )
                  ),
                  child: Stack(
                    children: [
                      GoogleMap(initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 17),
                        onTap: (latlng) {
                          Get.toNamed(RouteHelper.getPickAddressPage('add-address',false),
                              arguments: PickAddressMap(
                                fromSignup: false,
                                fromAddress: true,
                                googleMapController: locationController.mapController,
                                canRoute: false,
                                route: "",
                              )
                          );
                        },
                        zoomControlsEnabled: false,
                        compassEnabled: false,
                        indoorViewEnabled: true,
                        mapToolbarEnabled: false,
                        myLocationEnabled: true,
                        onCameraIdle: (){
                          print("tapping for udpate");
                          locationController.updatePosition(_cameraPosition,true);
                        },
                        onCameraMove: ((position) => _cameraPosition = position),
                        onMapCreated: (GoogleMapController controller) {
                          print("I am from address page");
                          locationController.setMapController(controller);
                        },
                      ),
                      locationController.loading ? Center(child: CircularProgressIndicator()) : SizedBox(),
                      Center(child: !locationController.loading ? Icon(Icons.web)
                          : CircularProgressIndicator()),
                      Positioned(
                        top: 10, right: 0,
                        child: InkWell(
                          onTap: () => _checkPermission(() {
                            locationController.getCurrentLocation(true, mapController: locationController.mapController);
                          }),
                          child: Container(
                            width: 30, height: 30,
                            margin: EdgeInsets.only(right: Dimensions.PADDING_SIZE_LARGE),
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), color: Colors.white),
                            child: Icon(Icons.fullscreen, color: Theme.of(context).primaryColor, size: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  SizedBox(height: Dimensions.height20,),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypeList.length,
                      itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              locationController.setAddressTypeIndex(index);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.width20,
                                  vertical: Dimensions.height10
                              ),
                              margin: EdgeInsets.only(right: Dimensions.width10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radius20/2),
                                color: Theme.of(context).cardColor,
                                boxShadow: [BoxShadow(color: Colors.grey[200]!,
                                    spreadRadius: 1, blurRadius: 5)],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    index == 0
                                        ?Icons.home_filled
                                        :index == 1 ? Icons.work
                                        :Icons.location_on,
                                    color: locationController.addressTypeList==index
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).disabledColor,
                                  ),
                                ],
                              ),
                            ),
                          )
                    ),
                  ),
                  SizedBox(height: Dimensions.height20,),

                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: BigText(text: "delivery_address".tr),
                  ),
                  SizedBox(height: Dimensions.height10,),
                  AppTextField(
                    textController: _addressController,
                    hintText: "Địa chỉ của bạn",
                    icon: Icons.map,
                  ),
                  SizedBox(height: Dimensions.height20,),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: BigText(text: "contact_person_name".tr),
                  ),
                  SizedBox(height: Dimensions.height10,),
                  AppTextField(
                    textController: _contactPersonName,
                    hintText: "Tên của bạn",
                    icon: Icons.person,
                  ),
                  SizedBox(height: Dimensions.height20,),
                  Padding(
                    padding: EdgeInsets.only(left: Dimensions.width20),
                    child: BigText(text: "contact_person_number".tr),
                  ),
                  SizedBox(height: Dimensions.height10,),
                  AppTextField(
                    textController: _contactPersonNumber,
                    hintText: "Số của bạn",
                    icon: Icons.phone,
                  ),
                ],
              ),
            ),
          );
        });
      }): Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("img/signintocontinue.png"),
          GestureDetector(
            onTap: () {
              Get.toNamed(RouteHelper.getSignInPage());
            },
            child: Container(
              height: 100,
              margin: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: AppColors.yellowColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BigText(
                      text: "Đăng nhập tại đây!",
                      color: Colors.white,
                    ),
                    Icon(
                      Icons.login,
                      color: Colors.white,
                      size: 30,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<LocationController>(
        builder: (locationController){
          return Container(
           //color: Colors.redAccent,
            height: Dimensions.bottomHeightBar*1.2,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20),
                  topRight: Radius.circular(Dimensions.radius20),
                )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Dimensions.height20*7,
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius30),
                        topRight: Radius.circular(Dimensions.radius30)),
                    color: AppColors.buttonBackgroundColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: (){
                          AddressModel _addressModel = AddressModel(
                            addressType: locationController.addressTypeList[locationController.addressTypeIndex],
                            contactPersonName: _contactPersonName.text,
                            contactPersonNumber: _contactPersonNumber.text,
                            address: _addressController.text,
                            latitude: locationController.position.latitude.toString(),
                            longitude: locationController.position.longitude.toString(),
                          );
                          locationController.addAddress(_addressModel).then((response) {
                            if(response.isSuccess){
                              Get.toNamed(RouteHelper.getInitial());
                              //Get.back();
                              Get.snackbar("address".tr, "Thêm thành công");
                            }else {
                              Get.snackbar("address".tr, "Không thể lưu địa chỉ");
                            }
                          });
                          //controller.addItem(product);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            left: Dimensions.width20,
                            right: Dimensions.width20,
                            bottom: Dimensions.height20,
                            top: Dimensions.height20,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor,
                          ),
                          child: BigText(
                            text: "save_location".tr,
                            size: 26,
                            color: Colors.white,
                          ),

                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.denied) {
      showCustomSnackBar('you_have_to_allow'.tr);
    }else if(permission == LocationPermission.deniedForever) {
      Get.dialog(PermissionDialog());
    }else {
      onTap();
    }
  }


}
