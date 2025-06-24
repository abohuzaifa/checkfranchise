import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

import '../welcome/welcome_view.dart';


class DeleteAccountController extends GetxController {
  RxBool isloading = false.obs;

  Future<void> deleteAccountFunction() async {
    isloading(true);
    String token = GetStorage().read('token');

    final http.Response response = await http
        .get(Uri.parse("${AppConstants.baseUrl}user/delete"), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      isloading(false);
      print(response.body);
      var responseData = jsonDecode(response.body);
      GetStorage().remove("token");
      Get.offAll(()=> WelcomeView());
      Get.snackbar(
        'Message'.tr,
        'Account Deleted Successfully'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xff1F5077),
        colorText: Colors.white,      );

    } else {
      print('Failed to load Data');
      print(response.body);
      isloading(false);
    }
  }

}
