import 'package:flutter/material.dart';

import '../widgets/schedule_widget.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScheduleWidget(),
    );
  }
}
