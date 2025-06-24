import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:franchise_app/screens/all_branches_screen/city_list_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../notification_screen/notification_screen.dart';
import 'all_branches_controller.dart';

class AllBranchesScreen extends StatefulWidget {
  const AllBranchesScreen({super.key});

  @override
  State<AllBranchesScreen> createState() => _AllBranchesScreenState();
}

class _AllBranchesScreenState extends State<AllBranchesScreen> {
  String? selectedCity;
  AllBranchesController allBranchesController =
      Get.put(AllBranchesController());
  CityListController cityListController = Get.put(CityListController());

  @override
  void initState() {

    super.initState();
    allBranchesController.allBranchesFunction();
    cityListController.cityListFunction();
    print("This is get token ${GetStorage().read("token")}");
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
      () => allBranchesController.isloading.value
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
                                child: Image.asset(
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
                        // Title and "Show All" Row
                        Container(
                          margin: EdgeInsets.only(top: h * 0.05),
                          padding: EdgeInsets.only(
                              top: h * 0.03, left: w * 0.05, right: w * 0.05),
                          decoration: BoxDecoration(
                              color: Color(0xffF3F7FC),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  top: h * 0.02,
                                ),
                                padding: EdgeInsets.only(
                                    left: w * 0.03, right: w * 0.03,),
                                height: h * 0.05,
                                width: w * 0.46,
                                decoration: BoxDecoration(
                                  color: Color(0xFFE5EFF9),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                      Colors.grey.withOpacity(0.5), // Shadow color
                                      spreadRadius: 0, // Spread radius
                                      blurRadius: 2, // Blur radius
                                      offset:
                                      Offset(2, 1), // Shadow appears at the bottom
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DropdownButton<String>(
                                      value: selectedCity,
                                      hint: Text('selectACity'.tr,
                                        style: TextStyle(
                                          color: Color(0xff1F5077).withOpacity(0.6),
                                          fontSize: 17,
                                          fontWeight:
                                          FontWeight.w500,
                                          fontFamily: 'Alexandria',
                                        ),),
                                      underline: SizedBox(),
                                      icon:  Image.asset(
                                        'assets/images/dropDown.png',
                                        height: 19,
                                        width: 19,
                                      ) ,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedCity = newValue;
                                        });
                                      },
                                      items: cityListController.cityList
                                          .map((city) {
                                        return DropdownMenuItem<String>(
                                          value: city.cityName,
                                          child: SizedBox(
                                              width: w * 0.33,
                                              child: languageCode == 'en'? Text(
                                                city.cityName,
                                                overflow: TextOverflow.ellipsis,
                                              ): Text(
                                                city.cityNameAr,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                        );
                                      }).toList(),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: h * 0.04),
                                child: Row(
                                  children: [
                                    Text(
                                      'allBranches'.tr,
                                      style: TextStyle(
                                        fontFamily: 'Alexandria',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                        color:
                                            Color(0xFF1F5077),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: h * 0.02,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.all(0),
                                scrollDirection: Axis.vertical,
                                itemCount: allBranchesController.branchesData.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      print("ID : ${ allBranchesController.branchesData[index]['id'].toString()}");
                                      branchId.value =  allBranchesController.branchesData[index]['id'].toString();
                                      checkNavigation1.value = 3;
                                      checkNavigation2.value = 3;

                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: h * 0.02),
                                      height: h * 0.21,
                                      width: w * 0.4,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Color(0xffFFFFFF),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: h * 0.15,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              child:
                                              CachedNetworkImage(
                                                  imageUrl: "${AppConstants.branchImgUrl}${allBranchesController.branchesData[index]['header_image']}",
                                                fit: BoxFit.fill,
                                                width: double.infinity,
                                                  placeholder: (context, url) =>   Image.asset(
                                                    'assets/images/all_ranches_food_img.png',
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                  ),
                                                  errorWidget: (context, url, error) =>   Image.asset(
                                                    'assets/images/all_ranches_food_img.png',
                                                    fit: BoxFit.cover,
                                                    width: double.infinity,
                                                  ),
                                                  fadeInDuration: Duration(milliseconds: 500),
                                              )

                                            ),
                                          ),
                                          // Row for name and small image
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: w * 0.05,
                                              right: w * 0.05,
                                              bottom: h * 0.01,
                                            ),
                                            child: SizedBox(
                                              height: 30,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Container(
                                                    width: w * 0.4, // 👈 40% of screen width, adjust as needed
                                                    child: Text(
                                                      allBranchesController.branchesData[index]['branch_name'].toString(),
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontFamily: 'Alexandria',
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xFF1F5077),
                                                      ),
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                  SizedBox(width: 8), // optional spacing
                                                  Image.asset('assets/images/indication.png'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                height: h * 0.2,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        checkNavigation1.value = 1;
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        margin: EdgeInsets.only(
                            top: h * 0.235, left: w * 0.05, right: w * 0.05),
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Color(0xff1F5077),
                          size: 20,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
