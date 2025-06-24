import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:franchise_app/screens/signup/signup_controller.dart';
import 'package:get/get.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  SignupController signupController = Get.put(SignupController());
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController nameController = TextEditingController();

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
            image: DecorationImage(
                image: AssetImage("${AppConstants.imgUrl}sign_up_bg.png"),
                fit: BoxFit.fill),
          ),
          child: Obx(
            () => signupController.isloading.value
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
                                    height: h * 0.04,
                                  ),
                                  // Welcome Text
                                  Text(
                                    'signUp'.tr,
                                    style: TextStyle(
                                      fontFamily: 'Alexandria',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 29,
                                      color: const Color(0xFF1F5077),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.012),

                                  // Description Text
                                  Text(
                                    'enterData'.tr,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Alexandria',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17,
                                      color: const Color(0xFF507799),
                                    ),
                                  ),
                                  SizedBox(height: h * 0.007),
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
                                    margin: EdgeInsets.only(
                                        top: h * 0.01,
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
                                            controller: nameController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  bottom: h * 0.01),
                                              hintText: 'fullName'.tr,
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
                                          'assets/images/phone.png',
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
                                            controller: mobileController,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  bottom: h * 0.01),
                                              hintText: 'phoneNumber'.tr,
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
                                          offset: Offset(0,
                                              2), // Shadow appears at the bottom
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
                                          'assets/images/mail.png',
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
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  bottom: h * 0.01),
                                              hintText: 'confirmPassword'.tr,
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
                                      if (emailController.text.isEmpty) {
                                        Get.snackbar(
                                          'Message'.tr,
                                          'Enter your Email'.tr,
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
                                      }
                                      if (cPasswordController.text.isEmpty) {
                                        Get.snackbar(
                                          'message'.tr,
                                          'confirmYourPassword'.tr,
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Color(0xff1F5077),
                                          colorText: Colors.white,
                                        );
                                      }
                                      if (nameController.text.isEmpty) {
                                        Get.snackbar(
                                          'message'.tr,
                                          'enterYourName'.tr,
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Color(0xff1F5077),
                                          colorText: Colors.white,
                                        );
                                      }
                                      if (mobileController.text.isEmpty) {
                                        Get.snackbar(
                                          'message'.tr,
                                          'enterYourPhoneNumber'.tr,
                                          snackPosition: SnackPosition.TOP,
                                          backgroundColor: Color(0xff1F5077),
                                          colorText: Colors.white,
                                        );
                                      } else {
                                        signupController.signupFunction(
                                            passwordController.text,
                                            mobileController.text,
                                            nameController.text,
                                            cPasswordController.text,
                                            emailController.text);
                                      }
                                    },
                                    child: Container(
                                      height: h * 0.052,
                                      width: w * 0.35,
                                      margin: EdgeInsets.only(
                                          top: h * 0.07, bottom: h * 0.04),
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
                                        'signUp'.tr,
                                        style: TextStyle(
                                          fontFamily: 'Alexandria',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
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
                                SizedBox(
                                  width: w * 0.07,
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/ellipse.png"))),
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

  Widget _buildInputField({
    required String hintText,
    required String icon,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFFF3F7FC),
      ),
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Image.asset(
            icon,
            width: 24,
            height: 24,
          ),
          const SizedBox(width: 20),
          Container(
            height: 30,
            width: 5,
            color: Colors.grey[300],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: TextField(
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: const Color(0xFF507780),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
