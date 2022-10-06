import 'package:flutter/material.dart';
import 'package:todo_app/constants.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/data_provider.dart';

class TaskWidget extends StatelessWidget {
  final Task task;

  const TaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return Dismissible(
      key: ValueKey(task.id.toString()),
      background: Container(
        alignment: Alignment.centerRight,
        color: Colors.red,
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        child: const Icon(Icons.delete_rounded, size: 30, color: Colors.white,),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        dataProvider.deleteTask(task.id);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Container(
              width: 62,
              height: 62,
              decoration: BoxDecoration(
                color: Colors.lime,
                borderRadius: BorderRadius.circular(35),
              ),
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text(
                    task.time,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Cairo',
                        fontSize: 18),
                  ),
                  Text(
                    task.date,
                    style: const TextStyle(color: Colors.grey, fontFamily: 'Cairo'),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20,),
            IconButton(onPressed: () async{
              await dataProvider.updateTasks('done', task.id);
            }, icon: const Icon(Icons.check_box_rounded, color: Colors.lime, size: 19,)),
            IconButton(onPressed: () async{
              await dataProvider.updateTasks('archived', task.id);
            }, icon: Icon(Icons.archive_rounded, color: primaryColor.withOpacity(0.7), size: 20,)),
          ],
        ),
      ),
    );
  }
}
