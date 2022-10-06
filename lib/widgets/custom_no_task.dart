import 'package:flutter/material.dart';

class CustomNoTask extends StatelessWidget {
  const CustomNoTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'No Tasks Yet',
        style: TextStyle(letterSpacing: 1.3, fontSize: 25, fontFamily: 'Cairo', color: Colors.grey, fontWeight: FontWeight.w600),
      ),
    );
  }
}
