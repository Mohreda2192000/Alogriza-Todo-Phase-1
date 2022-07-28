import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/add_task_widget.dart';


class AddTaskPage extends StatelessWidget {

  const AddTaskPage({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AddTaskWidget(),
    );
  }
}
