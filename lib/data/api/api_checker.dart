import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as http;
import '../../base/show_custom_snackbar.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/route_helper.dart';

class ApiChecker {
  static void checkApi(Response response) {
    if(response.statusCode == 401) {
      Get.find<AuthController>().clearSharedData();

      Get.offAllNamed(RouteHelper.getSignInPage());
    }else {
      showCustomSnackBar(response.statusText!);
    }
  }
}