import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:totodo/futures/board/presentation/widget/uncompleted_tasks_widget.dart';

import '../../../../core/cubits/cubit_todo/cubit.dart';
import '../../../../core/cubits/cubit_todo/states.dart';
import '../../../../core/widgets/line.dart';
import '../../../../core/widgets/my_button.dart';
import '../../../add_task/presentation/pages/add_task_page.dart';
import '../../../notificatons_board/notification_tasks.dart';
import '../../../schedule/presentation/pages/schedule_page.dart';
import 'all_tasks_widget.dart';
import 'completed_tasks_widget.dart';
import 'favorite_tasks_widget.dart';
import 'item_builder_board.dart';

// ignore: must_be_immutable
class BoardWidget extends StatelessWidget {
  BoardWidget({Key? key}) : super(key: key);
  List<Widget> screens = [
    const AllTasksWidget(),
    const CompletedTasksWidget(),
    const UncompletedTasksWidget(),
    const FavoriteTasksWidget(),
  ];
Map task={};
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TodoCubit cubit = TodoCubit.get(context);
        return Container(
          color: Colors.white,
          padding: EdgeInsets.only(top: 50.h),
          child: Column(
            children: [
              cubit.isSearching==false?
              Container(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                ),
                color: Colors.white,
                child: Row(
                  children: [
                    const Text(
                      'Board',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        cubit.search(true);
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      color: Colors.grey,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const NotificationTasks()),
                        );
                      },
                      icon:  Stack(
                        alignment: Alignment.topRight,
                        children: [
                          const Icon(
                            Icons.notifications,
                            color: Colors.grey,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 5,
                            child: Text(
                              cubit.allTasks.length.toString(),
                              style: const TextStyle(
                                fontSize: 7,
                                color:  Colors.white ,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SchedulePage()),
                        );
                        cubit.tasksOfDay(DateTime.now());
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ):
              Container(
                margin: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  bottom: 5,
                ),
                padding: EdgeInsets.only(
                  left: 10.w,
                  right: 10.w,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[100],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: TextEditingController(),
                        decoration: InputDecoration(
                          hintText: 'Search .....',
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey,
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0,
                            ),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 0,
                            ),
                          ),
                        ),
                        cursorColor: Colors.black87,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        cubit.search(false);
                      },
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.grey,
                      ),
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              const Line(),
              tabs(context),
              const Line(),
              Expanded(
                flex: 3,
                child: screens[cubit.currentIndex],
              ),
              Padding(
                padding: EdgeInsets.all(20.0.h),
                child: MyButton(
                  text: 'Add a task',
                  callback: () {

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  AddTaskPage(inUpdate:false)),
                    );
                  },
                  buttonColor: Colors.green,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // void showToast() => Fluttertoast.showToast(
  //       msg: 'msg',
  //       fontSize: 20,
  //     );

  DefaultTabController tabs(BuildContext context) {
    TodoCubit cubit = TodoCubit.get(context);
    return DefaultTabController(
      length: 4,
      child: TabBar(
        isScrollable: true,
        labelColor: Colors.red,
        indicatorColor: Colors.black,
        automaticIndicatorColorAdjustment: true,
        tabs: [
          Tab(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'All',
                  style: TextStyle(
                    color: (cubit.currentIndex == 0) ? Colors.black : Colors.grey,
                    fontWeight: (cubit.currentIndex == 0)
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 5,
                  child: Text(
                    cubit.allTasks.length.toString(),
                    style: TextStyle(
                      fontSize: 7,
                      color: (cubit.currentIndex == 0) ? Colors.black : Colors.grey,
                      fontWeight: (cubit.currentIndex == 0)
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'Completed',
                  style: TextStyle(
                    color: (cubit.currentIndex == 1) ? Colors.black : Colors.grey,
                    fontWeight: (cubit.currentIndex == 1)
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 5,
                  child: Text(
                    cubit.completedTasks.length.toString(),
                    style: TextStyle(
                      fontSize: 7,
                      color: (cubit.currentIndex == 1) ? Colors.black : Colors.grey,
                      fontWeight: (cubit.currentIndex == 1)
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'Uncompleted',
                  style: TextStyle(
                    color: (cubit.currentIndex == 2) ? Colors.black : Colors.grey,
                    fontWeight: (cubit.currentIndex == 2)
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 5,
                  child: Text(
                    cubit.uncompletedTasks.length.toString(),
                    style: TextStyle(
                      fontSize: 7,
                      color: (cubit.currentIndex == 2) ? Colors.black : Colors.grey,
                      fontWeight: (cubit.currentIndex == 2)
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  'Favorite',
                  style: TextStyle(
                    color: (cubit.currentIndex == 3) ? Colors.black : Colors.grey,
                    fontWeight: (cubit.currentIndex == 3)
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 5,
                  child: Text(
                    cubit.favoriteTasks.length.toString(),
                    style: TextStyle(
                      fontSize: 7,
                      color: (cubit.currentIndex == 3) ? Colors.black : Colors.grey,
                      fontWeight: (cubit.currentIndex == 3)
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        onTap: (int index) {
          cubit.changeIndex(index);
        },
      ),
    );
  }

}
