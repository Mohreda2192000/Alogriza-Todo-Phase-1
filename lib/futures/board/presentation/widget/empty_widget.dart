import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  final String string;
  const EmptyWidget({Key? key, required this.string}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children:  [
        const Icon(Icons.note_alt_outlined,color: Colors.grey,size: 100,),
        const SizedBox(height: 10,),
        Text(string,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),),
      ],
    );
  }
}
