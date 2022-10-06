import 'package:flutter/widgets.dart';

import '../helpers/db_helper.dart';
import '../models/task.dart';

class DataProvider with ChangeNotifier {
  List<Task> _items = [];

  List<Task> get getItems {
    return [..._items];
  }

  void getTaskById(int id) {
    Task task =  _items.firstWhere((element) => element.id == id);
    print('{${task.id}, ${task.title}, ${task.date}, ${task.time}, ${task.status}}');
  }

  Future<void> addTask({required String title, required String time, required String date}) async {
    int insertedRowId = await DBhelper.insert(title, date, time);
    final Task newTask =
        Task(id: insertedRowId, title: title, time: time, date: date, status: 'new');
    _items.add(newTask);
    notifyListeners();
  }

  Future<void> fetchTasks(String status) async {
    final myTasks = await DBhelper.select(status);
    _items = myTasks
        .map((item) => Task(
            id: item['id'],
            title: item['title'],
            time: item['time'],
            date: item['date'],
            status: item['status']))
        .toList();
    notifyListeners();
  }

  Future<void> updateTasks(String status, int id) async {
    await DBhelper.update(status, id);
    notifyListeners();
  }

  Future<void> deleteTask(int id) async {
    _items.removeWhere((element) => element.id == id);
    await DBhelper.delete(id);
    notifyListeners();
  }
}
