
import 'package:flutter/material.dart';
import 'package:franchise_app/screens/reset_password/reset_password_controller.dart';
import 'package:get/get.dart';
import '../../constants/app_constants.dart';

class ResetPassword extends StatelessWidget {
   ResetPassword({super.key, required this.email});

   final String email;

  ResetPasswordController resetPasswordController = Get.put(ResetPasswordController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();


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
              image:  DecorationImage(
                  image: AssetImage("${AppConstants.imgUrl}sign_up_bg.png"),
                  fit: BoxFit.fill)),
    child:  Obx(
    () => resetPasswordController.isloading.value
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
                            height: h * 0.035,
                          ),
                          // Welcome Text
                          Text(
                            'resetPassword'.tr,
                            style: TextStyle(
                              fontFamily: 'Alexandria',
                              fontWeight: FontWeight.w400,
                              fontSize: 29,
                              color: const Color(0xFF1F5077),
                            ),
                          ),
                          SizedBox(height: h * 0.01),

                          // Description Text
                          Container(
                            width: w,
                            margin:
                                EdgeInsets.only(left: w * 0.1, right: w * 0.1),
                            child: Text(
                              'enterNewPassword'.tr,
                              style: TextStyle(
                                fontFamily: 'Alexandria',
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xFF1F5077).withOpacity(0.6),
                              ),
                            ),
                          ),
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
                                  offset: Offset(
                                      0, 2), // Shadow appears at the bottom
                                ),
                              ],
                            ),
                            height: h * 0.06,
                            margin: EdgeInsets.only(
                                top: h * 0.035,
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
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'newPassword'.tr,
                                      contentPadding:
                                          EdgeInsets.only(bottom: h * 0.01),
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
                                  offset: Offset(
                                      0, 2), // Shadow appears at the bottom
                                ),
                              ],
                            ),
                            height: h * 0.06,
                            margin: EdgeInsets.only(
                                top: h * 0.025,
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
                                    controller: cPasswordController,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'confirmNewPassword'.tr,
                                      contentPadding:
                                      EdgeInsets.only(bottom: h * 0.01),
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
                              if (passwordController.text.isEmpty) {
                                Get.snackbar(
                                  'message'.tr,
                                  'enterYourPassword'.tr,
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Color(0xff1F5077),
                                  colorText: Colors.white,
                                );
                              }
                              else if (cPasswordController.text.isEmpty) {
                                Get.snackbar(
                                  'message'.tr,
                                  'confirmYourPassword'.tr,
                                  snackPosition: SnackPosition.TOP,
                                  backgroundColor: Color(0xff1F5077),
                                  colorText: Colors.white,
                                );

                              } else {
                                resetPasswordController.resetPasswordFunction(
                                    email,
                                    passwordController.text,
                                    cPasswordController.text);
                              }
                            },
                            child: Container(
                              height: h*0.052,
                              width: w*0.35,
                              margin: EdgeInsets.only(
                                  top: h * 0.06, bottom: h * 0.04),
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
                                'submit'.tr,
                                style: TextStyle(
                                  fontFamily: 'Alexandria',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: h * 0.19,
                          )
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
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                    AssetImage("assets/images/ellipse.png"))),
                            padding: EdgeInsets.all(10),
                            child: Icon(Icons.arrow_back,size: 22,color: Colors.white,),
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
      )
    );
  }
}
