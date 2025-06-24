import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../constants/app_constants.dart';
import 'otp_controller.dart';

class OtpView extends StatelessWidget {
  final bool? isCheck;
  final String email;

  OtpView({super.key, this.isCheck, required this.email});

  OtpController otpController = Get.put(OtpController());
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Locale? currentLocale = Get.locale;
    String languageCode = currentLocale?.languageCode ?? 'en';
    bool isArabic = languageCode == 'ar'; // Check if the language is Arabic
    print("Language Code: $languageCode");

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("${AppConstants.imgUrl}sign_up_bg.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Obx(
            () => otpController.isloading.value
                ? Container(
                    height: h,
                    width: w,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: h * 0.19,
                          left: isArabic ? w * 0.04 : w * 0.04,
                          // Adjust left margin for RTL
                          right: isArabic
                              ? w * 0.04
                              : w * 0.04, // Adjust right margin for RTL
                        ),
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: isArabic
                              ? Alignment.topRight
                              : Alignment
                                  .topLeft, // Adjust stack alignment for RTL
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: h * 0.03),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: h * 0.035),
                                  // Welcome Text
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: isArabic ? 20 : 0),
                                    child: Text(
                                      'otpVerification'.tr,
                                      // Align text to the right for Arabic
                                      style: TextStyle(
                                        fontFamily: 'Alexandria',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 29,
                                        color: const Color(0xFF1F5077),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01),
                                  // Description Text
                                  Container(
                                    margin: EdgeInsets.only(
                                        right: isArabic ? 20 : 0,
                                        left: isArabic ? 0 : 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              'enterCodeTo'.tr,
                                              style: TextStyle(
                                                fontFamily: 'Alexandria',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: Color(0xFF1F5077)
                                                    .withOpacity(0.6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          // margin: EdgeInsets.only(right: isArabic ? 10 : 0),

                                          child: Row(
                                            children: [
                                              Container(
                                                child: Text(
                                                  'WeSentTo'.tr,
                                                  style: TextStyle(
                                                    fontFamily: 'Alexandria',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16,
                                                    color: Color(0xFF1F5077)
                                                        .withOpacity(0.6),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${email}'.tr,
                                                style: TextStyle(
                                                  fontFamily: 'Alexandria',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: Color(0xFF1F5077)
                                                      .withOpacity(0.6),
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Email TextField Container
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: const Color(0xFFF3F7FC),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 0,
                                          blurRadius: 2,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    height: h * 0.06,
                                    margin: EdgeInsets.only(
                                      top: h * 0.04,
                                      left: isArabic ? w * 0.05 : w * 0.05,
                                      // Adjust left margin for RTL
                                      right: isArabic
                                          ? w * 0.05
                                          : w *
                                              0.05, // Adjust right margin for RTL
                                    ),
                                    padding: EdgeInsets.only(
                                      top: h * 0.005,
                                      bottom: h * 0.005,
                                      left: isArabic ? w * 0.05 : w * 0.05,
                                      // Adjust padding for RTL
                                      right: isArabic
                                          ? w * 0.05
                                          : w * 0.05, // Adjust padding for RTL
                                    ),
                                    child: Row(
                                      children: [
                                        // Email Icon
                                        Image.asset(
                                          'assets/images/otp.png',
                                          width: h * 0.025,
                                        ),
                                        SizedBox(width: w * 0.02),
                                        Container(
                                          height: h * 0.03,
                                          width: 1,
                                          color: Colors.grey[300],
                                        ),
                                        SizedBox(width: w * 0.02),
                                        Expanded(
                                          child: TextField(
                                            controller: codeController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              hintText: 'code'.tr,
                                              contentPadding: EdgeInsets.only(
                                                  bottom: h * 0.01),
                                              hintStyle: TextStyle(
                                                fontFamily: 'Alexandria',
                                                color: const Color(0xFF507780),
                                                fontSize: 17,
                                                fontWeight: FontWeight.w300,
                                              ),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Login Button
                                  InkWell(
                                    onTap: () {
                                      if (codeController.text.isEmpty) {
                                        Get.snackbar(
                                          'Message'.tr,
                                          'Enter your Code'.tr,
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Color(0xff1F5077),
                                          colorText: Colors.white,
                                        );
                                      } else {
                                        otpController.otpFunction(
                                          codeController.text,
                                          email,
                                          isCheck,
                                        );
                                      }
                                    },
                                    child: Container(
                                      height: h * 0.052,
                                      width: w * 0.35,
                                      margin: EdgeInsets.only(
                                        top: h * 0.06,
                                        bottom: h * 0.04,
                                      ),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF19B2E7),
                                        borderRadius: BorderRadius.circular(50),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.white,
                                            offset: const Offset(1, 1),
                                            blurRadius: 2,
                                            spreadRadius: 0,
                                          ),
                                        ],
                                      ),
                                      child: Text(
                                        'verify'.tr,
                                        style: TextStyle(
                                          fontFamily: 'Alexandria',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.23),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: isArabic
                                  ? MainAxisAlignment.end
                                  : MainAxisAlignment.start,
                              // Adjust row alignment for RTL
                              children: [
                                SizedBox(width: w * 0.07),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/images/ellipse.png"),
                                      ),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 22,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
}
