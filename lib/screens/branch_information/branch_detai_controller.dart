import 'dart:convert';

import 'package:franchise_app/constants/app_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class BranchDetailController extends GetxController {
  RxBool isloading = false.obs;
  var branchDetailData;

  Future<void> branchDetailFunction(String id) async {
    isloading(true);
    String token = GetStorage().read('token');

    final http.Response response = await http
        .get(Uri.parse("${AppConstants.baseUrl}branches/$id"), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    if (response.statusCode == 200) {
      isloading(false);
      print(response.body);
      branchDetailData = jsonDecode(response.body);
    } else {
      print('Failed to load Data');
      print(response.body);
      isloading(false);
    }
  }
}
