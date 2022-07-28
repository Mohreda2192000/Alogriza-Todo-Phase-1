import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:totodo/futures/notificatons_board/notification_item.dart';

import '../../core/widgets/line.dart';

class NotificationTasks extends StatelessWidget {
  const NotificationTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top: 50.h),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20.w,right: 20.w,),
              child: Row(
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 5.w,),
                  const Text('Notification',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            const Line(),
             Expanded(flex:2,child: NotificationItem()),
          ],
        ),
      ),
    );
  }
}
