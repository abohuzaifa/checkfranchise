import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../select_service/select_service_view.dart';
import 'bottom_bar_host_logic.dart';

class BottomBarHostView extends StatelessWidget {
  const BottomBarHostView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomBarHostController>(
        init: BottomBarHostController(),
        builder: (logic) {
          return WillPopScope(
            onWillPop: () async {
              // Show the alert dialog when trying to go back
              if (logic.selectedBranch.value == true) {
                logic.goToBranches();
              } else if (logic.branchesSelected.value == true) {
                logic.backToAllView();
              } else if (logic.start.value == true) {
                logic.backToSelectedBranch();
              } else if (logic.bellSelected.value == true) {
                logic.backToAllView();
              } else {
                // Show the exit confirmation dialog
                bool exitApp = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Exit App'),
                      content: Text('Are you sure you want to exit the app?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pop(false); // Don't exit the app
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true); // Exit the app
                          },
                          child: Text('Exit'),
                        ),
                      ],
                    );
                  },
                );

                if (exitApp == true) {
                  SystemNavigator.pop(); // Exit the app
                }
              }

              return false; // Return false to prevent default back navigation behavior
            },
            child: Scaffold(
              backgroundColor: logic.selectedBranch.value == true
                  ? Colors.white
                  : logic.start.value == true
                      ? Colors.white
                      : Color(0xFF1F5077),
              // Set the background color
              body: SafeArea(
                child: Stack(
                  children: [
                    Column(
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
                                  children: [
                                    Image.asset(
                                      'assets/images/bulletStyleIcon.png',
                                      fit: BoxFit.fill,
                                      color: logic.selectedBranch.value == true
                                          ? Color(0xFF19B2E7)
                                          : logic.start.value == true
                                              ? Color(0xFF19B2E7)
                                              : Colors.white,
                                      errorBuilder: (BuildContext context,
                                          Object error,
                                          StackTrace? stackTrace) {
                                        return const Icon(Icons.error);
                                      },
                                    ),
                                    Center(
                                      child: logic.selectedBranch.value == true
                                          ? Image.asset(
                                              'assets/images/meshraqTitleImage.png',
                                              height: 120,
                                              width: 120,
                                              fit: BoxFit.cover,
                                            )
                                          : logic.start.value == true
                                              ? Image.asset(
                                                  'assets/images/meshraqTitleImage.png',
                                                  height: 120,
                                                  width: 120,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'assets/images/meshraqTitleBlueImage.png',
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
                                  logic.goToNotifications();
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 20),
                                  width: 50,
                                  height: 50,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      logic.selectedBranch.value == true
                                          ? Image.asset(
                                              'assets/images/ellipseLightBlue.png',
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (BuildContext context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                return const Icon(Icons.error);
                                              },
                                            )
                                          : logic.start.value == true
                                              ? Image.asset(
                                                  'assets/images/ellipseLightBlue.png',
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                    return const Icon(
                                                        Icons.error);
                                                  },
                                                )
                                              : Image.asset(
                                                  'assets/images/whiteEllipse.png',
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                    return const Icon(
                                                        Icons.error);
                                                  },
                                                ),
                                      Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: logic.selectedBranch.value ==
                                                true
                                            ? Image.asset(
                                                'assets/images/whiteBell.png',
                                                fit: BoxFit.cover,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object error,
                                                    StackTrace? stackTrace) {
                                                  return const Icon(
                                                      Icons.error);
                                                },
                                              )
                                            : logic.start.value == true
                                                ? Image.asset(
                                                    'assets/images/whiteBell.png',
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object error,
                                                            StackTrace?
                                                                stackTrace) {
                                                      return const Icon(
                                                          Icons.error);
                                                    },
                                                  )
                                                : Image.asset(
                                                    'assets/images/bell.png',
                                                    fit: BoxFit.cover,
                                                    errorBuilder:
                                                        (BuildContext context,
                                                            Object error,
                                                            StackTrace?
                                                                stackTrace) {
                                                      return const Icon(
                                                          Icons.error);
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
                        Container(
                          margin: const EdgeInsets.only(left: 20, top: 20),
                          child: logic.selectedBranch.value == true
                              ? Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        logic.backToBranchesView();
                                      },
                                      child: Image.asset(
                                        'assets/images/arrowBack.png',
                                        height: 15,
                                        width: 15,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: Text(
                                        'Branch Information',
                                        style: TextStyle(
                                          fontFamily: 'Alexandria',
                                          fontWeight: FontWeight.w400,
                                          fontSize: 22,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : logic.start.value == true
                                  ? Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            logic.backToSelectedBranch();
                                          },
                                          child: Image.asset(
                                            'assets/images/arrowBack.png',
                                            height: 15,
                                            width: 15,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: 10,
                                          ),
                                          child: Text(
                                            'Face ID',
                                            style: TextStyle(
                                              fontFamily: 'Alexandria',
                                              fontWeight: FontWeight.w400,
                                              fontSize: 22,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : logic.reports.value == true
                                      ? Text(
                                          '',
                                          style: TextStyle(
                                            fontFamily: 'Alexandria',
                                            fontWeight: FontWeight.w400,
                                            fontSize: 22,
                                            color: Colors.white,
                                          ),
                                        )
                                      : logic.account.value == true
                                          ? Text(
                                              '',
                                              style: TextStyle(
                                                fontFamily: 'Alexandria',
                                                fontWeight: FontWeight.w400,
                                                fontSize: 22,
                                                color: Colors.white,
                                              ),
                                            )
                                          : logic.bellSelected.value == true
                                              ? const Text(
                                                  '',
                                                  style: TextStyle(
                                                    fontFamily: 'Alexandria',
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 22,
                                                    color: Colors.white,
                                                  ),
                                                )
                                              : Row(
                                                  children: [
                                                    Text(
                                                      'Hi, Grgir person',
                                                      style: TextStyle(
                                                        fontFamily:
                                                            'Alexandria',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 22,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                        ),
                        const SizedBox(height: 20),

                   SingleChildScrollView(
                     child: Column(children: [
                       logic.selectedBranch.value == true
                           ? Center(
                         child: Container(
                           margin: EdgeInsets.symmetric(
                               horizontal: 20, vertical: 15),
                           // Adds space around the container
                           decoration: BoxDecoration(
                             color: Colors.white,
                             borderRadius: BorderRadius.circular(12),
                             // Rounded corners for the container
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.5),
                                 spreadRadius: 2,
                                 blurRadius: 10,
                                 offset: Offset(0, 3), // Shadow position
                               ),
                             ],
                           ),
                           padding: EdgeInsets.all(16),
                           // Inner padding for the container
                           child: Column(
                             mainAxisSize: MainAxisSize.min,
                             crossAxisAlignment:
                             CrossAxisAlignment.start,
                             children: [
                               // First Row: Branch Name
                               Row(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     'Branch Name:',
                                     style: TextStyle(
                                       fontFamily: 'Alexandria',
                                       fontSize: 16,
                                       fontWeight: FontWeight.w500,
                                       color: Color(0xFF1F5077),
                                     ),
                                   ),
                                   SizedBox(width: 8),
                                   Expanded(
                                     child: Text(
                                       'Mishraq Sultana',
                                       style: TextStyle(
                                         fontFamily: 'Alexandria',
                                         fontSize: 16,
                                         fontWeight: FontWeight.w400,
                                         color: Color(0xFF19B2E7),
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 12),
                               // Increased space between rows for better readability
                               // Second Row: Branch Location
                               Row(
                                 crossAxisAlignment:
                                 CrossAxisAlignment.start,
                                 children: [
                                   Text(
                                     'Branch Location:',
                                     style: TextStyle(
                                       fontFamily: 'Alexandria',
                                       fontSize: 16,
                                       fontWeight: FontWeight.w500,
                                       color: Color(0xFF1F5077),
                                     ),
                                   ),
                                   SizedBox(width: 8),
                                   Expanded(
                                     child: Text(
                                       'Mishraq Sultana',
                                       style: TextStyle(
                                         fontFamily: 'Alexandria',
                                         fontSize: 16,
                                         fontWeight: FontWeight.w400,
                                         color: Color(0xFF19B2E7),
                                       ),
                                     ),
                                   ),
                                 ],
                               ),
                               SizedBox(height: 20),
                               // Extra space before the button
                               // Button-like Container
                               Center(
                                   child: GestureDetector(
                                     onTap: () {
                                       // Handle tap action here
                                     },
                                     child: Container(
                                       width: 250,
                                       // Button width
                                       decoration: BoxDecoration(
                                         color: Color(0xFF1F5077),
                                         borderRadius:
                                         BorderRadius.circular(30),
                                       ),
                                       padding: EdgeInsets.symmetric(
                                           horizontal: 16, vertical: 12),
                                       alignment: Alignment.center,
                                       child: Text(
                                         'See location on the map',
                                         style: TextStyle(
                                           fontFamily: 'Alexandria',
                                           fontSize: 16,
                                           fontWeight: FontWeight.w500,
                                           color: Colors.white,
                                         ),
                                       ),
                                     ),
                                   ))
                             ],
                           ),
                         ),
                       )
                           : Container(),

                       logic.selectedBranch.value == true
                           ? Center(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             // First Container: "New Round"
                             Container(
                               margin:
                               EdgeInsets.only(left: 20, right: 20),
                               height: 45,
                               width: double.infinity,
                               // Full width
                               decoration: BoxDecoration(
                                 color: Color(0xFF1F5077),
                                 borderRadius: BorderRadius.only(
                                   topLeft: Radius.circular(30),
                                   topRight: Radius.circular(30),
                                 ),
                               ),
                               child: Container(
                                 margin: EdgeInsets.only(left: 20),
                                 child: Row(
                                   children: [
                                     Text(
                                       'New Round',
                                       style: TextStyle(
                                         fontSize: 22,
                                         fontWeight: FontWeight.w500,
                                         color: Colors.white,
                                       ),
                                     ),
                                   ],
                                 ),
                               ),
                             ),
                             // Second Container

                             Container(
                               margin:
                               EdgeInsets.only(left: 20, right: 20),

                               // height: 200,
                               width: double.infinity,
                               // Full width
                               decoration: BoxDecoration(
                                 color: Colors.white,
                                 borderRadius: BorderRadius.only(
                                   bottomLeft: Radius.circular(30),
                                   bottomRight: Radius.circular(30),
                                 ),
                                 boxShadow: [
                                   BoxShadow(
                                     color: Colors.grey.withOpacity(0.3),
                                     spreadRadius: 2,
                                     blurRadius: 10,
                                     offset:
                                     Offset(0, 3), // Shadow position
                                   ),
                                 ],
                               ),
                               child: Padding(
                                 padding: EdgeInsets.all(16),
                                 // Padding for inner content
                                 child: Column(
                                   crossAxisAlignment:
                                   CrossAxisAlignment.start,
                                   children: [
                                     // First Text: "Enter your code to start a new round"
                                     Text(
                                       'Enter your code to start a new round',
                                       style: TextStyle(
                                         color: Color(0xFF507780),
                                         fontWeight: FontWeight.w400,
                                         fontSize: 16,
                                       ),
                                     ),
                                     SizedBox(height: 20),
                                     // Space between text and next widget

                                     // Second Child: Rounded Container with TextField
                                     Center(
                                       child: Container(
                                         width: 150,
                                         decoration: BoxDecoration(
                                           color: Colors.white,
                                           borderRadius:
                                           BorderRadius.circular(30),
                                           boxShadow: [
                                             BoxShadow(
                                               color: Colors.grey
                                                   .withOpacity(0.3),
                                               spreadRadius: 2,
                                               blurRadius: 10,
                                               offset: Offset(0,
                                                   3), // Shadow position
                                             ),
                                           ],
                                         ),
                                         child: TextField(
                                           decoration: InputDecoration(
                                             hintText: 'Code',
                                             contentPadding:
                                             EdgeInsets.symmetric(
                                                 horizontal: 16,
                                                 vertical: 12),
                                             border: InputBorder
                                                 .none, // Remove default borders
                                           ),
                                         ),
                                       ),
                                     ),
                                     SizedBox(height: 20),
                                     // Space before divider

                                     // Third Child: Grey Divider
                                     Container(
                                       width: double.infinity,
                                       height: 2,
                                       color: Colors.grey[300],
                                     ),
                                     SizedBox(height: 20),
                                     // Space before the button

                                     // Fourth Child: Rounded Start Button
                                     Row(
                                       children: [
                                         Spacer(),
                                         GestureDetector(
                                           onTap: () {
                                             // Handle button press
                                             logic.makeStart();
                                           },
                                           child: Container(
                                             width: 100,
                                             height: 50,
                                             decoration: BoxDecoration(
                                               color: Color(0xFF43911F),
                                               // Green color
                                               borderRadius:
                                               BorderRadius.circular(
                                                   50), // Circular button
                                             ),
                                             alignment: Alignment.center,
                                             child: Text(
                                               'Start',
                                               style: TextStyle(
                                                 fontWeight:
                                                 FontWeight.w400,
                                                 fontSize: 20,
                                                 color: Colors
                                                     .white, // Text color
                                               ),
                                             ),
                                           ),
                                         ),
                                       ],
                                     )
                                   ],
                                 ),
                               ),
                             ),
                           ],
                         ),
                       )
                           : Container(),
                     ],),
                   ),

                        //  Stack containing the two containers
                        Expanded(
                          child: Stack(
                            children: [
                              // First and Second Containers in Column
                              logic.selectedBranch.value == true
                                  ? Container()
                                  : logic.start.value == true
                                      ? Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          // Full width of the screen
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2,
                                          // Half the screen height
                                          margin: EdgeInsets.all(16),
                                          // Margin from all sides
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            // White color for the outer container
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            // Rounded corners for the outer container
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                // Shadow color with opacity
                                                spreadRadius: 2,
                                                // Spread of the shadow
                                                blurRadius: 10,
                                                // Blur radius for shadow effect
                                                offset: Offset(0,
                                                    4), // Position of the shadow
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            // Centers column vertically
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            // Centers column horizontally
                                            children: [
                                              // Text widget inside Column
                                              Text(
                                                'To continue, Recognize your face \n by scanning your face',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: Color(
                                                      0xFF507799), // Custom color
                                                ),
                                                textAlign: TextAlign
                                                    .center, // Center align the text
                                              ),
                                              SizedBox(height: 16),
                                              // Add space between text and image container
                                              // Image Container inside Center widget
                                              Container(
                                                width: 200,
                                                height: 200,
                                                margin: EdgeInsets.all(16),
                                                // Margin inside the white container
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  // Grey background color for the inner container
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          40), // Rounded corners for the inner container
                                                  // No shadow for the inner container
                                                ),
                                                child: Center(
                                                  child: Image.asset(
                                                    'assets/images/fullScreen.png',
                                                    // Your image asset
                                                    fit: BoxFit.cover,
                                                    // Scaling of the image
                                                    height: 100,
                                                    width:
                                                        100, // Adjust image size as needed
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  Get.to(() =>
                                                      SelectServiceView());
                                                  // logic.goToSelectService();
                                                },
                                                child: Container(
                                                  height: 50,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      color: Colors.blue[200]),
                                                  child: Center(
                                                      child: Text('Continue')),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Positioned.fill(
                                          child: Column(
                                            children: [
                                              // First Container
                                              Expanded(
                                                child: Container(
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(30),
                                                        topRight:
                                                            Radius.circular(30),
                                                      ),
                                                    ),
                                                    child: logic
                                                            .branchesSelected
                                                            .value
                                                        ? Column(
                                                            children: [
                                                              logic.branchesSelected
                                                                      .value
                                                                  ? buildListOfBranches(
                                                                      logic)
                                                                  : buildBranchesAndReportsViews(
                                                                      logic),
                                                            ],
                                                          )
                                                        : logic.reports.value
                                                            ? Column(
                                                                children: [
                                                                  buildReportsViews(
                                                                      logic,
                                                                      context)
                                                                ],
                                                              )
                                                            : logic.account
                                                                    .value
                                                                ? Column(
                                                                    children: [
                                                                      buildAccountViews(
                                                                          logic,
                                                                          context)
                                                                    ],
                                                                  )
                                                                : logic.bellSelected
                                                                        .value
                                                                    ? Column(
                                                                        children: [
                                                                          buildNotifications(
                                                                              logic,
                                                                              context)
                                                                        ],
                                                                      )
                                                                    : SingleChildScrollView(
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            logic.branchesSelected.value
                                                                                ? buildListOfBranches(logic)
                                                                                : buildBranchesAndReportsViews(logic)
                                                                          ],
                                                                        ),
                                                                      )),
                                              ),

                                              // Second Container
                                              Container(
                                                height: 60,
                                                // Fixed height for the second container
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF1F5077),
                                                ),
                                                // child: Center(
                                                //   child: Text(
                                                //     'Second Container Content',
                                                //     style: const TextStyle(
                                                //       fontSize: 18,
                                                //       color: Colors.black,
                                                //     ),
                                                //   ),
                                                // ),
                                              ),
                                            ],
                                          ),
                                        ),

                              //     Third Container with half in first and half in second

                              logic.selectService.value == true
                                  ? Container()
                                  : Positioned(
                                      bottom: 5,
                                      left: 20,
                                      // Horizontal margin (adjust as needed)
                                      right: 20,
                                      // Horizontal margin (adjust as needed)
                                      // top: MediaQuery.of(context).size.height * 0.25 - 50, // Adjust for first container's height
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 70,
                                            // Fixed height for the third container
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFD1E6FB),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(100)),
                                            ),
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 30,
                                                  right: 30,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      logic.makeHome();
                                                    },
                                                    child: Container(
                                                      child: logic.home.value ==
                                                              true
                                                          ? Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                    'assets/images/highlightingPolygon.png'),
                                                                Container(
                                                                    margin:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/images/home.png')),
                                                              ],
                                                            )
                                                          : Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Image.asset(
                                                                  'assets/images/home.png')),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  InkWell(
                                                    onTap: () {
                                                      logic.makeReports();
                                                    },
                                                    child: Container(
                                                      child: logic.reports
                                                                  .value ==
                                                              true
                                                          ? Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                    'assets/images/highlightingPolygon.png'),
                                                                Container(
                                                                    margin:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/images/reports.png')),
                                                              ],
                                                            )
                                                          : Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Image.asset(
                                                                  'assets/images/reports.png')),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  InkWell(
                                                    onTap: () {
                                                      logic.makeAccount();
                                                    },
                                                    child: Container(
                                                      child: logic.account
                                                                  .value ==
                                                              true
                                                          ? Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Image.asset(
                                                                    'assets/images/highlightingPolygon.png'),
                                                                Container(
                                                                    margin:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            10),
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/images/profile.png')),
                                                              ],
                                                            )
                                                          : Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Image.asset(
                                                                  'assets/images/profile.png')),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: 30, right: 30),
                                              height: 30,
                                              // color: Colors.black,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Home',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Alexandria',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    'Reports',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Alexandria',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    'Account',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            'Alexandria',
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                              logic.selectedBranch.value || logic.start.value
                                  ? Positioned(
                                      bottom: 0,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 60,
                                        // Fixed height for the second container
                                        decoration: BoxDecoration(
                                          color: Color(0xFF1F5077),
                                        ),

                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    logic.branchesSelected.value == true ||
                            logic.bellSelected.value == true
                        ? Positioned(
                            top: 170,
                            left: 20,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // Background color for shadow contrast
                                shape: BoxShape.circle,
                                // Ensures circular shadow
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    // Shadow color
                                    spreadRadius: 1,
                                    // Spread radius
                                    blurRadius: 5,
                                    // Blur radius
                                    offset:
                                        Offset(0, 2), // Position of the shadow
                                  ),
                                ],
                              ),
                              child: InkWell(
                                onTap: () {
                                  logic.backToAllView();
                                },
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/whiteEllipse.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                    Image.asset(
                                      'assets/images/arrowBack.png',
                                      height: 20,
                                      width: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                        : Container(),
                    Positioned(
                      bottom: 5,
                      left: 20,
                      // Horizontal margin (adjust as needed)
                      right: 20,
                      // Horizontal margin (adjust as needed)
                      // top: MediaQuery.of(context).size.height * 0.25 - 50, // Adjust for first container's height
                      child: Column(
                        children: [
                          Container(
                            height: 70,
                            // Fixed height for the third container
                            decoration: BoxDecoration(
                              color: const Color(0xFFD1E6FB),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(100)),
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 30, right: 30, top: 10, bottom: 10),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      logic.makeHome();
                                    },
                                    child: Container(
                                      child: logic.home.value == true
                                          ? Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                    'assets/images/highlightingPolygon.png'),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Image.asset(
                                                        'assets/images/home.png')),
                                              ],
                                            )
                                          : Container(
                                              margin: const EdgeInsets.all(10),
                                              child: Image.asset(
                                                  'assets/images/home.png')),
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      logic.makeReports();
                                    },
                                    child: Container(
                                      child: logic.reports.value == true
                                          ? Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                    'assets/images/highlightingPolygon.png'),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Image.asset(
                                                        'assets/images/reports.png')),
                                              ],
                                            )
                                          : Container(
                                              margin: const EdgeInsets.all(10),
                                              child: Image.asset(
                                                  'assets/images/reports.png')),
                                    ),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      logic.makeAccount();
                                    },
                                    child: Container(
                                      child: logic.account.value == true
                                          ? Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Image.asset(
                                                    'assets/images/highlightingPolygon.png'),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Image.asset(
                                                        'assets/images/profile.png')),
                                              ],
                                            )
                                          : Container(
                                              margin: const EdgeInsets.all(10),
                                              child: Image.asset(
                                                  'assets/images/profile.png')),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 30, right: 30),
                              height: 30,
                              // color: Colors.black,
                              child: Row(
                                children: [
                                  Text(
                                    'Home',
                                    style: TextStyle(
                                        fontFamily: 'Alexandria',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Reports',
                                    style: TextStyle(
                                        fontFamily: 'Alexandria',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  Spacer(),
                                  Text(
                                    'Account',
                                    style: TextStyle(
                                        fontFamily: 'Alexandria',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget buildListOfBranches(BottomBarHostController logic) {
    final ScrollController _scrollController = ScrollController();

    void _scrollToEnd() {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 1),
          curve: Curves.easeOut,
        );
      }
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 40, left: 20),
            height: 40,
            width: 200,
            decoration: BoxDecoration(
              color: Color(0xFFE5EFF9),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'Select a city',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                      color: Color(0xFF507799),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset(
                    'assets/images/dropDown.png',
                    height: 20,
                    width: 20,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              children: [
                Text(
                  'All Branches',
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    color: const Color(0xFF1F5077),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Attach the ScrollController
              scrollDirection: Axis.vertical,
              itemCount: 5,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    logic.goToSelectedBranch();
                    _scrollToEnd(); // Scroll to the last item
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double availableHeight = constraints.maxHeight;
                        double imageHeight = availableHeight * 0.6;
                        return Column(
                          children: [
                            SizedBox(
                              height: imageHeight,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      'assets/images/dummyFood.png',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                    ),
                                    Image.asset(
                                      'assets/images/meshraqTitleImage.png',
                                      fit: BoxFit.contain,
                                      width: double.infinity,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      'Al-Ulaya, Riyadh',
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontFamily: 'Alexandria',
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1F5077),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: Image.asset(
                                      'assets/images/indication.png',
                                      height: 40,
                                      width: 40,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSelectServiceView(BottomBarHostController logic) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   margin: EdgeInsets.only(top: 40, left: 20),
          //   height: 40,
          //   width: 200,
          //   decoration: BoxDecoration(
          //     color: Color(0xFFE5EFF9),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.5),
          //         spreadRadius: 1,
          //         blurRadius: 5,
          //         offset: Offset(0, 3), // Shadow position
          //       ),
          //     ],
          //     borderRadius:
          //     BorderRadius.circular(20), // Optional for rounded corners
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       // Text Section
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 10),
          //         child: Text(
          //           'Select a city',
          //           style: TextStyle(
          //             fontWeight: FontWeight.w400,
          //             fontSize: 20,
          //             color: Color(0xFF507799),
          //           ),
          //         ),
          //       ),
          //       // Spacer
          //       Spacer(),
          //       // Dropdown Icon Section
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 10),
          //         child: Image.asset(
          //           'assets/images/dropDown.png',
          //           height: 20, // Adjust the size of the icon
          //           width: 20,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Container(
          //   margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          //   child: Row(
          //     children: [
          //       Text(
          //         'All Branches',
          //         style: TextStyle(
          //           fontFamily: 'Alexandria',
          //           fontWeight: FontWeight.w600,
          //           fontSize: 22,
          //           color: const Color(0xFF1F5077),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // Expanded(
          //   child: ListView.builder(
          //     scrollDirection: Axis.vertical,
          //     itemCount: 5,
          //     itemBuilder: (context, index) {
          //       return InkWell(
          //         onTap: () {
          //           logic.goToSelectedBranch();
          //         },
          //         child: Container(
          //           margin:
          //           const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          //           height: 200, // Set height for the entire item
          //           decoration: BoxDecoration(
          //             borderRadius: BorderRadius.circular(10),
          //             color: Colors.grey[200],
          //           ),
          //           child: LayoutBuilder(
          //             builder: (context, constraints) {
          //               double availableHeight =
          //                   constraints.maxHeight; // Get parent height
          //               double imageHeight = availableHeight *
          //                   0.6; // Allocate 60% height for the image
          //               return Column(
          //                 children: [
          //                   SizedBox(
          //                     height: imageHeight,
          //                     // Dynamically set image height
          //                     child: ClipRRect(
          //                       borderRadius: BorderRadius.circular(30),
          //                       child: Stack(
          //                         children: [
          //                           Image.asset(
          //                             'assets/images/dummyFood.png',
          //                             fit: BoxFit.cover,
          //                             width: double.infinity,
          //                           ),
          //                           Image.asset(
          //                             'assets/images/meshraqTitleImage.png',
          //                             fit: BoxFit.contain,
          //                             width: double.infinity,
          //                           ),
          //                         ],
          //                       ),
          //                     ),
          //                   ),
          //                   Expanded(
          //                     // Remaining space for text and icon
          //                     child: Row(
          //                       mainAxisAlignment:
          //                       MainAxisAlignment.spaceBetween,
          //                       children: [
          //                         // Left Section (Text)
          //                         Padding(
          //                           padding: const EdgeInsets.symmetric(
          //                               horizontal: 10),
          //                           child: Text(
          //                             'Al-Ulaya, Riyadh',
          //                             style: const TextStyle(
          //                               fontSize: 22,
          //                               fontFamily: 'Alexandria',
          //                               fontWeight: FontWeight.w600,
          //                               color: Color(0xFF1F5077),
          //                             ),
          //                           ),
          //                         ),
          //                         // Right Section (Small Image/Icon)
          //                         Padding(
          //                           padding: const EdgeInsets.symmetric(
          //                               horizontal: 10),
          //                           child: Image.asset(
          //                             'assets/images/indication.png',
          //                             height: 40,
          //                             width: 40,
          //                           ),
          //                         ),
          //                       ],
          //                     ),
          //                   ),
          //                 ],
          //               );
          //             },
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget buildNotifications(
      BottomBarHostController logic, BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Row(
                children: [
                  Text(
                    'Notifications',
                    style: TextStyle(
                      fontFamily: 'Alexandria',
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: const Color(0xFF1F5077),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Number of items in the list
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                '11:42 PM',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: Colors.grey[400]),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 5,
                                spreadRadius: 2,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // Center the Row content
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/images/ellipseForA.png',
                                      width: 40,
                                      // Adjusted width for better appearance
                                      height: 40,
                                      // Adjusted height for better appearance
                                      fit: BoxFit
                                          .cover, // Ensures the image fits nicely
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'assets/images/profileFor.png',
                                        width: 20,
                                        // Adjusted width for better appearance
                                        height:
                                            20, // Adjusted height for better appearance
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 15),
                              // Space between the Stack and Text
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  // Center the text vertically
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'New update available',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        color: Color(0xFF2E76B0),
                                        fontFamily: 'Alexandria',
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
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildBranchesAndReportsViews(BottomBarHostController logic) {
    return Column(
      children: [
        // Title and "Show All" Row
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            children: [
              Text(
                'Branches',
                style: TextStyle(
                  fontFamily: 'Alexandria',
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: const Color(0xFF1F5077),
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  logic.selectBranches();
                },
                child: Row(
                  children: [
                    Text(
                      'Show all',
                      style: TextStyle(
                        fontFamily: 'Alexandria',
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: const Color(0xFF1F5077),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Image.asset(
                      'assets/images/rightOption.png',
                      height: 15,
                      width: 15,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        // First ListView.builder (Branch List)
        Container(
          child: SizedBox(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  height: 150,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 200,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/dummyFood.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Image.asset(
                                'assets/images/meshraqTitleImage.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Row for name and small image
                      Container(
                        margin: EdgeInsets.all(10),
                        child: SizedBox(
                          height: 30,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Al-Ulaya, Riyadh',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Alexandria',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1F5077),
                                ),
                              ),
                              Image.asset('assets/images/indication.png'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        // Indicator Row Below the ListView.builder
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (indicatorIndex) => Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: indicatorIndex == 0
                    ? Colors.blue
                    : Colors.grey, // Active indicator is blue
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // Title and "Show All" Row
        Container(
          // color: Colors.black,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Row(
            children: [
              Text(
                'Previous Reports ',
                style: TextStyle(
                  fontFamily: 'Alexandria',
                  fontWeight: FontWeight.w600,
                  fontSize: 22,
                  color: const Color(0xFF1F5077),
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    'Show all',
                    style: TextStyle(
                      fontFamily: 'Alexandria',
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: const Color(0xFF1F5077),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Image.asset(
                    'assets/images/rightOption.png',
                    height: 15,
                    width: 15,
                  )
                ],
              ),
            ],
          ),
        ),

        // Second ListView.builder (same as your existing code)
        Container(
          // color: Colors.black,
          margin: EdgeInsets.only(bottom: 20),
          child: SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.6,
                  // Adjust width to prevent overflow
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.grey[200],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Increase the space for the image
                      SizedBox(
                        height: 200,
                        // Increased height for the image
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/dummyFood.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                              Image.asset(
                                'assets/images/meshraqTitleImage.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Row for name and small image with reduced margin
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        // Reduced margins
                        child: Column(
                          children: [
                            Text(
                              'Sultana, Medinah',
                              style: const TextStyle(
                                fontSize: 16,
                                fontFamily: 'Alexandria',
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF1F5077),
                              ),
                            ),
                            Text(
                              'Wed, 12/05/2021',
                              style: const TextStyle(
                                fontSize: 14,
                                // Slightly smaller font size for date
                                fontFamily: 'Alexandria',
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1F507799),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget buildReportsViews(
      BottomBarHostController logic, BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 40, left: 20, bottom: 20),
                height: 40,
                width: 200,
                decoration: BoxDecoration(
                  color: Color(0xFFE5EFF9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3), // Shadow position
                    ),
                  ],
                  borderRadius:
                      BorderRadius.circular(20), // Optional for rounded corners
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Select a city',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Color(0xFF507799),
                        ),
                      ),
                    ),
                    // Spacer
                    Spacer(),
                    // Dropdown Icon Section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Image.asset(
                        'assets/images/dropDown.png',
                        height: 20, // Adjust the size of the icon
                        width: 20,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              ExpandableWidget(
                reportImage: 'assets/images/report.png',
                title: 'Sari Street, Jeddah',
                plusIconAsset: 'assets/images/plus.png',
                minusIconAsset: 'assets/images/minus.png',
              ),
              SizedBox(
                height: 10,
              ),
              ExpandableWidget(
                reportImage: 'assets/images/report.png',
                title: 'Sari Street, Jeddah',
                plusIconAsset: 'assets/images/plus.png',
                minusIconAsset: 'assets/images/minus.png',
              ),
              SizedBox(
                height: 10,
              ),
              ExpandableWidget(
                reportImage: 'assets/images/report.png',
                title: 'Sari Street, Jeddah',
                plusIconAsset: 'assets/images/plus.png',
                minusIconAsset: 'assets/images/minus.png',
              ),
              SizedBox(
                height:
                    50, // Extra padding at the bottom to allow scrolling beyond the last item
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAccountViews(
      BottomBarHostController logic, BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          controller: _scrollController, // Add the ScrollController
          physics: BouncingScrollPhysics(), // Smooth scrolling physics
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info Section
              Container(
                margin: EdgeInsets.only(left: 20, top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset(
                          'assets/images/GRContainer.png',
                          height: 80,
                          width: 80,
                        ),
                        Image.asset(
                          'assets/images/GRTitle.png',
                          height: 30,
                          width: 30,
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Grgir Person',
                          style: TextStyle(
                            fontFamily: 'Alexandria',
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: Color(0xFF2E76B0),
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '+966123456789',
                          style: TextStyle(
                            fontFamily: 'Alexandria',
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: Color(0xFF19B2E7),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Expandable Widgets
              ExpandableWidgetA(),
              ExpandableWidgetB(),
              // Logout Button
              Container(
                height: 35,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logout.png',
                      height: 20,
                      width: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Logout',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                        color: Color(0xFF1F5077),
                        fontFamily: 'Alexandria',
                      ),
                    ),
                  ],
                ),
              ),
              // Delete Account Section
              InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        contentPadding: EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/meshraqTitleBlueImage.png',
                              width: 150,
                              height: 150,
                            ),
                            SizedBox(height: 20),
                            Text(
                              'Are you sure \n you want to delete your account?',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Alexandria',
                                fontSize: 24,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF1F5077),
                              ),
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          Center(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: Container(
                                    width: 200,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Color(0xFF1F5077),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'No',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: Container(
                                    width: 200,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Yes, Delete My Account',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  height: 35,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/delete.png',
                        height: 20,
                        width: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Delete Account',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          color: Colors.red,
                          fontFamily: 'Alexandria',
                        ),
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
  }
}

class ExpandableWidget extends StatefulWidget {
  final String title;
  final String plusIconAsset;
  final String minusIconAsset;
  final String reportImage; // New parameter for report image

  const ExpandableWidget({
    Key? key,
    required this.title,
    required this.plusIconAsset,
    required this.minusIconAsset,
    required this.reportImage, // Pass the report image asset
  }) : super(key: key);

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: _toggleExpand,
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1F5077),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color(0xFFD6E7F5),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 3,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ellipseFor.png',
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        _isExpanded
                            ? widget.minusIconAsset
                            : widget.plusIconAsset,
                        width: 12,
                        height: 12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isExpanded) ...[
            SizedBox(height: 10),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: Offset(0, 3), // Shadow position
                      ),
                    ],
                    border: Border.all(color: Color(0xFF9CB3C5)), // Grey border
                    borderRadius:
                        BorderRadius.circular(20), // Circular border radius
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    // Apply circular clipping
                    child: Image.asset(
                      widget.reportImage, // Use the new report image here
                      width: 70,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Round Date:',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Color(0xFF0A8BBF),
                        fontFamily: 'Alexandria',
                      ),
                    ),
                    Text(
                      '09 / 08 / 2025',
                      style: TextStyle(
                          color: Color(0xFF82D7F7),
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      height: 45,
                      width: 200,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                      decoration: BoxDecoration(
                        color: Color(0xFF1F5077),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          'Open Report',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Alexandria',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class ExpandableWidgetA extends StatefulWidget {
  // New parameter for report image

  const ExpandableWidgetA({
    Key? key,
    // Pass the report image asset
  }) : super(key: key);

  @override
  _ExpandableWidgetAState createState() => _ExpandableWidgetAState();
}

class _ExpandableWidgetAState extends State<ExpandableWidgetA> {
  bool _isExpanded = false;

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: _toggleExpand,
            child: Row(
              children: [
                Text(
                  'Information',
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1F5077),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color(0xFFD6E7F5),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 3,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ellipseFor.png',
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        _isExpanded
                            ? 'assets/images/dropDown.png'
                            : 'assets/images/dropDown.png',
                        width: 12,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isExpanded) ...[
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F7FC),
                      // Light color for the first container
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/profile.png',
                            // Replace with your image
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Your Name', // Replace with your text
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF1F5077),
                    // Darker color for the second container
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/images/tick.png'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F7FC),
                      // Light color for the first container
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/phone.png',
                            // Replace with your image
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Phone Number', // Replace with your text
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF1F5077),
                    // Darker color for the second container
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/images/tick.png'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F7FC),
                      // Light color for the first container
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/mail.png',
                            // Replace with your image
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Email', // Replace with your text
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF1F5077),
                    // Darker color for the second container
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/images/tick.png'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F7FC),
                      // Light color for the first container
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/lock.png',
                            // Replace with your image
                            width: 30,
                            height: 30,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Password', // Replace with your text
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF1F5077),
                    // Darker color for the second container
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/images/tick.png'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F7FC),
                      // Light color for the first container
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/function.png',
                            // Replace with your image
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Function', // Replace with your text
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF1F5077),
                    // Darker color for the second container
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/images/tick.png'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F7FC),
                      // Light color for the first container
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/function.png',
                            // Replace with your image
                            width: 30,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Set Up Face ID', // Replace with your text
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFF1F5077),
                    // Darker color for the second container
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset('assets/images/tick.png'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ],
      ),
    );
  }
}

class ExpandableWidgetB extends StatefulWidget {
  // New parameter for report image

  const ExpandableWidgetB({
    Key? key,
    // Pass the report image asset
  }) : super(key: key);

  @override
  _ExpandableWidgetBState createState() => _ExpandableWidgetBState();
}

class _ExpandableWidgetBState extends State<ExpandableWidgetB> {
  bool _isExpanded = false;
  bool _isEnabled = false; // Default state is off

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: _toggleExpand,
            child: Row(
              children: [
                Text(
                  'Settings',
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF1F5077),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Color(0xFFD6E7F5),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 3,
                        blurRadius: 6,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ellipseFor.png',
                        width: 25,
                        height: 25,
                        fit: BoxFit.cover,
                      ),
                      Image.asset(
                        _isExpanded
                            ? 'assets/images/dropDown.png'
                            : 'assets/images/dropDown.png',
                        width: 12,
                        height: 12,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_isExpanded) ...[
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xFFF3F7FC),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 20),
                        // Adding margin inside the container
                        Image.asset(
                          'assets/images/language.png',
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Language', // Replace with your text
                          style: TextStyle(
                            fontFamily: 'Alexandria',
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF1F5077),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Arabic Option
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Color(0xFFD6E7F5),
                    borderRadius: BorderRadius.only(
                        // topRight: Radius.circular(10),
                        // bottomRight: Radius.circular(10),
                        ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/EN.png',
                      color: Color(0xFF1F5077),
                    ), // Arabic image
                  ),
                ),
                SizedBox(width: 0),
                // Remove space between Arabic and English option
                // English Option moved to the end
                Container(
                  height: 40,
                  width: 40, // Set width for the language option container
                  decoration: BoxDecoration(
                    color: Color(0xFF1F5077),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  // child: Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Image.asset(
                  //       'assets/images/العربية.png'), // English image
                  // ),
                  child:Text('Ar'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Image inside the row
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/images/notification.png',
                        // Replace with your image path
                        width: 30,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Text label for the toggle button
                    Text(
                      'Enable Feature', // Label for the toggle button
                      style: TextStyle(
                        fontFamily: 'Alexandria',
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF1F5077), // Color of the text
                      ),
                    ),
                    // Spacer to add space between text and toggle button
                    Spacer(),
                    // Toggle button (Switch)
                    Switch(
                      value: _isEnabled,
                      // The current state of the toggle (true or false)
                      onChanged: (bool value) {
                        setState(() {
                          _isEnabled =
                              value; // Update the state when the toggle is switched
                        });
                      },
                      activeColor: Color(0xFF1F5077), // Color when switch is on
                      inactiveThumbColor:
                          Colors.grey, // Color when switch is off
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
