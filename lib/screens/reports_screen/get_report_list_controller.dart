import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';


class GetReportListController extends GetxController {
  var reportData;
  RxBool isloading = false.obs;
  RxString errorMessage = ''.obs; // Add this line

  Future<void> getReportListFunction() async {
    if (isloading.value) return;
    isloading(true);
    errorMessage(''); // Clear previous error messages

    String token = GetStorage().read('token');
    print('Token: $token');

    try {
      final http.Response response = await http
          .get(
        Uri.parse("${AppConstants.baseUrl}reports/list"),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      )
          .timeout(const Duration(seconds: 30));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        reportData = responseData['data'];
        print('Report data length: ${reportData.length}');
      } else {
        errorMessage('Failed to load data. Status code: ${response.statusCode}');
        print('Failed to load data. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } on SocketException catch (e) {
      errorMessage('Connection timed out or failed.');
      print('SocketException: $e');
    } on TimeoutException catch (e) {
      errorMessage('Request timed out.');
      print('TimeoutException: $e');
    } catch (e) {
      errorMessage('An error occurred. Please try again.');
      print('Error: $e');
    } finally {
      isloading(false);
    }
  }
}