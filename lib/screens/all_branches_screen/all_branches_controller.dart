import 'dart:convert';

import 'package:franchise_app/constants/app_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class AllBranchesController extends GetxController {
  RxBool isloading = false.obs;
  List branchesData = [];

  Future<void> allBranchesFunction() async {
    print('Starting allBranchesFunction...');
    isloading(true);
    print('Loading state set to true.');

    String token = GetStorage().read('token');
    print('Token read from storage: $token');

    try {
      print('Making HTTP GET request to ${AppConstants.baseUrl}branches...');
      final http.Response response = await http.get(
        Uri.parse("${AppConstants.baseUrl}branches"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print('HTTP GET request completed.');

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Check if the response body is valid JSON
        try {
          var responseData = jsonDecode(response.body);
          print('Response data decoded: $responseData');

          branchesData = responseData['data'];
          print('branchesData updated with response data.');
        } catch (e) {
          print('Error decoding JSON: $e');
          print('Invalid JSON response: ${response.body}');
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Error making HTTP request: $e');
    } finally {
      isloading(false);
      print('Loading state set to false.');
    }
    print('allBranchesFunction completed.');
  }
}
