import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../category_screen/category_screen.dart';

class ReportResultViewController extends GetxController {
  RxBool isloading = false.obs;

  Future<void> reportResultViewFunction(String Id) async {
    print("reportResultViewFunction is running");

    String token = GetStorage().read('token');
    print("Token: $token");

    isloading(true);

    try {
      print("Sending request to: ${AppConstants.baseUrl}reports/get");
      print(
          "Request Headers: { 'Accept': 'application/json', 'Authorization': 'Bearer $token' }");
      print("Request Body: { 'id': $Id }");

      final http.Response response = await http.post(
        Uri.parse("${AppConstants.baseUrl}reports/get"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "id": Id.toString(),
        },
      ).timeout(Duration(seconds: 10)); // Set timeout duration

      print("Raw Response Status Code: ${response.statusCode}");
      print("Raw Response Body: ${response.body}");

      var responseData = jsonDecode(response.body);
      print("Decoded JSON Response: $responseData");

      if (response.statusCode == 200) {
        isloading(false);

        // Converting response data into Dart object before passing
        var data = responseData["data"];
        print("Converted Data: $data");

        print("Navigating to CategoryScreen with:");
        print("Data: $data");

        Get.to(() => CategoryScreen(
              data: data,
            ));
      } else {
        isloading(false);
        print("Error Response Body: ${response.body}");
        print("Error Response Code: ${response.statusCode}");

        var message = responseData["message"] ?? "Unknown error occurred";
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
      print("Request Timed Out");
      Get.snackbar(
        'Error'.tr,
        'Request Timed Out'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xff1F5077),
        colorText: Colors.white,
      );
    } catch (error) {
      // Handle other exceptions
      isloading(false);
      print("Exception Caught: $error");

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
