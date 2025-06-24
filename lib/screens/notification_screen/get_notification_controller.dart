import 'dart:convert';

import 'package:franchise_app/constants/app_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';


class GetNotificationController extends GetxController {
  RxBool isloading = false.obs;
 var notificationData;

  Future<void> getNotificationFunction() async {
    isloading(true);
    String token = GetStorage().read('token');
    print('token: $token');

    final http.Response response = await http
        .get(Uri.parse("${AppConstants.baseUrl}notifications"), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      isloading(false);
      print(response.body);
      var responseData = jsonDecode(response.body);
      notificationData = responseData['data'];
      print('This is Notification list length: ${notificationData.length}');

    } else {
      print('Failed to load Data');
      print(response.body);
      isloading(false);
    }
  }

}
