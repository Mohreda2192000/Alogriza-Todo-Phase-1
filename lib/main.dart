import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/cubits/cubit_todo/bloc_observer.dart';
import 'core/cubits/cubit_todo/cubit.dart';
import 'futures/add_task/presentation/pages/add_task_page.dart';
import 'futures/board/presentation/page/board_page.dart';
import 'futures/schedule/presentation/pages/schedule_page.dart';

void main() {
  BlocOverrides.runZoned(
        () {},
    blocObserver: MyBlocObserver(),
  );
  runApp(const ToDoList());
}

class ToDoList extends StatelessWidget {
  const ToDoList({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoCubit>(create: (context)=>TodoCubit()..createDatabase()),
      ],
      child: ScreenUtilInit(
        builder: (context, child) => const MaterialApp(
          debugShowCheckedModeBanner: false,
          home:  BoardPage(),
        ),
      ),
    );
  }
}
