import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../welcome/welcome_view.dart';


class LogoutController extends GetxController {
  RxBool isloading = false.obs;

  Future<void> logoutFunction() async {
    isloading(true);
    String token = GetStorage().read('token');

    final http.Response response = await http.get(
      Uri.parse("${AppConstants.baseUrl}user/logout"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      isloading(false);
      print(response.body);
      var responseData = jsonDecode(response.body);
      GetStorage().remove("token");
      Get.offAll(() => WelcomeView());

      // Debugging: Print the current locale and translations
      print('Current Locale: ${Get.locale}');
      print('Message: ${'Message'.tr}');
      print('Logout Successfully: ${'Logout Successfully'.tr}');

      Get.snackbar(
        'Message'.tr,
        'Logout Successfully'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xff1F5077),
        colorText: Colors.white,
      );
    } else {
      print('Failed to load Data');
      print(response.body);
      isloading(false);
    }
  }
}
