import 'package:c4a/layout/the_todo_app.dart';
import 'package:c4a/shared/components/components.dart';
import 'package:c4a/sql.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class TaskInsert extends StatelessWidget {
  TaskInsert({super.key});
  SqlDb sqlDb = SqlDb();
  Future<int> insertData() async {
    int response = await sqlDb.insertData(
        'INSERT INTO tasks(task , time , date , status) VALUES("${title_controller.text}" , "${time_controller.text}" , "${date_controller.text}" , "New")');
    print(response);
    return response;
  }

  var formKey = GlobalKey<FormState>();
  final title_controller = TextEditingController();
  final time_controller = TextEditingController();
  final date_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add A Task"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Form(
            key: formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              defaultFormField(
                  controller: title_controller,
                  hintText: "Task Title",
                  keyboardType: TextInputType.text,
                  prefix: Icon(Icons.title),
                  validat: (value) {
                    if (value!.isEmpty) {
                      return "Title Must Not Be Empty";
                    }
                    return null;
                  }),
              SizedBox(
                height: 5,
              ),
              defaultFormField(
                  controller: time_controller,
                  hintText: 'Task Time',
                  keyboardType: TextInputType.datetime,
                  prefix: Icon(Icons.watch_later),
                  validat: (value) {
                    if (value!.isEmpty) {
                      return 'Time Must Not Be Empty';
                    }
                    return null;
                  },
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) => time_controller.text =
                            value!.format(context).toString());
                  }),
              SizedBox(
                height: 5,
              ),
              defaultFormField(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse("2023-06-25"))
                        .then((value) => date_controller.text =
                            DateFormat.yMMMd().format(value!));
                  },
                  controller: date_controller,
                  hintText: 'Task Date',
                  keyboardType: TextInputType.datetime,
                  prefix: Icon(Icons.calendar_month_outlined),
                  validat: (value) {
                    if (value!.isEmpty) {
                      return 'Date Must Not Be Empty';
                    }
                    return null;
                  }),
              SizedBox(
                height: 10,
              ),
              defaultButton(
                  function: () async {
                    if (formKey.currentState!.validate()) {
                      insertData();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => TheToDoAPP()),
                          (route) => false);
                    }
                  },
                  text: "ADD TASK")
            ])),
      ),
    );
  }
}
