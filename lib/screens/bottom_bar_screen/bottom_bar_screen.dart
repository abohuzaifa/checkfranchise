import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:franchise_app/screens/all_branches_screen/all_branches_screen.dart';
import 'package:franchise_app/screens/face_id_screen/face_id_screen.dart';
import 'package:get/get.dart';

import '../account_screen/account_screen.dart';
import '../branch_information/branch_information.dart';
import '../home_screen/home_screen.dart';
import '../reports_screen/reports_screen.dart';

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  int isCheck = 0;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            Container(
                height: h,
                child: isCheck == 0
                    ? checkNavigation1.value == 1
                        ? HomeScreen()
                        : checkNavigation1.value == 2
                            ? AllBranchesScreen()
                            : checkNavigation1.value == 3
                                ? BranchInformation(
                                    id: branchId.value.toString(),
                                  )
                                : FaceIdScreen()
                    : isCheck == 1
                        ? ReportsScreen()
                        : isCheck == 2
                            ? AccountScreen()
                            : SizedBox()),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: h * 0.8,
                ),
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      height: h * 0.1,
                      padding: EdgeInsets.only(top: h * 0.018),
                      decoration: BoxDecoration(color: Color(0xff1F5077)),
                      child: Row(
                        children: [
                          Spacer(),
                          Text(
                            "home".tr,
                            style: TextStyle(
                              fontFamily: 'Alexandria',
                              fontSize: 12,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "reports".tr,
                            style: TextStyle(
                              fontFamily: 'Alexandria',
                              fontSize: 12,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          Spacer(),
                          Text(
                            "account".tr,
                            style: TextStyle(
                              fontFamily: 'Alexandria',
                              fontSize: 12,
                              color: Color(0xffFFFFFF),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: w * 0.04, right: w * 0.04, bottom: h * 0.063),
                      padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01),
                      decoration: BoxDecoration(
                          color: Color(0xffD1E6FB),
                          borderRadius: BorderRadius.circular(900)),
                      height: h * 0.08,
                      child: Row(
                        children: [
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isCheck = 0;
                              });
                            },
                            child: Container(
                              height: h * 0.1,
                              width: w * 0.15,
                              padding: EdgeInsets.all(10),
                              decoration: isCheck != 0
                                  ? BoxDecoration()
                                  : BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "${AppConstants.imgUrl}bottom_bar_icon_back_img.png")),
                                    ),
                              child: ImageIcon(
                                AssetImage("assets/images/home.png"),
                                color: isCheck == 0
                                    ? Color(0xff1F5077)
                                    : Color(0xff1F5077).withOpacity(0.5),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isCheck = 1;
                              });
                            },
                            child: Container(
                              height: h * 0.1,
                              width: w * 0.15,
                              padding: EdgeInsets.all(10),
                              decoration: isCheck != 1
                                  ? BoxDecoration()
                                  : BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "${AppConstants.imgUrl}bottom_bar_icon_back_img.png")),
                                    ),
                              child: ImageIcon(
                                AssetImage("assets/images/reports.png"),
                                color: isCheck == 1
                                    ? Color(0xff1F5077)
                                    : Color(0xff1F5077).withOpacity(0.5),
                              ),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isCheck = 2;
                              });
                            },
                            child: Container(
                              height: h * 0.1,
                              width: w * 0.15,
                              padding: EdgeInsets.all(10),
                              decoration: isCheck != 2
                                  ? BoxDecoration()
                                  : BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "${AppConstants.imgUrl}bottom_bar_icon_back_img.png")),
                                    ),
                              child: ImageIcon(
                                AssetImage("assets/images/profile.png"),
                                color: isCheck == 2
                                    ? Color(0xff1F5077)
                                    : Color(0xff1F5077).withOpacity(0.5),
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
