import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:franchise_app/screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:franchise_app/screens/question_answer_session/exit_report_controller.dart';
import 'package:franchise_app/screens/question_answer_session/submit_answer_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../constants/app_constants.dart';

class QuestionAnswerView extends StatefulWidget {
  var data;
  var reportData;
  var secionId;
  var sectionName;
  var email;

  QuestionAnswerView(
      {super.key,
      this.data,
      this.reportData,
      this.secionId,
      this.sectionName,
      this.email});

  @override
  State<QuestionAnswerView> createState() => _QuestionAnswerViewState();
}

class _QuestionAnswerViewState extends State<QuestionAnswerView> {
  Set<int> answeredIndices = {}; // Store answered question indexes
  RxBool isloading = false.obs;
  String? saveAnswer;
  int answerCount = 0;
  ExitReportController exitReportController = Get.put(ExitReportController());
  SubmitAnswerController submitAnswerController =
      Get.put(SubmitAnswerController());
  Map<int, String> notes = {};

  final ImagePicker _picker = ImagePicker();

  // Initialize capturedImages as a List of Lists to store multiple images for each index
  List<List<XFile>> capturedImages =
      List.generate(10, (_) => []); // Adjust the size as needed

// Update the captureImage function to append new images
  Future<bool> captureImage(int index) async {
    // Log the start of the image capture process
    print('Starting image capture for index: $index');

    // Check if the capturedImages list is initialized and the index is valid
    if (capturedImages == null || index < 0 || index >= capturedImages.length) {
      print('Error: Invalid index or capturedImages list is not initialized.');
      return false;
    }

    final ImagePicker picker = ImagePicker();
    XFile? image;

    try {
      // Attempt to capture an image
      image = await picker.pickImage(source: ImageSource.camera);

      if (image != null) {
        // Log successful image capture
        print('Image captured successfully for index: $index');

        // Update the state to add the new image to the list
        setState(() {
          capturedImages[index].add(image!);
        });

        return true; // Image captured successfully
      } else {
        // Log that no image was captured
        print('No image captured for index: $index');
        return false; // No image captured
      }
    } catch (e) {
      // Log any exceptions that occur during image capture
      print('Exception occurred while capturing image for index: $index');
      print('Exception details: $e');

      // Optionally, you can show an error message to the user
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Failed to capture image: ${e.toString()}')),
      // );

      return false; // Image capture failed
    }
  }

  List<int> selectedButtonIndexes =
      List.filled(10, -1); // To track the selected button index
  int checkNext = -1; // To track the selected button index

