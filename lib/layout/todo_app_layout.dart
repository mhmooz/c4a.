import 'package:c4a/shared/cubit/cubit.dart';
import 'package:c4a/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import '../modules/todo_app/archived_screen/archived_screen.dart';
import '../modules/todo_app/done_tasks_screen/donr_tasks.dart';
import '../modules/todo_app/new_tasks_screen/new_tasks.dart';
import '../shared/components/components.dart';
import '../shared/components/constants.dart';

// ignore: camel_case_types, must_be_immutable
class TODO_App extends StatelessWidget {
  TODO_App({super.key});

  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  final title_controller = TextEditingController();
  final time_controller = TextEditingController();
  final date_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createDataBase(),
        child: BlocConsumer<AppCubit, AppStates>(
            listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDataBaseState) {
            Navigator.pop(context);
          }
        }, builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);

          return SafeArea(
            child: Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.grey[900],
                centerTitle: true,
                title: Text(cubit.titles[cubit.currentIndex]),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                    if (formKey.currentState!.validate()) {
                      cubit.insertToDataBase(
                          title: title_controller.text,
                          time: time_controller.text,
                          date: date_controller.text);
                      // insertToDataBase(
                      //         title: title_controller.text,
                      //         time: time_controller.text,
                      //         date: date_controller.text)
                      //     .then((value) {
                      //   Navigator.pop(context);
                      //   isBottomSheetShown = false;
                      //   // setState(() {
                      //   //   fabIcon = Icons.edit;
                      //   // });
                      // });
                    }
                  } else {
                    scaffoldKey.currentState!
                        .showBottomSheet((context) => Form(
                              key: formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  defaultFormField(
                                    controller: title_controller,
                                    hintText: 'Task Title',
                                    keyboardType: TextInputType.text,
                                    prefix: Icon(Icons.title),
                                    validat: (value) {
                                      if (value!.isEmpty) {
                                        return "Title Must Not Be Empty";
                                      }
                                      return null;
                                    },
                                  ),
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
                                                context: context,
                                                initialTime: TimeOfDay.now())
                                            .then((value) =>
                                                time_controller.text = value!
                                                    .format(context)
                                                    .toString());
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
                                                lastDate: DateTime.parse(
                                                    "2023-06-25"))
                                            .then((value) =>
                                                date_controller.text =
                                                    DateFormat.yMMMd()
                                                        .format(value!));
                                      },
                                      controller: date_controller,
                                      hintText: 'Task Date',
                                      keyboardType: TextInputType.datetime,
                                      prefix:
                                          Icon(Icons.calendar_month_outlined),
                                      validat: (value) {
                                        if (value!.isEmpty) {
                                          return 'Date Must Not Be Empty';
                                        }
                                        return null;
                                      })
                                ],
                              ),
                            ))
                        .closed
                        .then((value) {
                      cubit.cahngeBottomSheetState(
                          isShow: false, icon: Icons.edit);
                    });
                    cubit.cahngeBottomSheetState(isShow: true, icon: Icons.add);
                  }
                },
                child: Icon(cubit.fabIcon),
                backgroundColor: Colors.grey[900],
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentIndex,
                onTap: (index) {
                  cubit.changeIndex(index);
                },
                backgroundColor: Colors.grey,
                type: BottomNavigationBarType.fixed,
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.menu), label: "NEW TASKS"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.check_box), label: 'DONE TASKS'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.archive_outlined),
                      label: 'ARCHIVED TASKS')
                ],
              ),
              body: state is! AppGetDataBaseLoadingState
                  ? cubit.screens[cubit.currentIndex]
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          );
        }));
  }
}
