import 'dart:convert';

import 'package:get/get.dart';
import 'package:ifood_delivery/models/response_model.dart';
import 'package:http/http.dart' as http;
import '../data/repository/auth_repo.dart';
import '../models/signup_body_model.dart';

class AuthController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo
  });

  bool _isLoading = false;
  bool get isLoading =>_isLoading;

  Future<ResponseModel> registration(SignUpBody signUpBody) async{
    _isLoading = true;
    update();
    http.Response response = await authRepo.registration(signUpBody);

    late ResponseModel responseModel;
    if(response.statusCode==200) {
      print("Backend token");
      Map json = jsonDecode(response.body);
      print(response.statusCode.toString());
      print(json["token"].toString());
      authRepo.saveUserToken(json["token"]);
      responseModel = ResponseModel(true, json["token"]);
    } else {
      print("Backend faile");
      responseModel = ResponseModel(false, response.statusCode.toString());
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> login(String phone, String password) async{


    _isLoading = true;
    //print(authRepo.getUserToken().toString());
    update();
    http.Response response = await authRepo.login(phone, password);

    late ResponseModel responseModel;
    //print(response.statusCode);

    if(response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      authRepo.saveUserToken(json ["token"]);
      responseModel = ResponseModel(true, json["token"]);
    } else {
      responseModel = ResponseModel(false, response.statusCode.toString());
    }
    _isLoading = false;
    update();
    return responseModel;
  }


  void saveUserNumberAndPassword(String number, String password) {
    authRepo.saveUserNumberAndPassword(number, password);
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  bool isLoggedIn() {
    return authRepo.userLoggedIn();
  }
  Future<String> getUserToken() {
    return authRepo.getUserToken();
  }
  Future<void> updateToken() async {
    await authRepo.updateToken();
  }

}