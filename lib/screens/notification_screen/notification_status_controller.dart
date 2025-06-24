import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


class NotificationStatusController extends GetxController{

  RxBool isloading = false.obs;

  // Login Function
  Future<void> notificationStatusFunction(String status,bool check) async {
    print("function is running");
    isloading(true);
    String token = GetStorage().read('token');
    print('token: $token');

    try {
      final http.Response response = await http.post(
        Uri.parse("${AppConstants.baseUrl}user/notification_status"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "status": status.toString(),


        },
      ).timeout(Duration(seconds: 10)); // Set timeout duration here

      print(response.body);
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        isloading(false);
        print(response.body);
        GetStorage().write("checkNotification",check.toString() );


        Get.snackbar(
          'Message'.tr,
          'Update Successfully'.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xff1F5077),
          colorText: Colors.white,

        );
      } else if (response.statusCode == 403) {
        isloading(false);
        print(response.body);
        print(response.statusCode);
        var message = responseData["message"];
        Get.snackbar(
          'Message'.tr,
          '$message',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xff1F5077),
          colorText: Colors.white,
        );
      } else {
        isloading(false);
        print(response.body);
        print(response.statusCode);
        var message = responseData["message"];
        Get.snackbar(
          'Message'.tr,
          '$message',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xff1F5077),
          colorText: Colors.white,
        );
      }
    } on TimeoutException catch (_) {
      isloading(false);
      Get.snackbar(
        'Error'.tr,
        'youTimeOut'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xff1F5077),
        colorText: Colors.white,      );
    } catch (error) {
      // Handle other exceptions
      print('Error: $error');
      isloading(false);
      Get.snackbar(
        'Error'.tr,
        '$error'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xff1F5077),
        colorText: Colors.white,
      );}}

}