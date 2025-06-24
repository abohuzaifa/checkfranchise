import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../reset_password/reset_password_view.dart';
import '../your_request/your_request_view.dart';


class OtpController extends GetxController{

  RxBool isloading = false.obs;

  // Login Function
  Future<void> otpFunction(String otp, String email, bool? isCheck) async {
    print("function is running");
    print("Check Email $email");
    print("Check Otp $otp");
    isloading(true);

    try {
      final http.Response response = await http.post(
        Uri.parse("${AppConstants.baseUrl}verify-otp"),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "otp": otp.toString(),
          "email": email.toString(),
        },
      ).timeout(Duration(seconds: 10)); // Set timeout duration here

      print(response.body);
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        isloading(false);
        print(response.body);
        if (isCheck != null){

          Get.offAll(()=> YourRequestView()) ;
        }else{
          Get.offAll(()=> ResetPassword(email: email,)) ;
        }
        Get.snackbar(
          'Message'.tr,
          'Otp Verify Successfully'.tr,
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