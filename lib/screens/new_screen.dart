import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants.dart';

import '../providers/data_provider.dart';
import '../widgets/custom_no_task.dart';
import '../widgets/task_widget.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<DataProvider>(context, listen: false).fetchTasks(newStatus),
      builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
          ? const Center(child: CircularProgressIndicator())
          : Consumer<DataProvider>(
              child: const CustomNoTask(),
              builder: (context, dataProvider, ch) => dataProvider.getItems.isEmpty
                  ? ch!
                  : ListView.builder(
                      itemCount: dataProvider.getItems.length,
                      itemBuilder: (context, index) => TaskWidget(task: dataProvider.getItems[index]),
                    ),
            ),
    );
  }
}
