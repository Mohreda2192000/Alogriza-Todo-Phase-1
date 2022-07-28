import 'package:flutter/material.dart';

import '../widget/board_widget.dart';

class BoardPage extends StatelessWidget {
  const BoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BoardWidget(),
    );
  }
}
