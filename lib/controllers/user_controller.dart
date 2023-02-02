import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ifood_delivery/data/repository/user_repo.dart';
import 'package:ifood_delivery/models/response_model.dart';
import 'package:ifood_delivery/models/user_model.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController implements GetxService{
  final UserRepo userRepo;
  UserController({
    required this.userRepo,
  });

  bool _isLoading = false;
  UserModel? _userModel;

  bool get isLoading =>_isLoading;
  UserModel? get userModel => _userModel;


  Future getUserInfo() async{

    http.Response response = await userRepo.getUserInfo();

    late ResponseModel responseModel;
    if(response.statusCode==200) {
      _userModel = UserModel.fromJson(jsonDecode(response.body));
      _isLoading = true;
      responseModel = ResponseModel(true,"successfully");
    } else {
      print("Did not get");
      responseModel = ResponseModel(false, response.statusCode.toString());
    }
    update();
    return responseModel;
  }



}