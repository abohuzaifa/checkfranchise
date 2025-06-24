import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:franchise_app/screens/home_screen/previous_reports_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import 'package:get_storage/get_storage.dart';

import '../all_branches_screen/all_branches_controller.dart';
import '../notification_screen/notification_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isloading = true;
  bool isloading1 = true;
  AllBranchesController allBranchesController =
      Get.put(AllBranchesController());
  PreviousReportsController previousReportsController =
      Get.put(PreviousReportsController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // Call previousReportsFunction and update state if mounted
    previousReportsController.previousReportsFunction().then((value) {
      if (mounted) {
        setState(() {
          isloading1 = false;
        });
      }
    });

    // Call allBranchesFunction and update state if mounted
    allBranchesController.allBranchesFunction().then((value) {
      if (mounted) {
        setState(() {
          isloading = false;
        });
      }
    });

    // Print the token
    print("This is get token ${GetStorage().read("token")}");
  }

  @override
  final PageController pageController = PageController();
  final RxInt currentPageIndex = 0.obs;

  Widget build(BuildContext context) {
    // Get the current locale
    Locale? currentLocale = Get.locale;

    // Extract the language code (e.g., 'en', 'es')
    String languageCode = currentLocale?.languageCode ?? 'en';
    print("Language Code: $languageCode");

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return isloading == true || isloading1 == true
        ? Container(
            height: h,
            width: w,
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          )
        : Container(
            height: h,
            width: w,
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Image.asset("${AppConstants.imgUrl}home_bg_img.png"),
                  Column(
                    children: [
                      SizedBox(
                        height: h * 0.05,
                      ),

                      Directionality(
                        textDirection: ui.TextDirection.ltr,
                        // Explicitly using 'dart:ui' TextDirection
                        child: Row(
                          children: [
                            Container(
                              height: h * 0.16,
                              child: Image.asset(
                                  "assets/images/home_white_logo.png"),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => NotificationScreen());
                              },
                              child: Container(
                                height: 50,
                                width: 50,
                                child: Image.asset(
                                    "assets/images/notification_white_img.png"),
                              ),
                            ),
                            SizedBox(
                              width: w * 0.06,
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: w,
                        margin:
                            EdgeInsets.only(left: w * 0.05, right: w * 0.05),
                        child: Text(
                          'Hi, ${GetStorage().read('name')}',
                          style: TextStyle(
                            fontFamily: 'Alexandria',
                            fontSize: 18,
                            color: const Color(0xFFFFFFFF),
                          ),
                        ),
                      ),
                      // Title and "Show All" Row
                      Container(
                        margin: EdgeInsets.only(top: h * 0.02),
                        padding: EdgeInsets.only(
                            top: h * 0.03, left: w * 0.05, right: w * 0.05),
                        decoration: BoxDecoration(
                            color: Color(0xffF3F7FC),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'branches'.tr,
                                  style: TextStyle(
                                    fontFamily: 'Alexandria',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 19,
                                    color: Color(0xFF1F5077),
                                  ),
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      checkNavigation1.value = 2;
                                    });
                                    // Get.to(()=>AllBranchesScreen());
                                  },
                                  child: Row(
                                    children: [
                                      Text(
                                        'showAll'.tr,
                                        style: TextStyle(
                                          fontFamily: 'Alexandria',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 13,
                                          color: Color(0xFF1F5077)
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 13,
                                        color:
                                            Color(0xFF1F5077).withOpacity(0.5),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              height: h * 0.25,
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: h * 0.02),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      primary: true,
                                      padding: EdgeInsets.all(0),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1,
                                        mainAxisExtent: w * 0.44,
                                        mainAxisSpacing: h * 0.005,
                                      ),
                                      itemCount: allBranchesController
                                          .branchesData.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return GestureDetector(
                                          onTap: () {
                                            print(
                                                "ID: ${allBranchesController.branchesData[index]['id'].toString()}");
                                            branchId.value =
                                                allBranchesController
                                                    .branchesData[index]['id']
                                                    .toString();
                                            checkNavigation1.value = 3;
                                            checkNavigation2.value = 2;
                                            currentPageIndex.value =
                                                index; // Update the dot indicator
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(),
                                            height: h * 0.26,
                                            width: w * 0.4,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: Color(0xff000000)
                                                  .withOpacity(0.2),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Image section
                                                SizedBox(
                                                  height: h * 0.19,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(20),
                                                      topRight:
                                                          Radius.circular(20),
                                                    ),
                                                    child: Stack(
                                                      children: [
                                                        CachedNetworkImage(
                                                          imageUrl:
                                                              "${AppConstants.branchImgUrl}${allBranchesController.branchesData[index]['header_image']}",
                                                          fit: BoxFit.fill,
                                                          width:
                                                              double.infinity,
                                                          placeholder:
                                                              (context, url) =>
                                                                  Image.asset(
                                                            'assets/images/dummyFood.png',
                                                            fit: BoxFit.cover,
                                                            width:
                                                                double.infinity,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              Image.asset(
                                                            'assets/images/dummyFood.png',
                                                            fit: BoxFit.cover,
                                                            width:
                                                                double.infinity,
                                                          ),
                                                          fadeInDuration:
                                                              Duration(
                                                                  milliseconds:
                                                                      500),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                // Text section
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    top: h * 0.01,
                                                    left: w * 0.04,
                                                    right: w * 0.02,
                                                    bottom: h * 0.01,
                                                  ),
                                                  child: SizedBox(
                                                    height: 30,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: SizedBox(
                                                            height:
                                                                40, // Set a fixed height to ensure two lines of text
                                                            child: Text(
                                                              allBranchesController
                                                                  .branchesData[
                                                                      index][
                                                                      'branch_name']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize: allBranchesController
                                                                            .branchesData[index]['branch_name']
                                                                            .toString()
                                                                            .length >
                                                                        6
                                                                    ? 12 // Reduce font size if text length > 6
                                                                    : 15, // Default font size
                                                                fontFamily:
                                                                    'Alexandria',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Color(
                                                                    0xFF1F5077),
                                                              ),
                                                              maxLines:
                                                                  2, // Ensure text wraps into exactly 2 lines
                                                              overflow: TextOverflow
                                                                  .ellipsis, // Add ellipsis if text overflows
                                                              softWrap:
                                                                  true, // Enable text wrapping
                                                            ),
                                                          ),
                                                        ),
                                                        Image.asset(
                                                            'assets/images/indication.png'),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            // Wrap only the dot indicators with Obx
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  allBranchesController.branchesData.length,
                                  (index) => Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    width: currentPageIndex.value == index
                                        ? 12.0
                                        : 8.0,
                                    height: 8.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPageIndex.value == index
                                          ? Color(
                                              0xff1F5077) // Active indicator color
                                          : Color(0xff59A4D7).withOpacity(0.7),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.04,
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Text(
                                    'previousReports'.tr,
                                    style: TextStyle(
                                      fontFamily: 'Alexandria',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19,
                                      color: const Color(0xFF1F5077),
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        checkNavigation1.value = 2;
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          'showAll'.tr,
                                          style: TextStyle(
                                            fontFamily: 'Alexandria',
                                            fontWeight: FontWeight.w500,
                                            fontSize: 13,
                                            color: Color(0xFF1F5077)
                                                .withOpacity(0.5),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 13,
                                          color: Color(0xFF1F5077)
                                              .withOpacity(0.5),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            previousReportsController.preReportData != null
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    primary: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.all(0),
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing:
                                          w * 0.01, // Adjust as needed
                                      mainAxisSpacing:
                                          h * 0.017, // Adjust as needed
                                      mainAxisExtent:
                                          h * 0.28, // Adjust as needed
                                    ),
                                    itemCount: previousReportsController
                                        .preReportData.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      String? createdAt =
                                          previousReportsController
                                              .preReportData[index]['branch']
                                                  ?['created_at']
                                              ?.toString();

// Ensure createdAt is not null, empty, or "Not Available"
                                      if (createdAt == null ||
                                          createdAt.isEmpty ||
                                          createdAt == 'Not Available') {
                                        createdAt = 'Not Available';
                                      }

                                      DateTime? dateTime;
                                      if (createdAt != 'Not Available') {
                                        try {
                                          dateTime = DateTime.parse(createdAt);
                                        } catch (e) {
                                          dateTime =
                                              null; // Handle invalid date format safely
                                        }
                                      }

                                      String formattedDate = 'Not Available';
                                      if (dateTime != null) {
                                        formattedDate = DateFormat('yyyy-MM-dd')
                                            .format(dateTime);
                                      }

                                      print(formattedDate);

                                      return GestureDetector(
                                        onTap: () {
                                          print(
                                              "ID: ${previousReportsController.preReportData[index]['id'].toString()}");
                                          branchId.value =
                                              previousReportsController
                                                  .preReportData[index]['id']
                                                  .toString();
                                          checkNavigation1.value = 3;
                                          checkNavigation2.value = 2;
                                          currentPageIndex.value =
                                              index; // Update the dot indicator
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.6,
                                          // Adjust width to prevent overflow
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Color(0xffFFFFFF),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Image section
                                              SizedBox(
                                                height: h * 0.2,
                                                // Fixed height for the image
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Stack(
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/dummyFood.png',
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                      ),
                                                      Image.asset(
                                                        'assets/images/meshraqTitleImage.png',
                                                        fit: BoxFit.cover,
                                                        width: double.infinity,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              // Text section
                                              Flexible(
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                    left: w * 0.02,
                                                    right: w * 0.02,
                                                    bottom: h * 0.02,
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    // Minimize the height of the Column
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          (previousReportsController.preReportData[index]
                                                                              [
                                                                              'branch']
                                                                          ?[
                                                                          'branch_name'] ??
                                                                      '')
                                                                  .toString()
                                                                  .trim()
                                                                  .isEmpty
                                                              ? 'Name Not Available'
                                                              : previousReportsController
                                                                  .preReportData[
                                                                      index]
                                                                      ['branch']
                                                                      [
                                                                      'branch_name']
                                                                  .toString(),
                                                          style: TextStyle(
                                                            fontSize: (previousReportsController.preReportData[index]['branch']?['branch_name'] ??
                                                                            '')
                                                                        .toString()
                                                                        .trim()
                                                                        .length >
                                                                    6
                                                                ? 12 // Reduce font size if text length > 6
                                                                : 14, // Default font size
                                                            fontFamily:
                                                                'Alexandria',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: Color(
                                                                0xFF1F5077),
                                                          ),
                                                          maxLines:
                                                              2, // Allow text to wrap into 2 lines
                                                          overflow: TextOverflow
                                                              .ellipsis, // Add ellipsis if text overflows
                                                          softWrap:
                                                              true, // Enable text wrapping
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      // Add a small gap between the two texts
                                                      // Second Text widget
                                                      Text(
                                                        formattedDate,
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'Alexandria',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Color(
                                                                  0xFF1F5077)
                                                              .withOpacity(0.6),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Container(),
                            SizedBox(
                              height: h * 0.3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
