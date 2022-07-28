import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ItemBuilderSchedule extends StatelessWidget {
  final String title;
  final String time;
  final Color color;
  final bool isCompleted;
   const ItemBuilderSchedule({Key? key,
     required this.title,
     required this.time,
     required this.color,
     required this.isCompleted,
   }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: 20.h,
        left: 20.h,
        top: 15,
      ),
      padding: EdgeInsets.only(top: 15.h,bottom:15.h,left: 20.h,right: 10.h,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.h),
        color: color,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 7.h,),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          const Spacer(),
           Icon(
            (isCompleted==true)?Icons.check_circle_outline:Icons.circle_outlined,
            color: Colors.white,
            size: 25,
          ),
        ],
      ),
    );
  }
}
