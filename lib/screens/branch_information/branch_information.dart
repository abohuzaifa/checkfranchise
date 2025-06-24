import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:geocoding/geocoding.dart';
import '../../constants/app_constants.dart';
import '../category_screen/branch_approval_code_controller.dart';
import '../google_map_screen/google_map_screen.dart';
import '../notification_screen/notification_screen.dart';
import 'branch_detai_controller.dart';

class BranchInformation extends StatefulWidget {
  final int? check;
  final String id;
  const BranchInformation({super.key, this.check, required this.id});

  @override
  State<BranchInformation> createState() => _BranchInformationState();
}

class _BranchInformationState extends State<BranchInformation> {
  BranchApprovalCodeController branchApprovalCodeController =
      Get.put(BranchApprovalCodeController());
  TextEditingController codeController = TextEditingController();

  BranchDetailController branchDetailController =
      Get.put(BranchDetailController());
  String address = "";

  @override
  void initState() {
    super.initState();
    print("Widget Id : ${widget.id}");

    branchDetailController.branchDetailFunction(widget.id).then((_) {
      // Check if branchDetailData is not null and contains the 'location' key
      if (branchDetailController.branchDetailData != null &&
          branchDetailController.branchDetailData.containsKey('location')) {
        String location = branchDetailController.branchDetailData['location'].toString();
        print("Location After: $location");

        // Check if the location string is not empty and contains a comma
        if (location.isNotEmpty && location.contains(',')) {
          List<String> latLong = location.split(',');

          // Check if the latLong list has exactly 2 elements
          if (latLong.length == 2) {
            try {
              double latitude = double.parse(latLong[0].trim());
              double longitude = double.parse(latLong[1].trim());

              print('Latitude: $latitude');
              print('Longitude: $longitude');

              fetchAddress(latitude, longitude);
            } catch (e) {
              print('Error parsing latitude or longitude: $e');
            }
          } else {
            print('Invalid location format: expected 2 values separated by a comma');
          }
        } else {
          print('Location is empty or does not contain a comma');
        }
      } else {
        print('Location data is missing in branchDetailData');
      }
    }).catchError((error) {
      print('Error fetching branch details: $error');
    });
  }

