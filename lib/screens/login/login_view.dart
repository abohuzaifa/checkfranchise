
import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:franchise_app/screens/login/login_controller.dart';
import 'package:get/get.dart';
import '../forgot_password/forgot_password_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController loginController = Get.put(LoginController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Locale? currentLocale = Get.locale;
    String languageCode = currentLocale?.languageCode ?? 'en';
    print("Language Code: $languageCode");
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF3F7FC),
      body: SingleChildScrollView(
        child: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
              image:  DecorationImage(
                  image: AssetImage("${AppConstants.imgUrl}auth_bg_img.png"),
                  fit: BoxFit.fill)
                 ),
          child: Obx(
            () => loginController.isloading.value
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
                            top: h * 0.24, left: w * 0.04, right: w * 0.04),
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
                                    height: h * 0.04,
                                  ),
                                  // Welcome Text
                                  Text(
                                    'login'.tr,
                                    style: TextStyle(
                                      fontFamily: 'Alexandria',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 29,
                                      color: const Color(0xFF1F5077),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.01),

                                  // Description Text
                                  Text(
                                    'enterInfo'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Alexandria',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Color(0xFF1F5077).withOpacity(0.6),
                                    ),
                                  ),
                                  const SizedBox(height: 20),

                                  // Email TextField Container
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: const Color(0xFFF3F7FC),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.5), // Shadow color
                                          spreadRadius: 0, // Spread radius
                                          blurRadius: 2, // Blur radius
                                          offset: Offset(0,
                                              2), // Shadow appears at the bottom
                                        ),
                                      ],
                                    ),
                                    height: h * 0.06,
                                    margin: EdgeInsets.symmetric(
                                        vertical: h * 0.01,
                                        horizontal: w * 0.05),
                                    padding: EdgeInsets.only(
                                        top: h * 0.005,
                                        bottom: h * 0.005,
                                        left: w * 0.05,
                                        right: w * 0.05),
                                    child: Row(
                                      children: [
                                        // Email Icon
                                        Image.asset(
                                          'assets/images/profile.png',
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
                                            controller: emailController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  bottom: h * 0.01),
                                              hintText: 'email'.tr,
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

                                  // Password TextField Container
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: const Color(0xFFF3F7FC),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withOpacity(0.5), // Shadow color
                                          spreadRadius: 0, // Spread radius
                                          blurRadius: 2, // Blur radius
                                          offset: Offset(0,
                                              2), // Shadow appears at the bottom
                                        ),
                                      ],
                                    ),
                                    height: h * 0.06,
                                    margin: EdgeInsets.only(
                                        top: h * 0.014,
                                        left: w * 0.05,
                                        right: w * 0.05),
                                    padding: EdgeInsets.only(
                                        top: h * 0.005,
                                        bottom: h * 0.005,
                                        left: w * 0.05,
                                        right: w * 0.05),
                                    child: Row(
                                      children: [
                                        // Email Icon
                                        Image.asset(
                                          'assets/images/lock.png',
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
                                            controller: passwordController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  bottom: h * 0.01),
                                              hintText: 'password'.tr,
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
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPasswordView()),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: h * 0.015,
                                          left: w * 0.1,
                                          right: w * 0.1),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'forgotPassword'.tr,
                                        style: TextStyle(
                                          fontFamily: 'Alexandria',
                                          color: const Color(0xFF19B2E7),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Login Button
                                  InkWell(
                                    onTap: () {
                                      if (emailController.text.isEmpty) {
                                        Get.snackbar(
                                          'message'.tr,
                                          'enterYourEmail'.tr,
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Color(0xff1F5077),
                                          colorText: Colors.white,
                                        );
                                      } else if (passwordController
                                          .text.isEmpty) {
                                        Get.snackbar(
                                          'message'.tr,
                                          'enterYourPassword'.tr,
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Color(0xff1F5077),
                                          colorText: Colors.white,
                                        );
                                      } else {
                                        loginController.loginFunction(
                                            passwordController.text,
                                            emailController.text);
                                      }
                                    },
                                    child: Container(
                                      height: h * 0.052,
                                      width: w * 0.35,
                                      margin: EdgeInsets.only(
                                          top: h * 0.03, bottom: h * 0.04),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF1F5077),
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
                                        'login'.tr,
                                        style: TextStyle(
                                          fontFamily: 'Alexandria',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(width: w*0.07,),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child:
                                      Container(
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/images/ellipse.png"))),
                                        padding: EdgeInsets.all(10),
                                       child: Icon(Icons.arrow_back,size: 23,color: Colors.white,),
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
