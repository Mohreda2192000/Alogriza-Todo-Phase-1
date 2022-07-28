import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/const/funcations.dart';
import '../../../../core/cubits/cubit_todo/cubit.dart';
import '../../../../core/cubits/cubit_todo/states.dart';

class ItemBuilderBoard extends StatelessWidget {
  final Map task;
  final bool isFavoriteScreen;
  const ItemBuilderBoard({Key? key, required this.task, required this.isFavoriteScreen,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<TodoCubit,TodoStates>(
      listener: (context,state){

      },
      builder: (context,state) {
        TodoCubit cubit = TodoCubit.get(context);
        return Dismissible(
        key:Key('${task['id'].toString()}'),
        child: Container(
          margin: EdgeInsets.only(
            right: 20.h,
            left: 20.h,
          ),
          padding: EdgeInsets.symmetric(vertical: 5.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.h),
            color: Colors.white38,
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  cubit.checkCompletedTask(completed:task['statue']=='completed'?'uncompleted':'completed' ,id: task['id']);
                },
                icon:  Icon(
                  task['statue']=='completed'?Icons.check_box_outlined:Icons.check_box_outline_blank,
                  color: choiceColor(task['color']),
                  size: 30,
                ),
              ),
              SizedBox(
                width: 5.w,
              ),
              Text(
                task['title'],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                ),
              ),
            ],
          ),
        ),
        onDismissed: (direction){
          if(isFavoriteScreen==false) {
            cubit.deleteFromDatabase(id: task['id']);
          }
          else{
            cubit.changeFavoriteTask(favorite: 'unFavorite',id: task['id']);
          }
        },
      );
      },
    );
  }
}
