import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';

import '../screens/archived_screen.dart';
import '../screens/done_screen.dart';
import '../screens/new_screen.dart';
import '../widgets/custom_floating_action_button.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  var currentIndex = 0;
  List<Map<String, dynamic>> screens = [
    {'label': 'Tasks', 'screen': const NewScreen()},
    {'label': 'Done Tasks', 'screen': const DoneScreen()},
    {'label': 'Archived Tasks', 'screen': const ArchivedScreen()},
  ];

  final _isOpened = false;
  final _scaffold = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        backgroundColor: Colors.lime,
        automaticallyImplyLeading: false,
        title: Text(screens[currentIndex]['label'], style: const TextStyle(color: primaryColor, fontFamily: 'Cairo'),),
      ),
      body: screens[currentIndex]['screen'],
      floatingActionButton: CustomFloatingActionButton(scaffold: _scaffold, isOpened: _isOpened),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: primaryColor.withOpacity(0.7),
        unselectedItemColor: primaryColor.withOpacity(0.3),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.done_all), label: 'Done Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.archive_outlined), label: 'Archived Tasks'),
        ],
      ),
    );
  }
}
