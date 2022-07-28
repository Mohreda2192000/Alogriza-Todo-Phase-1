import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(itemBuilder: (context,index) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 10.h,vertical: 20.w),
        padding: EdgeInsets.symmetric(horizontal: 15.h,vertical: 7.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.h),
          color: Colors.grey[100],
        ),
        child: Row(
          children: [
            Icon(Icons.notifications,size: 50,color: Colors.grey[600],),
            const SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Go to gym',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 10,),
                Text('The task in completed',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ],
        ),
      );
    },itemCount: 10,);
  }
}
