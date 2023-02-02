import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/base/custom_button.dart';
import 'package:ifood_delivery/utils/dimensions.dart';
import 'package:ifood_delivery/utils/styles.dart';

class PermissionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL)),
      insetPadding: EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: SizedBox(
          width: 500,
          child: Column(mainAxisSize: MainAxisSize.min, children: [

            Icon(Icons.add_location_alt_rounded, color: Theme.of(context).primaryColor, size: 100),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

            Text(
              'you_denied_location_permission'.tr, textAlign: TextAlign.center,
              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
            ),
            SizedBox(height: Dimensions.PADDING_SIZE_LARGE),

            Row(children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL), side: BorderSide(width: 2, color: Theme.of(context).primaryColor)),
                    minimumSize: Size(1, 50),
                  ),
                  child: Text('close'.tr),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Expanded(child: CustomButton(buttonText: 'settings'.tr, onPressed: () async {
                await Geolocator.openAppSettings();
                Navigator.pop(context);
              })),
            ]),

          ]),
        ),
      ),
    );
  }
}