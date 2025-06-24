import 'package:flutter/material.dart';
import 'package:franchise_app/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AccountCommonWidget extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String img;
  final String title;
  final double? h;
  final double? w;
  const AccountCommonWidget(
      {super.key, required this.img, required this.title, this.h, this.w, this.textEditingController});


  @override
  State<AccountCommonWidget> createState() => _AccountCommonWidgetState();
}

class _AccountCommonWidgetState extends State<AccountCommonWidget> {

  @override
  Widget build(BuildContext context) {
    // Get the current locale
    Locale? currentLocale = Get.locale;

    // Extract the language code (e.g., 'en', 'es')
    String languageCode = currentLocale?.languageCode ?? 'en';
    print("Language Code: $languageCode");
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.05,
      decoration: BoxDecoration(
        color: Color(0xffF3F7FC),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: w * 0.03,
          ),
          Image.asset(
            "${AppConstants.imgUrl}${widget.img}",
            height: widget.h,
          ),
          SizedBox(
            width: w * 0.02,
          ),
          Expanded(
            child: TextField(
              controller: widget.textEditingController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(bottom: h*0.01),
                hintText:  widget.title,
                border: InputBorder.none,
                hintStyle: TextStyle(  fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Alexandria',
                    color: Color(0xff1D3F5D).withOpacity(0.4))
              ),
            ),
          ),
        /*  Container(
            height: h * 0.05,
            padding: EdgeInsets.only(left: w * 0.04, right: w * 0.04),
            decoration: BoxDecoration(
                color: Color(0xff1D3F5D),
                borderRadius: languageCode=='en'? BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12)): BorderRadius.only(
                    topLeft: Radius.circular(12),
                    bottomLeft: Radius.circular(12))),
            child: Icon(
              Icons.check,
              color: Color(0xffFFFFFF),
            ),
          )*/
        ],
      ),
    );
  }
}
