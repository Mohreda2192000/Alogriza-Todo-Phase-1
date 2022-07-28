import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/const/funcations.dart';

import '../../../../core/cubits/cubit_todo/cubit.dart';
import '../../../../core/cubits/cubit_todo/states.dart';
import '../../../../core/widgets/line.dart';
import 'item_builder_schedule.dart';

class ScheduleWidget extends StatefulWidget {
   ScheduleWidget({Key? key}) : super(key: key);

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {

  @override

  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context,state){},
      builder: (context,state) {
        var cubit=TodoCubit.get(context);
        var tasks=cubit.tasksDay;
        return Container(
          padding: EdgeInsets.only(top: 50.h),
        color: Colors.white,
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
                  const Text('Schedule',
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

            Container(
              width: double.infinity,
              color: Colors.white,
              child:DatePicker(
                DateTime.now(),
                initialSelectedDate: DateTime.now(),
                selectedTextColor: Colors.white,
                selectionColor: Colors.green,
                onDateChange: (dateTime){
                  cubit.tasksOfDay(dateTime);
                  print(dateTime.toString());
                },
              ),
            ),

            const Line(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.h,vertical: 20.w,),
              child: Row(
                children: [
                  Text(cubit.day,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    (
                        DateFormat.yMMMd().format(cubit.date)),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: ListView.builder(
                itemBuilder: (context ,index)=>ItemBuilderSchedule(
                  title: tasks[index]['title'],
                  time: tasks[index]['startTime'],
                  color: choiceColor(tasks[index]['color']),
                  isCompleted: tasks[index]['statue']=='completed',
                ),
                itemCount: tasks.length,
              ),
            ),

          ],
        ),
      );
      },
    );
  }
}
