import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:franchise_app/screens/category_screen/category_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;


class BranchApprovalCodeController extends GetxController{

  RxBool isloading = false.obs;
  var data;

    Future<void> branchApprovalCodeFunction(String code, String branchId) async {
    print("branchApprovalCodeFunction is running");
    String token = GetStorage().read('token');
    print("token: $token");
    isloading(true);

    try {
      final http.Response response = await http.post(
        Uri.parse("${AppConstants.baseUrl}branches/getCodeApproval"),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          "code": code.toString(),
          "branch_id": branchId.toString(),
        },
      ).timeout(Duration(seconds: 10)); // Set timeout duration here

      print('response.body in getCodeApproval======${response.body}');
      var responseData = jsonDecode(response.body);

      print(response.statusCode);
      if (response.statusCode == 200) {
        isloading(false);
        print(response.body);
        if(responseData['status']==0){
          Get.snackbar(
            'Message'.tr,
            '${responseData['msg']}',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Color(0xff1F5077),
            colorText: Colors.white,
          );
        }else{
          data = responseData["data"];

          Get.to(()=> CategoryScreen(data: data,));
        }
        
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