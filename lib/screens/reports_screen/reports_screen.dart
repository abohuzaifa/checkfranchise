import 'package:flutter/material.dart';
import 'package:franchise_app/screens/reports_screen/get_report_list_controller.dart';
import 'package:franchise_app/screens/reports_screen/report_result_view_controller.dart';
import 'package:get/get.dart';
import '../all_branches_screen/city_list_controller.dart';
import '../notification_screen/notification_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui' as ui;

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String? selectedCity;
  int checkIndex = -1;
  ReportResultViewController reportResultViewController =
      Get.put(ReportResultViewController());
  GetReportListController getReportListController =
      Get.put(GetReportListController());
  CityListController cityListController = Get.put(CityListController());
  List titleList = [
    "Sari Street, Jeddah",
    "Diriyah, Riyadh",
    "Azizia, Medina",
    "Sultana, Medina",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReportListController.getReportListFunction();
    cityListController.cityListFunction();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current locale
    Locale? currentLocale = Get.locale;

    // Extract the language code (e.g., 'en', 'es')
    String languageCode = currentLocale?.languageCode ?? 'en';
    print("Language Code: $languageCode");
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Obx(
      () => getReportListController.isloading.value ||
              reportResultViewController.isloading.value
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
                    Container(
                      height: h * 0.5,
                      width: w,
                      color: Color(0xff1F5077),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: h * 0.05,
                        ),
                        Directionality(
                          textDirection: ui.TextDirection
                              .ltr, // Explicitly using 'dart:ui' TextDirection
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
                          height: h,
                          width: w,
                          margin: EdgeInsets.only(top: h * 0.05),
                          padding: EdgeInsets.only(
                              top: h * 0.03, left: w * 0.05, right: w * 0.05),
                          decoration: BoxDecoration(
                              color: Color(0xffF3F7FC),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: h * 0.02,
                                ),
                                padding: EdgeInsets.only(
                                  left: w * 0.03,
                                  right: w * 0.03,
                                ),
                                height: h * 0.05,
                                width: w * 0.46,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE5EFF9),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey
                                          .withOpacity(0.5), // Shadow color
                                      spreadRadius: 0, // Spread radius
                                      blurRadius: 2, // Blur radius
                                      offset: Offset(
                                          2, 1), // Shadow appears at the bottom
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DropdownButton<String>(
                                      value: selectedCity,
                                      hint: Text(
                                        'selectACity'.tr,
                                        style: TextStyle(
                                          color: Color(0xff1F5077)
                                              .withOpacity(0.6),
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Alexandria',
                                        ),
                                      ),
                                      underline: SizedBox(),
                                      icon: Image.asset(
                                        'assets/images/dropDown.png',
                                        height: 19,
                                        width: 19,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCity = newValue;
                                        });
                                      },
                                      items: cityListController.cityList
                                          .map((city) {
                                        return DropdownMenuItem<String>(
                                          value: city.cityName,
                                          child: SizedBox(
                                              width: w * 0.33,
                                              child: languageCode == 'en'
                                                  ? Text(
                                                      city.cityName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Text(
                                                      city.cityNameAr,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                        );
                                      }).toList(),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: h * 0.03,
                              ),
                              ListView.builder(
                                  padding: EdgeInsets.all(0),
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      getReportListController.reportData.length,
                                  itemBuilder: (BuildContext context, index) {
                                    String formattedDate = '';
                                    if (getReportListController
                                            .reportData[index]['city'] !=
                                        null) {
                                      String createdAt = getReportListController
                                          .reportData[index]['created_at']
                                          .toString();
                                      DateTime dateTime =
                                          DateTime.parse(createdAt);
                                      formattedDate = DateFormat('yyyy-MM-dd')
                                          .format(dateTime);
                                      print(formattedDate);
                                    }
                                    return getReportListController
                                                .reportData[index]['city'] !=
                                            null
                                        ? Container(
                                            width: w,
                                            margin: EdgeInsets.only(
                                                top: h * 0.02,
                                                right: w * 0.02,
                                                left: w * 0.02),
                                            padding: EdgeInsets.only(
                                                right: w * 0.04,
                                                left: w * 0.02,
                                                bottom: h * 0.013,
                                                top: h * 0.013),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(
                                                            0.2), // Shadow color
                                                    spreadRadius: 2,
                                                    blurRadius:
                                                        3, // How far the shadow spreads
                                                    offset: Offset(0, 1),
                                                  )
                                                ]),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      (getReportListController.reportData[index]['branch']?['branch_name'] ?? '')
                                                          .toString()
                                                          .trim()
                                                          .isEmpty
                                                          ? 'Name Not Available'
                                                          : getReportListController.reportData[index]['branch']['branch_name']
                                                          .toString(),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: const TextStyle(
                                                        fontSize: 19,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: 'Alexandria',
                                                        color: Color(0xff1F5077),
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (checkIndex == index) {
                                                            checkIndex = -1;
                                                          } else {
                                                            checkIndex = index;
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration: const BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage("assets/images/circle_img.png"),
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.only(bottom: h * 0.004),
                                                          child: Icon(
                                                            checkIndex == index ? Icons.remove : Icons.add,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                checkIndex == index
                                                    ? Row(
                                                        children: [
                                                          /*    Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: w *
                                                                        0.03),
                                                            height: h * 0.15,
                                                            width: w * 0.3,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(10),
                                                              border:
                                                              Border.all(color: Color(0xff9CB3C5),width: w*0.006,),

                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        "assets/images/report.png")
                                                                )
                                                            ),
                                                          ),*/
                                                          SizedBox(
                                                            width: w * 0.02,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    left: w *
                                                                        0.025,
                                                                    right: w *
                                                                        0.025),
                                                                child: Text(
                                                                  "roundDate"
                                                                      .tr,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontFamily:
                                                                          'Alexandria',
                                                                      color: Color(
                                                                          0xff0A8BBF)),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    h * 0.005,
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets.only(
                                                                    left: w *
                                                                        0.025,
                                                                    right: w *
                                                                        0.025),
                                                                child: Text(
                                                                  formattedDate
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          17,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontFamily:
                                                                          'Alexandria',
                                                                      color: Color(
                                                                          0xff82D7F7)),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    h * 0.02,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  print("getReportListController.reportData[index]['id']========${getReportListController.reportData[index]['id'].toString()}");
                                                                  reportResultViewController.reportResultViewFunction(getReportListController
                                                                      .reportData[
                                                                          index]
                                                                          ['id']
                                                                      .toString());
                                                                },
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      h * 0.036,
                                                                  width:
                                                                      w * 0.37,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: const Color(
                                                                        0xFF1F5077),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            50),
                                                                    boxShadow: [
                                                                      BoxShadow(
                                                                        color: Colors
                                                                            .white,
                                                                        offset: const Offset(
                                                                            1,
                                                                            1),
                                                                        blurRadius:
                                                                            2,
                                                                        spreadRadius:
                                                                            0,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  child: Text(
                                                                    'openTheReport'
                                                                        .tr,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Alexandria',
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          14,
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height:
                                                                    h * 0.01,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          )
                                        : SizedBox();
                                  }),
                              SizedBox(
                                height: h * 0.1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
