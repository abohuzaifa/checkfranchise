import 'package:flutter/material.dart';
import 'package:franchise_app/screens/account_screen/delete_account_controller.dart';
import 'package:franchise_app/screens/account_screen/logout_controller.dart';
import 'package:franchise_app/screens/account_screen/update_account_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../common_widget/account_common_widget.dart';
import '../../constants/app_constants.dart';
import '../notification_screen/notification_screen.dart';
import '../notification_screen/notification_status_controller.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  int index = 0;
  int checkIndex = -1;
  int checkIndexx = -1;
  LogoutController logoutController = Get.put(LogoutController());
  NotificationStatusController notificationStatusController =
      Get.put(NotificationStatusController());
  UpdateAccountController updateAccountController =
      Get.put(UpdateAccountController());
  DeleteAccountController deleteAccountController =
      Get.put(DeleteAccountController());
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int check = 1;
  bool _isSwitched = false;
  bool _isSwitched1 = false;

  @override
  void initState() {
    super.initState();
    if (GetStorage().read("checkNotification") == "true") {
      _isSwitched1 = true;
    } else {
      _isSwitched1 = false;
    }
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
      () => Stack(
        children: [
          SizedBox(
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
                      Container(
                        margin: EdgeInsets.only(top: h * 0.05),
                        padding: EdgeInsets.only(
                            top: h * 0.03, left: w * 0.05, right: w * 0.05),
                        decoration: BoxDecoration(
                            color: Color(0xffF3F7FC),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: w * 0.03,
                                ),
                                Container(
                                  height: h * 0.06,
                                  width: w * 0.13,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/images/person_name.png"))),
                                ),
                                SizedBox(
                                  width: w * 0.02,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      child: Text(
                                        '${GetStorage().read('name')}',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Alexandria',
                                            color: Color(0xff0A8BBF)),
                                      ),
                                    ),
                                    Text(
                                      '${GetStorage().read('mobile')}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Alexandria',
                                        color:
                                            Color(0xff2E76B0).withOpacity(0.5),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: h * 0.04,
                            ),
                            Container(
                              width: w,
                              padding: EdgeInsets.only(
                                  right: w * 0.04,
                                  left: w * 0.04,
                                  top: h * 0.016,
                                  bottom: h * 0.020),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: w * 0.02),
                                      child: Text(
                                        'information'.tr,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: 'Alexandria',
                                            color: Color(0xff1F5077)),
                                      ),
                                    ),
                                    Spacer(),
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
                                          height: 31,
                                          width: 31,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/circle_img.png"))),
                                          child: checkIndex == index
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: h * 0.007),
                                                  child: Transform.scale(
                                                    scale: 0.4,
                                                    child: Image.asset(
                                                      "${AppConstants.imgUrl}arrow_up_img.png",
                                                    ),
                                                  ))
                                              : Transform.scale(
                                                  scale: 0.4,
                                                  child: Image.asset(
                                                    "${AppConstants.imgUrl}arrow_down_img.png",
                                                  ),
                                                )),
                                    ),
                                  ],
                                ),
                                checkIndex == index
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: h * 0.03,
                                          ),
                                          AccountCommonWidget(
                                            img: 'your_name_img.png',
                                            title: 'yourName'.tr,
                                            h: h * 0.03,
                                            w: null,
                                            textEditingController:
                                                nameController,
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          AccountCommonWidget(
                                            img: 'phone.png',
                                            title: 'phoneNumber'.tr,
                                            h: h * 0.025,
                                            w: null,
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          AccountCommonWidget(
                                              img: 'mail.png',
                                              title: 'email'.tr,
                                              h: h * 0.02,
                                              w: null,
                                              textEditingController:
                                                  emailController),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          AccountCommonWidget(
                                              img: 'password_new_img.png',
                                              title: 'password'.tr,
                                              h: h * 0.03,
                                              w: null,
                                              textEditingController:
                                                  passwordController),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          AccountCommonWidget(
                                            img: 'function_img.png',
                                            title: 'function'.tr,
                                            h: h * 0.03,
                                            w: null,
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              updateAccountController
                                                  .updateAccountFunction(
                                                      passwordController.text,
                                                      emailController.text,
                                                      nameController.text);
                                            },
                                            child: Container(
                                              height: h * 0.05,
                                              decoration: BoxDecoration(
                                                color: Color(0xff1D3F5D),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.07),
                                                    blurRadius: 2,
                                                    offset: const Offset(0, 2),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'update'.tr,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontFamily:
                                                            'Alexandria',
                                                        color:
                                                            Color(0xffFFFFFF)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                        /*   SizedBox(height: h*0.02,),
                                  Container(
                                    height: h*0.05,
                                    decoration: BoxDecoration(
                                      color: Color(0xffF3F7FC),
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.07),
                                          blurRadius: 2,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: w*0.03,),
                                        Image.asset("${AppConstants.imgUrl}function_img.png",height: h*0.03,),
                                        SizedBox(width: w*0.02,),
                                        Text("setUpFaceID".tr,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'Alexandria',
                                              color: Color(0xff1D3F5D).withOpacity(0.4)),
                                        ),
                                        Spacer(),
                                        Container(
                                          height: h*0.05,
                                          padding: EdgeInsets.only(left: w*0.04,right: w*0.04),
                                          decoration: BoxDecoration(
                                              color: Color(0xff1D3F5D),
                                              borderRadius: languageCode=='en'? BorderRadius.only(
                                                  topRight: Radius.circular(12),
                                                  bottomRight: Radius.circular(12)): BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  bottomLeft: Radius.circular(12))
                                          ),
                                          child: Icon(Icons.arrow_forward_ios,color: Color(0xffFFFFFF),),
                                        )
                                      ],
                                    ),
                                  ),*/
                                      )
                                    : SizedBox()
                              ]),
                            ),
                            Container(
                              width: w,
                              margin: EdgeInsets.only(top: h * 0.02),
                              padding: EdgeInsets.only(
                                  right: w * 0.04,
                                  left: w * 0.04,
                                  top: h * 0.016,
                                  bottom: h * 0.020),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: w * 0.02),
                                        child: Text(
                                          "settings".tr,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'Alexandria',
                                              color: Color(0xff1F5077)),
                                        ),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (checkIndexx == index) {
                                              checkIndexx = -1;
                                            } else {
                                              checkIndexx = index;
                                            }
                                          });
                                        },
                                        child: Container(
                                            height: 31,
                                            width: 31,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/images/circle_img.png"))),
                                            child: checkIndexx == index
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: h * 0.007),
                                                    child: Transform.scale(
                                                      scale: 0.4,
                                                      child: Image.asset(
                                                        "${AppConstants.imgUrl}arrow_up_img.png",
                                                      ),
                                                    ))
                                                : Transform.scale(
                                                    scale: 0.4,
                                                    child: Image.asset(
                                                      "${AppConstants.imgUrl}arrow_down_img.png",
                                                    ),
                                                  )),
                                      ),
                                    ],
                                  ),
                        checkIndexx == index
                            ? Column(
                          children: [
                            SizedBox(
                              height: h * 0.02,
                            ),
                            Container(
                              height: h * 0.05,
                              decoration: BoxDecoration(
                                color: Color(0xffF3F7FC),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.07),
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.03,
                                  ),
                                  Image.asset(
                                    "${AppConstants.imgUrl}language_img.png",
                                    height: h * 0.03,
                                  ),
                                  SizedBox(
                                    width: w * 0.02,
                                  ),
                                  Text(
                                    "language".tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Alexandria',
                                        color: Color(0xff1D3F5D).withOpacity(0.4)),
                                  ),
                                  Spacer(),
                                  Container(
                                    height: h * 0.05,
                                    decoration: BoxDecoration(
                                      color: Color(0xff1D3F5D),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              Get.updateLocale(Locale('en', 'US'));
                                              GetStorage().write('selectedLanguage', 'en'); // Save the selected language
                                              check = 1;
                                            });
                                          },
                                          child: Container(
                                            height: h * 0.05,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(
                                                left: w * 0.045, right: w * 0.045),
                                            decoration: BoxDecoration(
                                                color: check == 1 ? Color(0xffD6E7F5) : null,
                                                borderRadius: BorderRadius.circular(12)),
                                            child: Text(
                                              "EN",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Alexandria',
                                                  color: check == 1
                                                      ? Color(0xff1D3F5D)
                                                      : Color(0xffFFFFFF)),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              Get.updateLocale(Locale('ar', 'AR'));
                                              GetStorage().write('selectedLanguage', 'ar'); // Save the selected language
                                              check = 2;
                                            });
                                          },
                                          child: Container(
                                            height: h * 0.05,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.only(
                                                left: w * 0.02, right: w * 0.02),
                                            decoration: BoxDecoration(
                                                color: check == 2 ? Color(0xffD6E7F5) : null,
                                                borderRadius: BorderRadius.circular(12)),
                                            child: Text(
                                              "العربية",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'Alexandria',
                                                  color: check == 2
                                                      ? Color(0xff1D3F5D)
                                                      : Color(0xffFFFFFF)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            Container(
                              height: h * 0.05,
                              decoration: BoxDecoration(
                                color: Color(0xffF3F7FC),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.07),
                                    blurRadius: 2,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.03,
                                  ),
                                  Image.asset(
                                    "${AppConstants.imgUrl}alert_img.png",
                                    height: h * 0.03,
                                  ),
                                  SizedBox(
                                    width: w * 0.02,
                                  ),
                                  Text(
                                    "notifications".tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'Alexandria',
                                        color: Color(0xff1D3F5D).withOpacity(0.4)),
                                  ),
                                  Spacer(),
                                  Switch(
                                    activeColor: Color(0xffFFFFFF),
                                    activeTrackColor: Color(0xff1D3F5D),
                                    inactiveThumbColor: Color(0xFFFFFF),
                                    inactiveTrackColor: Color(0xff1D3F5D).withOpacity(0.2),
                                    value: _isSwitched1,
                                    onChanged: (value) {
                                      setState(() {
                                        _isSwitched1 = value;
                                        if (_isSwitched1 == true) {
                                          notificationStatusController
                                              .notificationStatusFunction(
                                              '1', _isSwitched1);
                                        } else {
                                          notificationStatusController
                                              .notificationStatusFunction(
                                              '0', _isSwitched1);
                                        }
                                        print('Switch : ${_isSwitched1}');
                                      });
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                            : SizedBox()
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Center(
                                      child: Dialog(
                                        child: Container(
                                            height: h * 0.41,
                                            width: w,
                                            decoration: BoxDecoration(
                                                color: Color(0xffF1FAFE),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    width: 1,
                                                    color: Color(0xff1F5077))),
                                            child: Column(
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    top: h * 0.030,
                                                  ),
                                                  height: h * 0.14,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "${AppConstants.imgUrl}artboard_img.png"))),
                                                ),
                                                Text(
                                                  textAlign: TextAlign.center,
                                                  "deleteMyAccount".tr,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily: 'Alexandria',
                                                      color: Color(0xff1F5077)),
                                                ),
                                                SizedBox(
                                                  height: h * 0.05,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    deleteAccountController
                                                        .deleteAccountFunction();
                                                  },
                                                  child: Container(
                                                    height: h * 0.043,
                                                    width: w * 0.50,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFFE51D1D),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.white,
                                                          offset: const Offset(
                                                              1, 1),
                                                          blurRadius: 2,
                                                          spreadRadius: 0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text(
                                                      'yesDeleteMyAccount'.tr,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Alexandria',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: h * 0.01),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    height: h * 0.043,
                                                    width: w * 0.50,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: const Color(
                                                          0xFF246DA5),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.white,
                                                          offset: const Offset(
                                                              1, 1),
                                                          blurRadius: 2,
                                                          spreadRadius: 0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Text(
                                                      'no'.tr,
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Alexandria',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: h * 0.05,
                                margin: EdgeInsets.only(top: h * 0.1),
                                decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.07),
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: w * 0.03,
                                    ),
                                    Image.asset(
                                      "${AppConstants.imgUrl}delete_img.png",
                                      height: h * 0.03,
                                    ),
                                    SizedBox(
                                      width: w * 0.02,
                                    ),
                                    Text(
                                      "deleteAccount".tr,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Alexandria',
                                          color: Color(0xffE51D1D)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                logoutController.logoutFunction();
                              },
                              child: Container(
                                height: h * 0.05,
                                decoration: BoxDecoration(
                                  color: Color(0xffFFFFFF),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.07),
                                      blurRadius: 2,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: w * 0.03,
                                    ),
                                    Image.asset(
                                      "${AppConstants.imgUrl}leaveIcon.png",
                                      height: h * 0.025,
                                      color: Color(0xff1D3F5D),
                                    ),
                                    SizedBox(
                                      width: w * 0.02,
                                    ),
                                    Text(
                                      "logout".tr,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'Alexandria',
                                          color: Color(0xff1D3F5D)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: w,
                              margin: EdgeInsets.only(top: h * 0.04),
                              alignment: Alignment.center,
                              child: Text(
                                "Version 2024.21",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Alexandria',
                                    color: Color(0xff1D3F5D).withOpacity(0.2)),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.2,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          logoutController.isloading.value ||
                  deleteAccountController.isloading.value ||
                  updateAccountController.isloading.value ||
                  notificationStatusController.isloading.value
              ? Container(
                  height: h,
                  width: w,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
