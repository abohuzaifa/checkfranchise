import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../login/login_view.dart';
import '../signup/signup_view.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    Locale? currentLocale = Get.locale;
    String languageCode = currentLocale?.languageCode ?? 'en';
    print("Language Code: $languageCode");
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF3F7FC),
      body: Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("${AppConstants.imgUrl}auth_bg_img.png"),
              fit: BoxFit.fill),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: h * 0.3, left: w * 0.04, right: w * 0.04),
              padding: EdgeInsets.only(
                bottom: h * 0.05,
              ),
              // Margin from left and right
              decoration: BoxDecoration(
                color: Colors.white,
                // Background color of the container
                borderRadius: BorderRadius.circular(35),
                // Apply a border radius of 20
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // Subtle shadow
                    blurRadius: 10,
                    offset: const Offset(0, 4), // Shadow offset
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (languageCode == 'en') {
                              Get.updateLocale(Locale('ar', 'AR'));
                              GetStorage().write('selectedLanguage',
                                  'ar'); // Save the selected language
                              languageCode = 'ar';
                            } else {
                              Get.updateLocale(Locale('en', 'US'));
                              GetStorage().write('selectedLanguage',
                                  'en'); // Save the selected language
                              languageCode = 'en';
                            }
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: h * 0.06,
                          width: w * 0.21,
                          decoration: BoxDecoration(
                            color: Color(0xff1F5077),
                            borderRadius: languageCode == 'en'
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(35),
                                    bottomRight: Radius.circular(25),
                                  )
                                : BorderRadius.only(
                                    topRight: Radius.circular(35),
                                    bottomLeft: Radius.circular(25),
                                  ),
                          ),
                          child: Text(
                            languageCode == 'en' ? 'AR' : 'EN',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Alexandria',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Text(
                    'welcome'.tr,
                    style: TextStyle(
                      fontFamily: 'Alexandria', // Ensure font is defined
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                      color: Color(0xFF1F5077),
                    ),
                  ),
                  SizedBox(height: h * 0.03), // Space between elements
                  // Description Text
                  Text(
                    'followWork'.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Alexandria',
                      fontWeight: FontWeight.w400,
                      fontSize: 17,
                      color: const Color(0xFF507799),
                    ),
                  ),
                  SizedBox(height: h * 0.04), // Space between elements
                  // Ready Text
                  Text(
                    "ready".tr,
                    style: TextStyle(
                      fontFamily: 'Alexandria',
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                      color: const Color(0xFF507799),
                    ),
                  ),
                  SizedBox(height: h * 0.05), // Space between elements
                  // Buttons Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Sign Up Container
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupView()),
                          );
                        },
                        child: Container(
                          height: h * 0.06,
                          width: w * 0.38,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF19B2E7), Color(0xFF1A9ED0)],
                              // Gradient colors
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(25),
                            // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFFFFFF),
                                // Semi-transparent black (adjust the opacity as needed)
                                offset: Offset(1, 1),
                                // X and Y offset (1px each)
                                blurRadius: 2,
                                // Blur radius (2px)
                                spreadRadius: 0, // Spread radius (0px)
                              ),
                            ],
                          ),
                          child: Text(
                            'signUp'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500, // Font weight of 500
                              fontSize: 18, // Font size of 22px
                              color:
                                  Colors.white, // Text color white for contrast
                            ),
                          ),
                        ),
                      ),

                      // Login Container
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginView()),
                          );
                        },
                        child: Container(
                          height: h * 0.06,
                          width: w * 0.38,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF1F5077), Color(0xFF3A95DD)],
                              // Gradient colors
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                            borderRadius: BorderRadius.circular(25),
                            // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFFFFFFFF),
                                // Semi-transparent black (adjust the opacity as needed)
                                offset: Offset(1, 1),
                                // X and Y offset (1px each)
                                blurRadius: 2,
                                // Blur radius (2px)
                                spreadRadius: 0, // Spread radius (0px)
                              ),
                            ],
                          ),
                          child: Text(
                            'login'.tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500, // Font weight of 500
                              fontSize: 18, // Font size of 22px
                              color:
                                  Colors.white, // Text color white for contrast
                            ),
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
    );
  }
}
