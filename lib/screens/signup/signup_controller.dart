import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../main.dart';
import '../otp/otp_view.dart';
import 'package:get_storage/get_storage.dart';

class SignupController extends GetxController {
  RxBool isloading = false.obs;

  Future<void> signupFunction(
    String password,
    String mobile,
    String name,
    String cPassword,
    String email,
  ) async {
    print("Function is running");
    isloading(true);

    // Creating the request body
    Map<String, String> requestBody = {
      "name": name.toString(),
      "email": email.toString(),
      "mobile": mobile.toString(),
      "password": password.toString(),
      "password_confirmation": cPassword.toString(),
      "user_type": "1",
      "fcmToken": fcmToken!,
    };

    // Printing the request body
    print("Request Body: ${jsonEncode(requestBody)}");

    try {
      final http.Response response = await http
          .post(
            Uri.parse("${AppConstants.baseUrl}register"),
            headers: {
              'Accept': 'application/json',
            },
            body: requestBody,
          )
          .timeout(Duration(seconds: 10)); // Set timeout duration here

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

        Get.offAll(
          () => OtpView(
            isCheck: true,
            email: email,
          ),
        );

        Get.snackbar(
          'Message'.tr,
          'Otp Code Successfully Sent'.tr,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xff1F5077),
          colorText: Colors.white,
        );
      } else {
        isloading(false);
        print("Error Response: ${response.body}");
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
        '$error'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xff1F5077),
        colorText: Colors.white,
      );
    }
  }
}
