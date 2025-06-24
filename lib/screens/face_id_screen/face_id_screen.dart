import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import '../../constants/app_constants.dart';

class FaceIdScreen extends StatefulWidget {
  const FaceIdScreen({super.key});

  @override
  State<FaceIdScreen> createState() => _FaceIdScreenState();
}

class _FaceIdScreenState extends State<FaceIdScreen> {
  Future<void> _authenticate() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool authenticated = false;

    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your face to authenticate',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } on PlatformException catch (e) {
      print('Error: $e');
    }

    if (authenticated) {
      print('Face ID authenticated!');
    } else {
      print('Face ID authentication failed!');}
  }
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
            image: languageCode=='en'? DecorationImage(
                image: AssetImage(
                    "${AppConstants.imgUrl}branch_info_bg.png"),
                fit: BoxFit.fill): DecorationImage(
                image: AssetImage(
                    "${AppConstants.imgUrl}branch_info_bg_rtl.png"),
                fit: BoxFit.fill)
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: w * 0.75),
                  Container(
                    height: 60,
                    width: 60,
                    margin: EdgeInsets.only(top: h * 0.095),
                    child: Image.asset("assets/images/notification_img.png"),
                  ),
                ],
              ),
              SizedBox(height: h * 0.060),
              Row(
                children: [
                  SizedBox(width: w * 0.055),
                  Icon(
                    Icons.arrow_back_ios_new,
                    color: const Color(0xff1F5077),
                    size: 21,
                  ),
                  SizedBox(width: w * 0.02),
                  Text(
                    "faceID".tr,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Alexandria',
                      color: Color(0xff1F5077),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.035),
              Container(
                height: h * 0.53,
                width: w * 0.88,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: h * 0.025),
                    Text(
                      'scanningYourFace'.tr,
                      style: TextStyle(
                        fontFamily: 'Alexandria',
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Color(0xff1F5077),
                      ),
                    ),
                    SizedBox(height: h * 0.05),
                    Container(
                      height: h * 0.35,
                      width: w * 0.73,
                      padding: EdgeInsets.symmetric(horizontal: w * 0.02),
                      decoration: BoxDecoration(
                        color: const Color(0xff000000).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: h * 0.067),
                            height: h * 0.11,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    "${AppConstants.imgUrl}frame_img.png"),
                              ),
                            ),
                          ),
                          SizedBox(height: h * 0.065),
                          GestureDetector(
                            onTap: () {
                              _authenticate(); // Call Face ID authentication
                            },
                            child: Container(
                              height: h * 0.045,
                              width: w * 0.37,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: const Offset(1, 1),
                                    blurRadius: 2,
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Text(
                                'openCamera'.tr,
                                style: TextStyle(
                                  fontFamily: 'Alexandria',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17,
                                  color: Color(0xff1F5077),
                                ),
                              ),
                            ),
                          ),
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
