import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../bottom_bar_screen/bottom_bar_screen.dart';

class LoginController extends GetxController {
  RxBool isloading = false.obs;

  Future<void> loginFunction(String password, String mobile) async {
    print("Function is running");
    print("FCM Token: ${fcmToken!}");

    isloading(true);

    // Creating the request body
    Map<String, String> requestBody = {
      "email": mobile.toString(),
      "password": password.toString(),
      "user_type": "1",
      "fcmToken": fcmToken!,
    };

    // Printing the request body
    print("Request Body: ${jsonEncode(requestBody)}");

    try {
      final http.Response response = await http.post(
        Uri.parse("${AppConstants.baseUrl}login"),
        headers: {
          'Accept': 'application/json',
        },
        body: requestBody,
      ).timeout(Duration(seconds: 10)); // Set timeout duration here

      print("Response Body: ${response.body}");
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        isloading(false);
        var token = responseData['token'];
        var name = responseData['user']['name'];
        var mobile = responseData['user']['mobile'];
        print("This is my token: $token");

        GetStorage().write("token", token);
        GetStorage().write("name", name);
        GetStorage().write("mobile", mobile);

        Get.offAll(() => BottomBarScreen());

        Get.snackbar(
          'Message'.tr,
          'Login Successfully'.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xff1F5077),
          colorText: Colors.white,
        );
      } else {
        isloading(false);
        print("Error Response: ${response.body}");

        // Handle specific error messages or validation errors
        if (responseData.containsKey("errors")) {
          // If the response contains validation errors
          var errors = responseData["errors"];
          errors.forEach((key, value) {
            Get.snackbar(
              'Error'.tr,
              '$value',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Color(0xff1F5077),
              colorText: Colors.white,
            );
          });
        } else if (responseData.containsKey("message")) {
          // If the response contains a general error message
          var message = responseData["message"];
          Get.snackbar(
            'Error'.tr,
            '$message',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Color(0xff1F5077),
            colorText: Colors.white,
          );
        } else {
          // If the response does not contain any specific error message
          Get.snackbar(
            'Error'.tr,
            'An unexpected error occurred'.tr,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Color(0xff1F5077),
            colorText: Colors.white,
          );
        }
      }
    } on TimeoutException catch (_) {
      isloading(false);
      Get.snackbar(
        'Error'.tr,
        'Request Timed Out'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xff1F5077),
        colorText: Colors.white,
      );
    } catch (error) {
      print('Error: $error');
      isloading(false);
      Get.snackbar(
        'Error'.tr,
        'An unexpected error occurred: $error'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xff1F5077),
        colorText: Colors.white,
      );
    }
  }}
