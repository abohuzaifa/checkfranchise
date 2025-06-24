import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:franchise_app/screens/notification_screen/get_notification_controller.dart';
import 'package:franchise_app/screens/notification_screen/notification_read_controller.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  GetNotificationController getNotificationController =
      Get.put(GetNotificationController());
  NotificationReadController notificationReadController =
      Get.put(NotificationReadController());

  List imageList = [
    "${AppConstants.imgUrl}profile_img.png",
    "${AppConstants.imgUrl}info_img.png",
    "${AppConstants.imgUrl}profile_img.png",
    "${AppConstants.imgUrl}info_img.png",
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotificationController.getNotificationFunction();
  }

  @override
  Widget build(BuildContext context) {
    Locale? currentLocale = Get.locale;

    // Extract the language code (e.g., 'en', 'es')
    String languageCode = currentLocale?.languageCode ?? 'en';
    print("Language Code: $languageCode");
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Obx(
      () => getNotificationController.isloading.value || notificationReadController.isloading.value
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
                          textDirection:TextDirection.ltr,
                          child: Row(
                            children: [
                              Container(
                                  height: h * 0.16,

                                  child:  Image.asset(
                                      "assets/images/home_white_logo.png")
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
                              )
                            ],
                          ),
                        ),
                        // Title and "Show All" Row
                        Container(
                          margin: EdgeInsets.only(top: h * 0.05),
                          padding: EdgeInsets.only(
                              top: h * 0.03, left: w * 0.05, right: w * 0.05),
                          decoration: BoxDecoration(
                              color: Color(0xffF3F7FC),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: h * 0.02,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: w * 0.03),
                                child:    Text(
                                  "notifications".tr,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Alexandria',
                                      color: Color(0xff1F5077)),
                                ),

                              ),
                              SizedBox(
                                height: h * 0.02,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(0),
                                scrollDirection: Axis.vertical,
                                itemCount: getNotificationController
                                    .notificationData.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                              getNotificationController
                                                  .notificationData[index]
                                                      ['time']
                                                  .toString(),
                                              style: TextStyle(
                                                decoration: TextDecoration.none,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Alexandria',
                                                  color: Color(0xff2E76B0)
                                                      .withOpacity(0.5))),
                                          SizedBox(
                                            width: w * 0.025,
                                          )
                                        ],
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: h * 0.01, bottom: h * 0.03),
                                        height: h * 0.069,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Color(0xffFFFFFF),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.withOpacity(
                                                    0.2), // Shadow color
                                                spreadRadius:
                                                    2, // How far the shadow spreads
                                                blurRadius:
                                                    5, // Blur effect of the shadow
                                                offset: Offset(0, 3),
                                              )
                                            ]),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: w * 0.035,
                                                  top: h * 0.0099,
                                                  bottom: h * 0.0099),
                                              child:
                                                  Image.asset(imageList[index]),
                                            ),
                                            SizedBox(
                                              width: w * 0.015,
                                            ),
                                            Text(
                                                getNotificationController
                                                    .notificationData[index]
                                                        ['branch']
                                                        ['branch_name']
                                                    .toString(),
                                                style: TextStyle(
                                                    decoration: TextDecoration.none,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Alexandria',
                                                    color: Color(0xff2E76B0))),
                                            Spacer(),
                                            getNotificationController
                                                        .notificationData[index]
                                                            ['is_read']
                                                        .toString() ==
                                                    "0"
                                                ? GestureDetector(
                                                    onTap: () {
                                                      notificationReadController
                                                          .notificationReadFunction(
                                                              "single",
                                                              getNotificationController
                                                                      .notificationData[
                                                                  index]['id'].toString());
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.circle,
                                                          color: Colors.red,
                                                          size: 9,
                                                        ),
                                                        SizedBox(
                                                          width: w * 0.01,
                                                        ),
                                                        Text("Unread",
                                                            style: TextStyle(
                                                                decoration: TextDecoration.none,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontFamily:
                                                                    'Alexandria',
                                                                color: Colors
                                                                    .red)),
                                                      ],
                                                    ),
                                                  )
                                                : SizedBox(),
                                            SizedBox(
                                              width: w * 0.03,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                              SizedBox(
                                height: h * 0.6,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(
                            top: h * 0.235, left: w * 0.05, right: w * 0.05),
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Color(0xff1F5077),
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
