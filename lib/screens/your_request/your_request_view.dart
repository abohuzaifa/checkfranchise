import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:franchise_app/screens/login/login_view.dart';
import 'package:get/get.dart';

import '../../constants/app_constants.dart';
import '../bottom_bar_screen/bottom_bar_screen.dart';

class YourRequestView extends StatelessWidget {
  const YourRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    Locale? currentLocale = Get.locale;
    String languageCode = currentLocale?.languageCode ?? 'en';
    print("Language Code: $languageCode");
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
              image: languageCode == 'en'
                  ? DecorationImage(
                      image: AssetImage("${AppConstants.imgUrl}sign_up_bg.png"),
                      fit: BoxFit.fill)
                  : DecorationImage(
                      image: AssetImage(
                          "${AppConstants.imgUrl}sign_up_bg_rtl.png"),
                      fit: BoxFit.fill)),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    top: h * 0.19, left: w * 0.04, right: w * 0.04),
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.topLeft,
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
                          SizedBox(
                            height: h * 0.036,
                          ),
                          // Welcome Text
                          Text(
                            'yourRequest'.tr,
                            style: TextStyle(
                              fontFamily: 'Alexandria',
                              fontWeight: FontWeight.w400,
                              fontSize: 29,
                              color: const Color(0xFF1F5077),
                            ),
                          ),
                          SizedBox(height: h * 0.060),

                          // Description Text
                          Container(
                            width: w,
                            margin:
                                EdgeInsets.only(left: w * 0.1, right: w * 0.1),
                            child: Text(
                              'yourRegistration'.tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Alexandria',
                                fontWeight: FontWeight.w400,
                                fontSize: 18,
                                color: Color(0xFF1F5077).withOpacity(0.6),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.snackbar(
                                'Message'.tr,
                                'Your Account needs approval by Admin'.tr,
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Color(0xff1F5077),
                                colorText: Colors.white,

                              );
                              Get.offAll(() => LoginView());
                            },
                            child: Container(
                              height: h * 0.055, // Fixed height
                              width: w * 0.44, // Fixed width
                              margin: EdgeInsets.only(top: h * 0.15, bottom: h * 0.04), // Margin for positioning
                              padding: EdgeInsets.symmetric(horizontal: 10), // Add horizontal padding for text
                              alignment: Alignment.center, // Center the text
                              decoration: BoxDecoration(
                                color: const Color(0xFF19B2E7),
                                borderRadius: BorderRadius.circular(50), // Rounded corners
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(1, 1),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown, // Scale down text if it overflows
                                child: Text(
                                  'backToHome'.tr, // Translated text
                                  style: TextStyle(
                                    fontFamily: 'Alexandria',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center, // Center-align the text
                                  overflow: TextOverflow.ellipsis, // Handle overflow with ellipsis
                                ),
                              ),
                            ),
                          ),                          SizedBox(
                            height: h * 0.035,
                          )
                        ],
                      ),
                    ),
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