  Future<void> fetchAddress(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      Placemark place = placemarks[0];

      String newAddress =
          "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}";

      setState(() {
        address = newAddress; // Update the state to refresh the widget
      });
    } catch (e) {
      setState(() {
        address = "Failed to load address: $e";
      });
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
    return Scaffold(
      body: Obx(
        () => branchDetailController.isloading.value ||
                branchApprovalCodeController.isloading.value
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
                  child: Container(
                    height: h,
                    width: w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "${AppConstants.imgUrl}branch_info_bg.png"),
                            fit: BoxFit.fill)),
                    child: Column(
                      children: [
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Row(
                            children: [
                              SizedBox(
                                width: w * 0.77,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => NotificationScreen());
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  margin: EdgeInsets.only(top: h * 0.095),
                                  child: Image.asset(
                                      "assets/images/notification_img.png"),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: h * 0.055),
                        GestureDetector(
                          onTap: () {
                            if (checkNavigation2.value == 2) {
                              checkNavigation1.value = 1;
                              branchId.value = '';
                            } else {
                              checkNavigation1.value = 2;
                              branchId.value = '';
                            }
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: w * 0.055,
                              ),
                              Icon(
                                Icons.arrow_back_ios_new_rounded,
                                color: Color(0xff1F5077),
                                size: 19,
                              ),
                              SizedBox(
                                width: w * 0.02,
                              ),
                              Text(
                                "branchInformation".tr,
                                style: TextStyle(
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Alexandria',
                                    color: Color(0xff1F5077)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: h * 0.027,
                        ),
                        Container(
                          child: Container(
                            height: h * 0.19,
                            margin: EdgeInsets.only(
                                right: w * 0.055, left: w * 0.055),
                            padding: EdgeInsets.only(
                                right: w * 0.02, left: w * 0.02),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius:
                                        2, // How far the shadow spreads
                                    blurRadius: 5, // Blur effect of the shadow
                                    offset: Offset(0, 3),
                                  )
                                ]),
                            child: Column(children: [
                              SizedBox(
                                height: h * 0.02,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.04,
                                  ),
                                  Text(
                                    "branchName".tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Alexandria',
                                        color: Color(0xff1F5077)),
                                  ),
                                  SizedBox(
                                    width: w * 0.08,
                                  ),
                                  Text(
                                    (branchDetailController.branchDetailData !=
                                                null &&
                                            branchDetailController
                                                .branchDetailData!
                                                .containsKey('branch_name') &&
                                            branchDetailController
                                                        .branchDetailData![
                                                    'branch_name'] !=
                                                null &&
                                            branchDetailController
                                                .branchDetailData![
                                                    'branch_name']
                                                .toString()
                                                .trim()
                                                .isNotEmpty)
                                        ? branchDetailController
                                            .branchDetailData!['branch_name']
                                            .toString()
                                        : "Br.Name Not Available",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Alexandria',
                                      color: Color(0xff193C3E6),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: h * 0.017,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: w * 0.04,
                                  ),
                                  Text(
                                    "branchLocation".tr,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Alexandria',
                                        color: Color(0xff1F5077)),
                                  ),
                                  SizedBox(
                                    width: w * 0.03,
                                  ),
                                  SizedBox(
                                    width: w * 0.4,
                                    child: Text(
                                      address.toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Alexandria',
                                          color: Color(0xff193C3E6)),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: h * 0.03,
                              ),
                              GestureDetector(
                                onTap: () {
                                  String location = branchDetailController
                                      .branchDetailData['location']
                                      .toString();

                                  List<String> latLong = location.split(',');

                                  double latitude =
                                      double.parse(latLong[0].trim());
                                  double longitude =
                                      double.parse(latLong[1].trim());

                                  print('Latitude: $latitude');
                                  print('Longitude: $longitude');
                                  Get.to(() => MapScreen(
                                        latitude: latitude,
                                        longitude: longitude,
                                      ));
                                },
                                child: Container(
                                  height: h * 0.043,
                                  width: w * 0.57,
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
                                    'seeLocation'.tr,
                                    style: TextStyle(
                                      fontFamily: 'Alexandria',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.025,
                        ),
                        Container(
                          height: h * 0.29,
                          margin: EdgeInsets.only(
                              right: w * 0.058, left: w * 0.058),
                          decoration: BoxDecoration(
                            color: Color(0xffE5EFF9),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Shadow color
                                spreadRadius: 0, // Spread radius
                                blurRadius: 5, // Blur radius
                                offset: Offset(
                                    2, 1), // Shadow appears at the bottom
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: w * 0.95,
                                height: h * 0.058,
                                // margin: EdgeInsets.only(right: w * 0.03, left: w * 0.03),
                                decoration: BoxDecoration(
                                    color: Color(0xff1F5077),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20),
                                      topLeft: Radius.circular(20),
                                    )),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: h * 0.013,
                                      bottom: h * 0.01,
                                      left: w * 0.06,
                                      right: w * 0.06),
                                  child: Text(
                                    "newRound".tr,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Alexandria',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.02,
                              ),
                              Text(
                                'enterYourCode'.tr,
                                style: TextStyle(
                                  fontFamily: 'Alexandria',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                  color: Color(0xff1F5077).withOpacity(0.47),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Color(0xFFFFFFFF),
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
                                height: h * 0.052,
                                margin: EdgeInsets.only(
                                    top: h * 0.02,
                                    left: w * 0.15,
                                    right: w * 0.15),
                                padding: EdgeInsets.only(
                                    top: h * 0.005,
                                    bottom: h * 0.005,
                                    left: w * 0.05,
                                    right: w * 0.05),
                                child: TextField(
                                  controller: codeController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: h * 0.015),
                                    hintText: 'code'.tr,
                                    hintStyle: TextStyle(
                                      fontFamily: 'Alexandria',
                                      color: Color(0xFF1F5077).withOpacity(0.3),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: h * 0.025,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    right: w * 0.06, left: w * 0.06),
                                height: 1,
                                color: Color(0xff13293E).withOpacity(0.3),
                              ),
                              Container(
                                height: h * 0.05,
                                width: w * 0.2,
                                margin: EdgeInsets.only(
                                    top: h * 0.02,
                                    left: w * 0.61,
                                    bottom: h * 0.01,
                                    right: w * 0.055),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF43911F),
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(1, 1),
                                      blurRadius: 2,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                ),
                                child: InkWell(
                                  onTap: () {
                                    if (codeController.text.isEmpty) {
                                      Get.snackbar(
                                        'message'.tr,
                                        'enterYourCode'.tr,
                                        snackPosition: SnackPosition.TOP,
                                        backgroundColor: Color(0xff1F5077),
                                        colorText: Colors.white,
                                      );
                                    } else {
                                      branchApprovalCodeController
                                          .branchApprovalCodeFunction(
                                              codeController.text,
                                              branchDetailController
                                                  .branchDetailData["id"]
                                                  .toString());
                                    }
                                  },
                                  child: Text(
                                    'start'.tr,
                                    style: TextStyle(
                                      fontFamily: 'Alexandria',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      color: Colors.white,
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
                ),
              ),
      ),
    );
  }
}
