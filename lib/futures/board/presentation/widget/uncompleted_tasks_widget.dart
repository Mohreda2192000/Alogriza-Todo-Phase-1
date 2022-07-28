import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/const/funcations.dart';
import '../../../../core/cubits/cubit_todo/cubit.dart';
import '../../../../core/cubits/cubit_todo/states.dart';
import 'empty_widget.dart';
import 'item_builder_board.dart';

class UncompletedTasksWidget extends StatelessWidget {
  const UncompletedTasksWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = TodoCubit.get(context).uncompletedTasks;
        return tasks.isNotEmpty?ListView.builder(
          itemBuilder: (context, index) {
            return ItemBuilderBoard(
              task: tasks[index], isFavoriteScreen: false,

            );
          },
          itemCount: tasks.length,
        ):const EmptyWidget(string:'Can\'t find Uncompleted tasks' ,);
      },
    );  }
}
