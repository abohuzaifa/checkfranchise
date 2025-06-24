import 'package:flutter/material.dart';

class QualityCheckerScreen extends StatefulWidget {
  const QualityCheckerScreen({super.key});

  @override
  State<QualityCheckerScreen> createState() => _QualityCheckerScreenState();
}

class _QualityCheckerScreenState extends State<QualityCheckerScreen> {
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      height: h,
      width: w,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: h*0.5,
              width: w,
              color: Color(0xff1F5077),
            ),
            Column(
              children: [
                Text(
                  'To continue, Recognize your face\nby scanning your face.',
                  style: TextStyle(
                    fontFamily: 'Alexandria',
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                    color: Color(0xff1F5077),
                  ),
                ),
                Container(
                  height: h,
                  width: w,
                  decoration: BoxDecoration(
                      color: Color(0xffF3F7FC),
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
