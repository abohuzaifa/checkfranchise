import 'package:flutter/material.dart';
import 'package:franchise_app/screens/select_service/select_service_logic.dart';
import 'package:get/get.dart';

import '../question_answer_session/question_answer_view.dart';

class SelectServiceView extends StatelessWidget {
  const SelectServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SelectServiceLogic>(
      init: SelectServiceLogic(),
      builder: (logic) {
        return Scaffold(
          backgroundColor: Colors.white, // Set the background color
          body: SafeArea(
            child: Column(
              children: [
                // Header Section
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: Row(
                    children: [
                      // First Image Container
                      Container(
                        width: 120,
                        height: 80,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/images/bulletStyleIcon.png',
                              fit: BoxFit.fill,
                              color: const Color(0xFF19B2E7),
                              errorBuilder: (BuildContext context, Object error,
                                  StackTrace? stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),
                            Center(
                              child: Image.asset(
                                'assets/images/meshraqTitleImage.png',
                                height: 120,
                                width: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      // Second Image Container
                      InkWell(
                        onTap: () {
                          // logic.goToNotifications();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          width: 50,
                          height: 50,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                'assets/images/ellipseLightBlue.png',
                                fit: BoxFit.cover,
                                errorBuilder: (BuildContext context,
                                    Object error, StackTrace? stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Image.asset(
                                  'assets/images/whiteBell.png',
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Expanded section
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      // color: Colors.black,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    // padding: const EdgeInsets.all(20),
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // First Container
                              Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF507799),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 20, // Reduced width
                                        height: 20, // Reduced height
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // White background for the wrapping container
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          // Adjusted rounded corners
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              blurRadius: 4,
                                              // Slightly smaller blur
                                              spreadRadius: 1,
                                              // Reduced spread
                                              offset: Offset(0,
                                                  2), // Adjusted shadow position
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/profileIcon.png',
                                            width: 16,
                                            // Reduced width for the image
                                            height: 16,
                                            // Reduced height for the image
                                            fit: BoxFit.contain,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.error,
                                                color: Colors.red,
                                                size: 16, // Smaller error icon
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Flexible(
                                        child: Text(
                                          'Grgir Person',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Second Container
                              Flexible(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF93C3E6),
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 15,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 20, // Reduced width
                                        height: 20, // Reduced height
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // White background for the wrapping container
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          // Adjusted rounded corners
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              blurRadius: 4,
                                              // Slightly smaller blur
                                              spreadRadius: 1,
                                              // Reduced spread
                                              offset: Offset(0,
                                                  2), // Adjusted shadow position
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            'assets/images/calenderIcon.png',
                                            width: 16,
                                            // Reduced width for the image
                                            height: 16,
                                            // Reduced height for the image
                                            fit: BoxFit.contain,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.error,
                                                color: Colors.red,
                                                size: 16, // Smaller error icon
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      const Flexible(
                                        child: Text(
                                          '18 - May - 2021',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Alexandria',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 0.5,
                            color: Colors.grey,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 40, // Fixed height for the container
                            width: double.infinity, // Full width
                            decoration: BoxDecoration(
                              color: Color(0xFFE5EFF9),
                              // Background color for the container
                              borderRadius: BorderRadius.circular(10),
                              // Rounded corners
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 4, // Subtle shadow blur
                                  spreadRadius: 1,
                                  offset: Offset(0, 2), // Shadow position
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Search Icon
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Image.asset(
                                    'assets/images/searchIcon.png',
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.contain,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                        size: 20,
                                      );
                                    },
                                  ),
                                ),
                                // TextField
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      // Removes the default border
                                      hintText: 'search'.tr,
                                      hintStyle: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left:
                                              8.0), // Adjust padding for hint text to center it
                                    ),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: MediaQuery.of(context).size.height / 2,
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                // Two items per row
                                crossAxisSpacing: 15,
                                // Increased horizontal spacing
                                mainAxisSpacing: 15,
                                // Increased vertical spacing
                                childAspectRatio:
                                    1, // Ensures the width-to-height ratio
                              ),
                              itemCount: 10, // Total number of items
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: (){
                                    Get.to(()=>QuestionAnswerView());
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF9CB3C5),
                                      // Background color
                                      borderRadius: BorderRadius.circular(
                                          40), // Circular border
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      // Margin inside the parent container
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          // Image container
                                          Expanded(
                                            child: Container(
                                              width: double.infinity,
                                              // Fills the width of the container
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(40),
                                                  topLeft: Radius.circular(40),
                                                ), // Same decoration
                                              ),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(40),
                                                  topLeft: Radius.circular(40),
                                                ), // Same decoration
                                                child: Image.asset(
                                                  'assets/images/dummyFood.png',
                                                  fit: BoxFit
                                                      .cover, // Scales image to cover the container
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          // Spacing between image and text
                                          // Item Name
                                          Text(
                                            "itemName".tr,
                                            style: TextStyle(
                                              fontFamily: 'Alexandria',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xFF1F5077),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // Space evenly between the two containers
                    children: [
                      // First Container
                      Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          // Yellow background for the first container
                          borderRadius:
                              BorderRadius.circular(20), // Rounded corners
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Continue Icon
                            Image.asset(
                              'assets/images/continueIcon.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(width: 10), // Space between icon and text
                            // Continue Text
                            Text(
                              'continue'.tr,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                color: Colors.black, // Text color
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Second Container
                      InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Center(
                                child: Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    width: 300, // Fixed width for the dialog
                                    height: 290, // Fixed height for the dialog
                                    child: Column(
                                      children: [
                                        // Container for "Sure to leave" Text
                                        Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF1F5077),
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10),
                                            ),
                                          ),
                                          padding: EdgeInsets.all(16),
                                          child: Row(
                                            children: [
                                              Text(
                                                'sureToLeave'.tr,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 22,
                                                  color: Colors.white,
                                                  fontFamily: 'Alexandria'
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Main content container with a fixed height
                                        Expanded(
                                          child: Container(
                                            padding: EdgeInsets.all(20),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                // Main message
                                                Text(
                                                  "confirmToLeave".tr,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(

                                                    fontFamily: 'Alexandria',
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.blue[200],
                                                  ),
                                                  // maxLines: 4,
                                                ),
                                                SizedBox(height: 20),
                                                // Custom buttons ("No" and "Yes")
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // "No" button
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context).pop(
                                                            false); // Don't leave
                                                      },
                                                      child: Container(
                                                        width: 100,
                                                        height: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFF1F5077),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'no'.tr,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 20),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Navigator.of(context).pop(
                                                            true); // Confirm leave
                                                      },
                                                      child: Container(
                                                        width: 100,
                                                        height: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.red,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          'yesLeave'.tr,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          width: 150,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Leave Icon
                              Image.asset(
                                'assets/images/leaveIcon.png',
                                width: 30,
                                height: 30,
                                fit: BoxFit.contain,
                              ),
                              SizedBox(width: 10),
                              // Leave Text
                              Text(
                                'leave'.tr,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
