import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/constants.dart';

import '../helpers/db_helper.dart';
import '../providers/data_provider.dart';

class CustomFloatingActionButton extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffold;
  late bool isOpened = false;
  CustomFloatingActionButton({Key? key, required this.scaffold, required this.isOpened}) : super(key: key);

  @override
  State<CustomFloatingActionButton> createState() => _CustomFloatingActionButtonState();
}

class _CustomFloatingActionButtonState extends State<CustomFloatingActionButton> {

  final _form = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    return FloatingActionButton(
      backgroundColor: primaryColor.withOpacity(0.7),
        elevation: 3,
        onPressed: () async{
          if (widget.isOpened) {
            if(_form.currentState == null) return;
            if(_form.currentState!.validate()){
              await dataProvider.addTask(title:_titleController.text, date:_dateController.text, time:_timeController.text);
              _titleController.clear();
              _timeController.clear();
              _dateController.clear();
            }
          } else {
            if (widget.scaffold.currentState == null) return;
            widget.scaffold.currentState!.showBottomSheet(
                  (context) => Container(
                padding: const EdgeInsets.all(20),
                color: Colors.grey[100],
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _titleController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Title is required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Title',
                            suffixIcon: Icon(Icons.title_rounded),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _timeController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Time is required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Time',
                            suffixIcon: Icon(Icons.watch_later_outlined),
                            border: OutlineInputBorder()),
                        readOnly: true,
                        onTap: () {
                          showTimePicker(context: context, initialTime: TimeOfDay.now(), ).then(
                                  (value) => _timeController.text =
                                  value!.format(context));
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _dateController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Date is required';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Date',
                            suffixIcon: Icon(Icons.date_range_rounded),
                            border: OutlineInputBorder()),
                        readOnly: true,
                        onTap: () {
                          showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime.now()).then((value) => _dateController.text = DateFormat.yMMMd().format(value!));
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ).closed.then((value) {
              setState(() {
                widget.isOpened = false;
              });
            });
            setState(() {
              widget.isOpened = true;
            });
          }
        },
        child: Icon(widget.isOpened ? Icons.add : Icons.edit, color: Colors.white, size: 20,));
  }
}