  void _openEmailDialog(BuildContext context, String reportId, String email) {
    TextEditingController emailController = TextEditingController(text: email);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          shadowColor: Colors.black54,
          title: Text(
            'Send Report',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter your email',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Icon(Icons.email, color: Colors.blueGrey),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email cannot be empty';
                } else if (!RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}")
                    .hasMatch(value)) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Obx(() {
              return isloading.value
                  ? Center(child: CircularProgressIndicator())
                  : TextButton(
                      child: Text('Send', style: TextStyle(color: Colors.blue)),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          bool success = await sendReportLinkFunction(
                            reportId: reportId,
                            email: emailController.text,
                          );
                          if (success) {
                            Get.offAll(BottomBarScreen());
                          } else {
                            Get.snackbar(
                              'Error',
                              'Failed to send report.',
                              snackPosition: SnackPosition.TOP,
                              backgroundColor: Colors.red,
                              colorText: Colors.white,
                            );
                          }
                        }
                      },
                    );
            }),
          ],
        );
      },
    );
  }

  Future<bool> sendReportLinkFunction({
    required String reportId,
    required String email,
  }) async {
    try {
      print('Starting sendReportLinkFunction...');

      // Start loading indicator
      isloading(true);
      print('Setting loading state to true');

      // Retrieve token from local storage
      var token = GetStorage().read("token");
      print('Retrieved token: $token');

      // Define headers
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json', // Ensure correct content type
      };
      print('Headers: $headers');

      // Define the API endpoint
      final url = Uri.parse('${AppConstants.baseUrl}send-report');
      print('API URL: $url');

      // Create the request body
      final Map<String, dynamic> requestBody = {
        'id': reportId.trim(),
        'email': email.trim(),
      };

      print('Request body: $requestBody');

      // Make the POST request
      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      print('Response received: ${response.statusCode}');
      print('Response body: ${response.body}');

      // Stop loading indicator
      isloading(false);
      print('Setting loading state to false');

      // **Handle response format**
      dynamic res;
      try {
        res = jsonDecode(response.body);
      } catch (e) {
        res = response.body; // Fallback to plain text response
      }

      if (response.statusCode == 200) {
        print('Request successful, showing success message');
        Get.snackbar(
          'Message'.tr,
          res is Map<String, dynamic> ? '${res['message']}' : res.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xff1F5077),
          colorText: Colors.white,
        );

        return true; // Success
      } else {
        print('Request failed, showing error message');
        Get.snackbar(
          'Message'.tr,
          res is Map<String, dynamic> ? '${res['message']}' : res.toString(),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Color(0xff1F5077),
          colorText: Colors.white,
        );
        return false; // Failure
      }
    } on TimeoutException catch (_) {
      print('TimeoutException caught');
      isloading(false);
      Get.snackbar(
        'Message'.tr,
        'Your request timed out',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xff1F5077),
        colorText: Colors.white,
      );
      return false;
    } catch (error) {
      print('Exception caught: $error');
      isloading(false);
      Get.snackbar(
        'Message'.tr,
        '$error',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Color(0xff1F5077),
        colorText: Colors.white,
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF1F5077),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => submitAnswerController.isloading.value ||
                    exitReportController.isloading.value
                ? Container(
                    height: h,
                    width: w,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      // Header
                      Container(
                        margin:
                            EdgeInsets.only(top: h * 0.06, left: 20, right: 20),
                        child: Row(
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                  size: 16,
                                )),
                            SizedBox(
                              width: w * 0.01,
                            ),
                            Text(
                              widget.sectionName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Alexandria',
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      // Main Container
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(top: h * 0.03),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: h * 0.03),
                            // Navigation Row
                            Container(
                              height: h * 0.05,
                              margin: EdgeInsets.only(
                                  left: w * 0.08, right: w * 0.08),
                              padding: EdgeInsets.only(
                                  left: w * 0.02, right: w * 0.02),
                              decoration: BoxDecoration(
                                color: Color(0xFF29ABE2),
                                borderRadius: BorderRadius.circular(22.5),
                              ),
                              child: Row(
                                children: [
                                  // Left Arrow Container
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF19B2E7),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Colors.white,
                                        size: 20,
                                      )),
                                  // Middle Expanded Container
                                  Expanded(
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF1F5077),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${"answered".tr} $answerCount/${widget.data.length}'
                                            .tr,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Alexandria',
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Right Arrow Container
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFF19B2E7),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 20,
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: h * 0.03),

                            Container(
                              margin: EdgeInsets.only(
                                  right: w * 0.05, left: w * 0.05),
                              height: h * 0.002,
                              color: Color(0xff1F5077).withOpacity(0.11),
                            ),

                            SizedBox(height: h * 0.03),

                            Container(
                              margin: EdgeInsets.only(
                                  right: w * 0.05, left: w * 0.05),
                              padding: EdgeInsets.only(
                                  top: h * 0.02, bottom: h * 0.05),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xffF3F7FC).withOpacity(0.6),
                              ),
                              child: ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: widget.data.length,
                                itemBuilder: (context, index) {
                                  // Safely access widget.data[index]
                                  var questionData = widget.data[index] ?? {};
                                  var resultData =
                                      questionData.containsKey('result')
                                          ? questionData['result']
                                          : {};

                                  // Handle null or missing data for selectedButtonIndexes
                                  if (resultData != null &&
                                      resultData.containsKey('answer')) {
                                    if (resultData['answer'] ==
                                        questionData['answer1']) {
                                      selectedButtonIndexes[index] = 0;
                                    } else if (resultData['answer'] ==
                                        questionData['answer2']) {
                                      selectedButtonIndexes[index] = 1;
                                    } else if (resultData['answer'] ==
                                        questionData['answer3']) {
                                      selectedButtonIndexes[index] = 2;
                                    }
                                  }

                                  // Handle attachments
                                  List<String> attachments = [];
                                  if (resultData != null &&
                                      resultData['attachments'] != null) {
                                    try {
                                      attachments = List<String>.from(
                                          jsonDecode(
                                              resultData['attachments']));
                                    } catch (e) {
                                      print(
                                          'Error decoding attachments at index $index: $e');
                                    }
                                  }

                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Column(
                                      children: [
                                        // Question Text
                                        Container(
                                          width: w,
                                          child: Text(
                                            '${index + 1}. ${questionData['question'] ?? 'No question available'}',
                                            style: TextStyle(
                                              color: Color(0xFF93C3E6)
                                                  .withOpacity(0.95),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'Alexandria',
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: h * 0.02),

                                        // Buttons Row
                                        Container(
                                          height: 40,
                                          width: w,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            children: [
                                              Row(
                                                children: [
                                                  for (int i = 0; i < 3; i++)
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 8.0),
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          if (questionData !=
                                                              null) {
                                                            setState(() {
                                                              selectedButtonIndexes[
                                                                  index] = i;
                                                              saveAnswer = questionData[
                                                                      'answer${i + 1}'] ??
                                                                  'Not Available';
                                                            });

                                                            // Capture image and handle potential errors
                                                            if (!widget.data[0]
                                                                .containsKey(
                                                                    'result')) {
                                                              bool
                                                                  isImageCaptured =
                                                                  await captureImage(
                                                                      index);
                                                              if (!isImageCaptured) {
                                                                print(
                                                                    'Failed to capture image for index: $index');
                                                              }
                                                            }
                                                          } else {
                                                            print(
                                                                'Data at index $index is null');
                                                          }
                                                        },
                                                        child: buildButton(
                                                          text: questionData[
                                                                  'answer${i + 1}'] ??
                                                              'Not Available',
                                                          isSelected:
                                                              selectedButtonIndexes[
                                                                      index] ==
                                                                  i,
                                                          h: h,
                                                          w: w * 0.8,
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20),

                                        // Camera Container
                                        questionData.containsKey('result')
                                            ? Container(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        attachments.isNotEmpty
                                                            ? GestureDetector(
                                                                onTap: () {
                                                                  // Open the image in full screen
                                                                  showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (BuildContext
                                                                            context) {
                                                                      return Dialog(
                                                                        insetPadding:
                                                                            EdgeInsets.all(10),
                                                                        child:
                                                                            Stack(
                                                                          children: [
                                                                            // Full-screen image
                                                                            InteractiveViewer(
                                                                              panEnabled: true,
                                                                              minScale: 0.5,
                                                                              maxScale: 4,
                                                                              child: Image.network(
                                                                                "https://checkfranchise.net/${attachments[0]}",
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                            ),
                                                                            // Back button
                                                                            Positioned(
                                                                              top: 10,
                                                                              right: 10,
                                                                              child: IconButton(
                                                                                icon: Icon(
                                                                                  Icons.close,
                                                                                  color: Colors.white,
                                                                                  size: 30,
                                                                                ),
                                                                                onPressed: () {
                                                                                  Navigator.of(context).pop();
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      h * 0.1,
                                                                  width:
                                                                      w * 0.2,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30),
                                                                  ),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    child:
                                                                        Stack(
                                                                      alignment:
                                                                          Alignment
                                                                              .center,
                                                                      children: [
                                                                        CupertinoActivityIndicator(),
                                                                        Image
                                                                            .network(
                                                                          "https://checkfranchise.net/${attachments[0]}",
                                                                          fit: BoxFit
                                                                              .contain,
                                                                          loadingBuilder: (context,
                                                                              child,
                                                                              loadingProgress) {
                                                                            if (loadingProgress ==
                                                                                null)
                                                                              return child;
                                                                            return CupertinoActivityIndicator();
                                                                          },
                                                                          errorBuilder: (context,
                                                                              error,
                                                                              stackTrace) {
                                                                            return Icon(
                                                                              Icons.broken_image,
                                                                              size: 40,
                                                                              color: Colors.grey,
                                                                            );
                                                                          },
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Icon(
                                                                Icons
                                                                    .image_not_supported,
                                                                size: 40,
                                                                color:
                                                                    Colors.grey,
                                                              ),
                                                      ],
                                                    ),
                                                    // Display Description
                                                    // Display Description
                                                    if (resultData != null &&
                                                        resultData[
                                                                'description'] !=
                                                            null)
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: h * 0.02),
                                                        width: w,
                                                        child: Text(
                                                          resultData[
                                                              'description'],
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                'Alexandria',
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              )
                                            : SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: [
                                                    // Display all captured images for this index
                                                    if (capturedImages[index]
                                                        .isNotEmpty)
                                                      Row(
                                                        children:
                                                            capturedImages[
                                                                    index]
                                                                .map((image) {
                                                          return Container(
                                                            height: h * 0.1,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: h *
                                                                        0.01,
                                                                    left: w *
                                                                        0.01),
                                                            width: w * 0.2,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child: Stack(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                children: [
                                                                  Image.file(
                                                                    File(image
                                                                        .path),
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    height:
                                                                        h * 0.1,
                                                                  ),
                                                                  Icon(
                                                                    Icons
                                                                        .check_circle,
                                                                    color: Colors
                                                                        .green,
                                                                    size: 24,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        }).toList(),
                                                      ),
                                                    SizedBox(width: w * 0.01),

                                                    // Add Image Button
                                                    GestureDetector(
                                                      onTap: () async {
                                                        await captureImage(
                                                            index);
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        width: w * 0.18,
                                                        height: h * 0.042,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    w * 0.04),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical:
                                                                    h * 0.01),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xff1F5077),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black26
                                                                  .withOpacity(
                                                                      0.1),
                                                              blurRadius: 1,
                                                              offset:
                                                                  Offset(1, 1),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Icon(Icons.add,
                                                                color: Colors
                                                                    .white,
                                                                size: 16),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              'add'.tr,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'Alexandria',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    // Add Notes Button
                                                    GestureDetector(
                                                      onTap: () async {
                                                        String? note =
                                                            await showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            String inputText =
                                                                notes[index] ??
                                                                    '';
                                                            return AlertDialog(
                                                              title: Text(
                                                                  'Add Notes'
                                                                      .tr),
                                                              content:
                                                                  TextField(
                                                                controller:
                                                                    TextEditingController(
                                                                        text:
                                                                            inputText),
                                                                maxLines: 5,
                                                                decoration:
                                                                    InputDecoration(
                                                                  hintText:
                                                                      'Write your notes here...'
                                                                          .tr,
                                                                  border:
                                                                      OutlineInputBorder(),
                                                                ),
                                                                onChanged:
                                                                    (value) {
                                                                  inputText =
                                                                      value;
                                                                },
                                                              ),
                                                              actions: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context,
                                                                        inputText);
                                                                  },
                                                                  child: Text(
                                                                      'Save'
                                                                          .tr),
                                                                ),
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      'Cancel'
                                                                          .tr),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );

                                                        if (note != null) {
                                                          setState(() {
                                                            notes[index] = note;
                                                          });
                                                        }
                                                      },
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                            left: w * 0.02),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 10,
                                                                vertical: 5),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xff1F5077),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Icon(
                                                              Icons.note_add,
                                                              color:
                                                                  Colors.white,
                                                              size: 16,
                                                            ),
                                                            SizedBox(width: 5),
                                                            Text(
                                                              'Add Notes'.tr,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontFamily:
                                                                    'Alexandria',
                                                              ),
                                                            ),
                                                            if (notes.containsKey(
                                                                    index) &&
                                                                notes[index]!
                                                                    .isNotEmpty)
                                                              Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Colors
                                                                    .green,
                                                                size: 16,
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),

                                        // Submit Button for Each Question
                                        if (!questionData.containsKey('result'))
                                          GestureDetector(
                                            onTap: () async {
                                              if (index > 0 &&
                                                  !answeredIndices
                                                      .contains(index - 1)) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        "Please answer the previous question first!"),
                                                  ),
                                                );
                                                return;
                                              }

                                              if (capturedImages[index]
                                                  .isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                        "Please upload at least one image!"),
                                                  ),
                                                );
                                                return;
                                              }

                                              bool success =
                                                  await submitAnswerController
                                                      .submitAnswerFunction(
                                                widget.reportData['report']
                                                        ['id']
                                                    .toString(),
                                                widget.secionId.toString(),
                                                questionData['id'].toString(),
                                                saveAnswer.toString(),
                                                capturedImages[index].isNotEmpty
                                                    ? capturedImages[index]
                                                        .map((image) =>
                                                            File(image.path))
                                                        .toList()
                                                    : null,
                                                index == widget.data.length - 1,
                                                notes[index].toString(),
                                              );

                                              if (success) {
                                                setState(() {
                                                  answeredIndices.add(index);
                                                });
                                              } else {
                                                Get.snackbar(
                                                  'Error',
                                                  'Submission failed. Please try again.',
                                                  snackPosition:
                                                      SnackPosition.BOTTOM,
                                                  duration:
                                                      Duration(seconds: 3),
                                                  backgroundColor: Colors.red,
                                                  colorText: Colors.white,
                                                  borderRadius: 10,
                                                  margin: EdgeInsets.all(10),
                                                );
                                              }
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: w * 0.3,
                                              height: h * 0.05,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: h * 0.02),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: h * 0.01),
                                              decoration: BoxDecoration(
                                                color: Color(0xff1F5077),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black26
                                                        .withOpacity(0.1),
                                                    blurRadius: 1,
                                                    offset: Offset(1, 1),
                                                  ),
                                                ],
                                              ),
                                              child: Text(
                                                'submit'.tr,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Alexandria',
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        right: w * 0.01, left: w * 0.01),
                                    height: h * 0.002,
                                    color: Color(0xff1F5077).withOpacity(0.11),
                                  );
                                },
                              ),
                            ),
                            SizedBox(height: h * 0.08),
                            Container(
                              margin: EdgeInsets.only(
                                  right: w * 0.05, left: w * 0.08),
                              height: h * 0.002,
                              color: Color(0xff1F5077).withOpacity(0.11),
                            ),
                            SizedBox(height: h * 0.05),

                            widget.data[0].containsKey('result')
                                ? Container()
                                : GestureDetector(
                                    onTap: () {
                                      exitReportController.exitReportFunction(
                                          widget.reportData['report']['id']
                                              .toString());
                                    },
                                    child: Container(
                                      width: w / 2,
                                      padding: EdgeInsets.only(
                                          top: h * 0.01,
                                          bottom: h * 0.01,
                                          left: w * 0.15,
                                          right: w * 0.15),
                                      decoration: BoxDecoration(
                                        color: Color(0xffE51D1D),
                                        // Yellow background for the first container
                                        borderRadius: BorderRadius.circular(
                                            20), // Rounded corners
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Continue Icon
                                          Image.asset(
                                            'assets/images/exit_img.png',
                                            width: 20,
                                            height: 20,
                                            fit: BoxFit.contain,
                                          ),
                                          SizedBox(
                                              width: w *
                                                  0.02), // Space between icon and text
                                          // Continue Text
                                          Text(
                                            'exit'.tr,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                              color: Colors.white, // Text color
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     checkNext == 1
                            //         ? answerCount == widget.data.length
                            //             ?
                            //     GestureDetector(
                            //                 onTap: () {
                            //                   exitReportController
                            //                       .exitReportFunction(widget
                            //                           .reportData['id']
                            //                           .toString());
                            //                 },
                            //                 child: Container(
                            //                   padding: EdgeInsets.only(
                            //                       top: h * 0.01,
                            //                       bottom: h * 0.01,
                            //                       left: w * 0.15,
                            //                       right: w * 0.15),
                            //                   decoration: BoxDecoration(
                            //                     color: Color(0xffE51D1D),
                            //                     // Yellow background for the first container
                            //                     borderRadius:
                            //                         BorderRadius.circular(
                            //                             20), // Rounded corners
                            //                   ),
                            //                   child: Row(
                            //                     mainAxisAlignment:
                            //                         MainAxisAlignment.center,
                            //                     children: [
                            //                       // Continue Icon
                            //                       Image.asset(
                            //                         'assets/images/exit_img.png',
                            //                         width: 20,
                            //                         height: 20,
                            //                         fit: BoxFit.contain,
                            //                       ),
                            //                       SizedBox(
                            //                           width: w *
                            //                               0.02), // Space between icon and text
                            //                       // Continue Text
                            //                       Text(
                            //                         'exit'.tr,
                            //                         style: TextStyle(
                            //                           fontWeight:
                            //                               FontWeight.w500,
                            //                           fontSize: 16,
                            //                           color: Colors
                            //                               .white, // Text color
                            //                         ),
                            //                       ),
                            //                     ],
                            //                   ),
                            //                 ),
                            //               )
                            //
                            //             : SizedBox()
                            //         : GestureDetector(
                            //             onTap: () {
                            //               setState(() {
                            //                 checkNext = 1;
                            //               });
                            //             },
                            //             child: Container(
                            //               padding: EdgeInsets.only(
                            //                   top: h * 0.01,
                            //                   bottom: h * 0.01,
                            //                   left: w * 0.15,
                            //                   right: w * 0.15),
                            //               decoration: BoxDecoration(
                            //                 color: Color(0xff3A8E2B),
                            //                 // Yellow background for the first container
                            //                 borderRadius: BorderRadius.circular(
                            //                     20), // Rounded corners
                            //               ),
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.center,
                            //                 children: [
                            //                   // Continue Icon
                            //                   Image.asset(
                            //                     'assets/images/next_img.png',
                            //                     width: 20,
                            //                     height: 20,
                            //                     fit: BoxFit.contain,
                            //                   ),
                            //                   SizedBox(
                            //                       width: w *
                            //                           0.02), // Space between icon and text
                            //                   // Continue Text
                            //                   Text(
                            //                     'Next',
                            //                     style: TextStyle(
                            //                       fontWeight: FontWeight.w500,
                            //                       fontSize: 16,
                            //                       color: Colors
                            //                           .white, // Text color
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //           ),
                            //   ],
                            // ),

                            // SizedBox(height: h * 0.02),
                            // widget.data[0].containsKey('result')
                            //     ?
                            //     InkWell(
                            //         onTap: () {
                            //           print(
                            //               "widget.reportData['id']========${widget.reportData['id']}");
                            //           _openEmailDialog(
                            //             context,
                            //             widget.reportData['id'].toString(),
                            //             widget.email,
                            //           );
                            //         },
                            //         child: Container(
                            //           margin: EdgeInsets.only(
                            //               left: 20, right: 20, bottom: 20),
                            //           decoration: BoxDecoration(
                            //               color: Color(0xff1F5077),
                            //               borderRadius:
                            //                   BorderRadius.circular(20)),
                            //           height: 45,
                            //           width: MediaQuery.of(context).size.width,
                            //           child: Center(
                            //             child: Text(
                            //               'Send Report',
                            //               style: TextStyle(
                            //                   fontSize: 16,
                            //                   color: Colors.white,
                            //                   fontFamily: 'Alexandria'),
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     : SizedBox()
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildButton({
    required String text,
    required bool isSelected,
    required double h,
    required double w,
  }) {
    return Container(
      width: w / 3,
      height: h,
      margin: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xff1F5077) : Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          text, // This will display "Not Available" if the value is null
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}
