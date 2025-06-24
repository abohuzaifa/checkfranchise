import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:franchise_app/screens/login/login_view.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;



class ResetPasswordController extends GetxController{

  RxBool isloading = false.obs;

  // Login Function
  Future<void> resetPasswordFunction( String email,String password, String cPassword) async {
    print("function is running");
    isloading(true);

    try {
      final http.Response response = await http.post(
        Uri.parse("${AppConstants.baseUrl}reset-password"),
        headers: {
          'Accept': 'application/json',
        },
        body: {
          "email": email.toString(),
          "password": password.toString(),
          "password_confirmation": cPassword.toString(),
        },
      ).timeout(Duration(seconds: 10)); // Set timeout duration here

      print(response.body);
      var responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        isloading(false);
        print(response.body);
        Get.offAll(()=> LoginView());

        Get.snackbar(
          'Message'.tr,
          'Reset Password Successfully'.tr,
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