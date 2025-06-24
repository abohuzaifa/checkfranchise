import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:franchise_app/screens/category_screen/continue_reports_controller.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../constants/app_constants.dart';
import '../notification_screen/notification_screen.dart';
import '../question_answer_session/question_answer_view.dart';

class CategoryScreen extends StatefulWidget {
  var data;

  CategoryScreen({super.key, this.data});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int checkIndex = -1;
  var selectedData;
  var selectedId;
  var selectedName;
  ContinueReportsController continueReportsController =
      Get.put(ContinueReportsController());
  TextEditingController searchController = TextEditingController();
  List<dynamic> filteredSections = [];

  String currentDate = '';

  @override
  void initState() {
    super.initState();
    print('widget.data===${widget.data}');

    // Parse the JSON string into a List<dynamic>
    List<dynamic> questionIdsDynamic = jsonDecode(widget.data['request']['questions']);

    // Convert the List<dynamic> to List<String>
    List<String> questionIds = questionIdsDynamic.map((e) => e.toString()).toList();

    // Initialize filteredSections to store sections with filtered questions
    filteredSections = [];

    // Loop through sections to filter questions based on questionIds
    for (var section in widget.data['sections']) {
      // Filter questions in the current section
      List<dynamic> filteredQuestions = section['questions']
          .where((question) => questionIds.contains(question['id'].toString()))
          .toList();

      // If the section has any matching questions, add it to filteredSections
      if (filteredQuestions.isNotEmpty) {
        // Create a new section map with the filtered questions
        Map<String, dynamic> filteredSection = Map.from(section);
        filteredSection['questions'] = filteredQuestions;
        filteredSections.add(filteredSection);
      }
    }

    // Print the filtered sections for debugging
    print('filteredSections===${filteredSections}');

    // Print the token for debugging
    print("This is get token ${GetStorage().read("token")}");

    // Format the current date
    currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }
  void filterSearchResults(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredSections = widget.data['sections'];
      } else {
        filteredSections = widget.data['sections']
            .where((section) => section['name']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale? currentLocale = Get.locale;

    // Extract the language code (e.g., 'en', 'es')
    String languageCode = currentLocale?.languageCode ?? 'en';
    print("Language Code: $languageCode");
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF3F7FC),
      body: Obx(
        () => continueReportsController.isloading.value
            ? Container(
                height: h,
                width: w,
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: h * 0.05,
                    ),
                    Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: Row(
                        children: [
                          Container(
                              height: h * 0.16,
                              child: Image.asset(
                                  "assets/images/blue_logo_img.png")),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => NotificationScreen());
                            },
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Image.asset(
                                  "assets/images/notification_img.png"),
                            ),
                          ),
                          SizedBox(
                            width: w * 0.06,
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: h * 0.01),
                      padding: EdgeInsets.only(left: w * 0.06, right: w * 0.06),
                      decoration: BoxDecoration(
                          // color: Colors.black,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                          color: Color(0xffFFFFFF)),
                      // padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          SizedBox(height: h * 0.03),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // First Container
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF507799),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: w * 0.02,
                                      right: w * 0.02,
                                      top: h * 0.01,
                                      bottom: h * 0.01),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 22, // Reduced width
                                        height: 22, // Reduced height
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // White background for the wrapping container
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          // Adjusted rounded corners
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              blurRadius: 4,
                                              // Slightly smaller blur
                                              spreadRadius: 1,
                                              // Reduced spread
                                              offset: Offset(0,
                                                  2), // Adjusted shadow position
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/profileIcon.png',
                                            width: 16,
                                            // Reduced width for the image
                                            height: 16,
                                            // Reduced height for the image
                                            fit: BoxFit.contain,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.error,
                                                color: Colors.red,
                                                size: 20, // Smaller error icon
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: w * 0.04),
                                      Text(
                                        '${GetStorage().read('name')}',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Second Container
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF93C3E6),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: w * 0.02,
                                      right: w * 0.02,
                                      top: h * 0.01,
                                      bottom: h * 0.01),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 22, // Reduced width
                                        height: 22, // Reduced height
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // White background for the wrapping container
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          // Adjusted rounded corners
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              blurRadius: 4,
                                              // Slightly smaller blur
                                              spreadRadius: 1,
                                              // Reduced spread
                                              offset: Offset(0,
                                                  2), // Adjusted shadow position
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/calenderIcon.png',
                                            width: 16,
                                            // Reduced width for the image
                                            height: 16,
                                            // Reduced height for the image
                                            fit: BoxFit.contain,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.error,
                                                color: Colors.red,
                                                size: 16, // Smaller error icon
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: w * 0.02),
                                      Text(
                                        '$currentDate',
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'Alexandria',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: h * 0.025),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 0.5,
                            color: Color(0xff1F5077).withOpacity(0.2),
                          ),
                          SizedBox(height: h * 0.025),
                          Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Color(0xFFE5EFF9),
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(Icons.search,
                                      color: Colors.grey, size: 20),
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: searchController,
                                    onChanged:
                                        filterSearchResults, // Call filter function
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'search'.tr,
                                      hintStyle: TextStyle(
                                        color:
                                            Color(0xff1F5077).withOpacity(0.3),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: 8.0, bottom: 5, right: 8.0),
                                    ),
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: h * 0.05),
                          GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.all(0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: w * 0.06,
                              mainAxisSpacing: h * 0.025,
                              mainAxisExtent: h * 0.19,
                            ),
                            itemCount: filteredSections.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (checkIndex == index) {
                                      print('If');

                                      checkIndex = -1;
                                      selectedId = null;
                                      selectedData = null;
                                      selectedName = null;
                                    } else {
                                      print('Else');
                                      checkIndex = index;
                                      selectedData =
                                          filteredSections[index]['questions'];
                                      print('selectedDataA=====${selectedData}');

                                      selectedId =
                                          filteredSections[index]['id'];
                                      selectedName =
                                          filteredSections[index]['name'];
                                    }
                                  });
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF9CB3C5),
                                        Color(0xffF3F7FC),
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(
                                        children: [
                                          SizedBox(
                                            height: h * 0.12,
                                            width: w * 0.39,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(40),
                                                  topLeft: Radius.circular(40)),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "${AppConstants.apiSectionImgUrl}${filteredSections[index]['image_path']}",
                                                fit: BoxFit.fill,
                                                width: double.infinity,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                        'assets/images/service_grid_img.png',
                                                        fit: BoxFit.cover),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                        'assets/images/service_grid_img.png',
                                                        fit: BoxFit.cover),
                                                fadeInDuration:
                                                    Duration(milliseconds: 500),
                                              ),
                                            ),
                                          ),
                                          checkIndex == index
                                              ? Container(
                                                  padding: EdgeInsets.all(3),
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.04,
                                                      top: h * 0.01,
                                                      right: w * 0.04),
                                                  child: Icon(Icons.check,
                                                      color: Color(0xffFFFFFF),
                                                      size: 15),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff1F5077),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: w * 0.02,
                                            right: w * 0.02,
                                            bottom: h * 0.01),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              filteredSections[index]['name']
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'Alexandria',
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF1F5077),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: h * 0.05),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 0.5,
                            color: Color(0xff1F5077).withOpacity(0.2),
                          ),
                          SizedBox(height: h * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // Space evenly between the two containers
                            children: [
                              // First Container
                              GestureDetector(
                                onTap: () {
                                  if (selectedId == null) {
                                    Get.snackbar(
                                      'Message'.tr,
                                      'Select any Section',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: Color(0xff1F5077),
                                      colorText: Colors.white,
                                    );
                                  } else {
                                    // Print all the data before sending
                                    print(
                                        "Request ID: ${widget.data['request']['id']}");
                                    print(
                                        "Branch ID: ${widget.data['request']['branch_id']}");
                                    print("Selected Data: $selectedData");
                                    print("Selected ID: $selectedId");
                                    print("Selected Name: $selectedName");

                                    // Call the continueReportsFunction with the data
                                    continueReportsController
                                        .continueReportsFunction(
                                            "${widget.data['request']['id']}",
                                            "${widget.data['request']['branch_id']}",
                                            selectedData,
                                            selectedId,
                                            selectedName,
                                            widget.data['request']['email']
                                                .toString());
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: h * 0.01,
                                      bottom: h * 0.01,
                                      left: w * 0.04,
                                      right: w * 0.04),
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    // Yellow background for the first container
                                    borderRadius: BorderRadius.circular(
                                        20), // Rounded corners
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Continue Icon
                                      Image.asset(
                                        'assets/images/continueIcon.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(
                                          width: w *
                                              0.02), // Space between icon and text
                                      // Continue Text
                                      Text(
                                        'continue'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color:
                                              Color(0xff1F5077), // Text color
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Second Container
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Center(
                                        child: Dialog(
                                          child: Container(
                                            height: h * 0.31,
                                            decoration: BoxDecoration(
                                                color: Color(0xffE5EFF9),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Column(
                                              children: [
                                                // Container for "Sure to leave" Text
                                                Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF1F5077),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20),
                                                    ),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      top: h * 0.015,
                                                      bottom: h * 0.015,
                                                      left: w * 0.05,
                                                      right: w * 0.05),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'sureToLeave'.tr,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 18,
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Alexandria'),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: h * 0.03,
                                                      left: w * 0.05,
                                                      right: w * 0.05),
                                                  child: Text(
                                                    "confirmToLeave".tr,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'Alexandria',
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.blue[200],
                                                    ),
                                                    // maxLines: 4,
                                                  ),
                                                ),
                                                SizedBox(height: h * 0.03),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: w * 0.05,
                                                      right: w * 0.05),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 0.5,
                                                  color: Color(0xff1F5077)
                                                      .withOpacity(0.2),
                                                ),
                                                SizedBox(height: h * 0.03),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // "No" button
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context).pop(
                                                            false); // Don't leave
                                                      },
                                                      child: Container(
                                                        width: 100,
                                                        height: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFFFFFFF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'no'.tr,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Color(
                                                                0xff1F5077),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 20),
                                                    // "Yes" button
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context).pop(
                                                            true); // Confirm leave
                                                      },
                                                      child: Container(
                                                        width: 100,
                                                        height: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'yes'.tr,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: h * 0.01,
                                      bottom: h * 0.01,
                                      left: w * 0.08,
                                      right: w * 0.08),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Leave Icon
                                      Image.asset(
                                        'assets/images/leaveIcon.png',
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(width: w * 0.02),
                                      // Leave Text
                                      Text(
                                        'leave'.tr,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: h * 0.1),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
