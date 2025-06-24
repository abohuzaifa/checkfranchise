import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:franchise_app/screens/category_screen/category_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../question_answer_session/question_answer_view.dart';

class ContinueReportsController extends GetxController {
  RxBool isloading = false.obs;

  Future<void> continueReportsFunction(String requestId, String branchId,
      var data, var sectionId, var sectionName, String email) async {
    print("Step 1: continueReportsFunction is running...");

    // Read Token
    String? token = GetStorage().read('token');
    print("Step 2: Retrieved Token: $token");

    isloading(true);
    print("Step 3: Loading state set to true.");

    try {
      // Printing Request Details
      print("Step 4: Preparing to send request to API.");
      print("Sending request to: ${AppConstants.baseUrl}reports");
      print(
          "Request Headers: { 'Accept': 'application/json', 'Authorization': 'Bearer $token' }");
      print(
          "Request Body: { 'request_id': $requestId, 'branch_id': $branchId }");

      // Sending API Request
      final http.Response response = await http.post(
        Uri.parse("${AppConstants.baseUrl}reports"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "request_id": requestId.toString(),
          "branch_id": branchId.toString(),
        },
      ).timeout(Duration(seconds: 10)); // Timeout Duration

      print("Step 5: Received response from API.");
      print("Raw Response Status Code: ${response.statusCode}");
      print("Raw Response Body: ${response.body}");

      // Decode JSON safely
      Map<String, dynamic> responseData = jsonDecode(response.body);
      print("Step 6: Decoded JSON Response: $responseData");

      // Extract required data safely
      var reportData = responseData;
      print("Report Data============= $reportData");

      // Check if reportData is not empty
      if (reportData.isNotEmpty) {
        print("Step 7: Report data is not empty.");
      } else {
        print("Step 7: Report data is empty.");
      }

      if (response.statusCode == 200) {
        print("Step 8: API response status is 200 (Success).");

        checkNavigation1.value = 1;
        isloading(false);
        print("Step 9: Loading state set to false.");

        // Printing extracted data before navigation
        print("Step 10: Extracted API Response Data:");
        print("Data: $data");
        print("Report Data: $responseData");
        print("Section ID: $sectionId");
        print("Section Name: $sectionName");
        print("Email: $email");

        print("Step 11: Navigating to QuestionAnswerView...");

        Get.to(() => QuestionAnswerView(
              data: data,
              reportData: responseData,
              secionId: sectionId,
              sectionName: sectionName,
              email: email, // Using the email parameter directly
            ));
      } else {
        // Handling API Error Response
        isloading(false);
        print("Step 8: API responded with error.");
        print("Error Response Code: ${response.statusCode}");
        print("Error Response Body: ${response.body}");

        var message = responseData["message"] ?? "Unknown error occurred";
        print("Error Message: $message");

        Get.snackbar(
          'Message'.tr,
          '$message',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xff1F5077),
          colorText: Colors.white,
        );
      }
    } on TimeoutException catch (_) {
      // Handling Timeout Exception
      isloading(false);
      print("Step 8: Request Timed Out.");

      Get.snackbar(
        'Error'.tr,
        'Request Timeout. Please try again.'.tr,
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xff1F5077),
        colorText: Colors.white,
      );
    } catch (error) {
      // Handling Other Exceptions
      isloading(false);
      print("Step 8: Exception Caught: $error");

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
