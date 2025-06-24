import 'dart:convert';

import 'package:franchise_app/constants/app_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';

class PreviousReportsController extends GetxController {
  RxBool isloading = false.obs;
  var preReportData;

  Future<void> previousReportsFunction() async {
    isloading(true);

    String token = GetStorage().read('token');
    print('Token: $token');

    try {
      final http.Response response = await http.get(
        Uri.parse("${AppConstants.baseUrl}reports/previousReportslist"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Check if the response body is valid JSON
        try {
          var responseData = jsonDecode(response.body);
          preReportData = responseData['data'];
          print('preReportData: $preReportData');
          print('Previous Report data length: ${preReportData.length}');
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
    }
  }}
