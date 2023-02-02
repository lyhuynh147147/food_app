import 'dart:convert';

import 'package:get/get.dart';
import 'package:ifood_delivery/base/show_custom_snackbar.dart';
import 'package:http/http.dart' as http;
import '../data/repository/splash_repo.dart';
import '../models/config_model.dart';


class SplashController extends GetxController implements GetxService {
  final SplashRepo splashRepo;
  SplashController({required this.splashRepo});

  ConfigModel? _configModel;
  DateTime _currentTime = DateTime.now();
  bool _firstTimeConnectionCheck = true;

  ConfigModel? get configModel => _configModel;
  DateTime get currentTime => DateTime.now();
  bool get firstTimeConnectionCheck => _firstTimeConnectionCheck;

  Future getConfigData() async {
    http.Response response = await splashRepo.getConfigData();
    bool _isSuccess = false;
    if(response.statusCode == 200) {
      _configModel = ConfigModel.fromJson(jsonDecode(response.body));
      _isSuccess = true;
    }else {
      //ApiChecker.checkApi();
      showCustomSnackBar("failed");
      print("My code is "+response.statusCode.toString());
      _isSuccess = false;
    }
    update();
    return _isSuccess;
  }

  Future<bool> initSharedData() {
    return splashRepo.initSharedData();
  }



  void setFirstTimeConnectionCheck(bool isChecked) {
    _firstTimeConnectionCheck = isChecked;
  }

  bool? showIntro() {
    return splashRepo.showIntro();
  }
}