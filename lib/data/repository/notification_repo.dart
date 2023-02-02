import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_constants.dart';
import '../api/api_client.dart';
class NotificationRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;
  NotificationRepo({required this.apiClient, required this.sharedPreferences});

  Future getNotificationList() async {
    return await apiClient.getData(AppConstants.NOTIFICATION_URI);
  }

  void saveSeenNotificationCount(int count) {
    sharedPreferences.setInt(AppConstants.NOTIFICATION_COUNT, count);
  }

  int? getSeenNotificationCount() {
    return sharedPreferences.getInt(AppConstants.NOTIFICATION_COUNT);
  }

}