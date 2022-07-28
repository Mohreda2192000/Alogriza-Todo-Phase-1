import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton extends StatelessWidget {
  final String text;
  final double width;
  final Color buttonColor;
  final VoidCallback callback;
  final Color fontColor;
  final double fontSize;
  final double radius;

  const MyButton({
    Key? key,
    required this.text,
    this.width = double.infinity,
    this.buttonColor = Colors.blue,
    required this.callback,
    this.fontColor = Colors.white,
    this.fontSize = 17,
    this.radius = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(
          radius,
        ),
      ),
      child: MaterialButton(
        focusElevation: 0,
        onPressed: () {
          callback();
        },
        child: Text(
          text,
          style: TextStyle(
            color: fontColor,
            fontSize: fontSize.sp,
          ),
        ),
      ),
    );
  }
}
