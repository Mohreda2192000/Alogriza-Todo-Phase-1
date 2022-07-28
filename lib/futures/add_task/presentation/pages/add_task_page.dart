import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/add_task_widget.dart';


class AddTaskPage extends StatelessWidget {
  final bool inUpdate;

  const AddTaskPage({Key? key, required this.inUpdate,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddTaskWidget(inUpdate: inUpdate,),
    );
  }
}
