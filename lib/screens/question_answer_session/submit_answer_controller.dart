import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../constants/app_constants.dart';
import '../bottom_bar_screen/bottom_bar_screen.dart';

class SubmitAnswerController extends GetxController {
  RxBool isloading = false.obs;

  Future<File?> compressImage(File file) async {
    final filePath = file.absolute.path;
    final lastIndex = filePath.lastIndexOf('.');
    final targetPath =
        '${filePath.substring(0, lastIndex)}_compressed${filePath.substring(lastIndex)}';

    final result = await FlutterImageCompress.compressAndGetFile(
      filePath,
      targetPath,
      quality: 75, // Adjust the quality as needed (0-100)
    );

    return result != null ? File(result.path) : null;
  }

  Future<bool> submitAnswerFunction(
      String reportId,
      String sectionId,
      String questionId,
      String answer,
      List<File>? imagePikList, // Accept a list of files
      bool isLastIndex,
      String description) async {
    try {
      print('Starting submitAnswerFunction...');
      print('Report ID: $reportId');
      print('Section ID: $sectionId');
      print('Question ID: $questionId');
      print('Answer: $answer');
      print('Number of images to upload: ${imagePikList?.length ?? 0}');
      print('Is last index: $isLastIndex');
      print('description: $description');

      isloading(true);

      // Retrieve token from storage
      var token = GetStorage().read("token");
      print('Retrieved token: $token');

      // Define headers
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };
      print('Headers: $headers');

      // Create multipart request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('${AppConstants.baseUrl}reports/result'),
      );
      print('Request URL: ${request.url}');

      // Add fields to the request
      request.fields['report_id'] = reportId;
      request.fields['section_id'] = sectionId;
      request.fields['question_id'] = questionId;
      request.fields['answer'] = answer;
      request.fields['description'] = description;
      print('Request fields: ${request.fields}');

      // Add multiple images to the request
      if (imagePikList != null && imagePikList.isNotEmpty) {
        print('Adding images to the request...');
        for (var imagePik in imagePikList) {
          print('Processing image: ${imagePik.path}');

          // Compress each image before uploading
          File? compressedImage = await compressImage(imagePik);
          if (compressedImage != null) {
            print('Image compressed successfully: ${compressedImage.path}');
            request.files.add(
              await http.MultipartFile.fromPath(
                "images[]", // Use "images[]" to send multiple files
                compressedImage.path,
              ),
            );
            print('Added image to request: ${compressedImage.path}');
          } else {
            print("Image compression failed for: ${imagePik.path}");
          }
        }
      } else {
        print('No images to upload.');
      }

      // Add headers to the request
      request.headers.addAll(headers);
      print('Request headers: ${request.headers}');

      // Send the request
      print('Sending request...');
      final response = await request.send();
      print('Request sent. Response status code: ${response.statusCode}');

      // Decode the response
      var res =
          jsonDecode(String.fromCharCodes(await response.stream.toBytes()));
      print('Response body: $res');

      isloading(false);

      // Handle the response
      if (response.statusCode == 200) {
        print('Submission successful.');
        print('Response message: ${res['message']}');

        // Show success Snackbar
        Get.snackbar(
          'Message'.tr,
          '${res['message']}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xff1F5077),
          colorText: Colors.white,
        );

        // If this was the last question, navigate to BottomBarScreen
        if (isLastIndex) {
          print('Last question submitted. Navigating to BottomBarScreen...');
          Get.back();
        }

        return true; // Success
      } else {
        print('Submission failed.');
        print('Response message: ${res['message']}');

        // Show error Snackbar
        Get.snackbar(
          'Message'.tr,
          '${res['message']}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xff1F5077),
          colorText: Colors.white,
        );

        return false; // Failure
      }
    } on TimeoutException catch (_) {
      print('Request timed out.');
      isloading(false);

      // Show timeout Snackbar
      Get.snackbar(
        'Message'.tr,
        'Your request timed out.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xff1F5077),
        colorText: Colors.white,
      );

      return false; // Failure
    } catch (error) {
      print('Error occurred: $error');
      isloading(false);

      // Show error Snackbar
      Get.snackbar(
        'Message'.tr,
        '$error',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xff1F5077),
        colorText: Colors.white,
      );

      return false; // Failure
    }
  }
}
