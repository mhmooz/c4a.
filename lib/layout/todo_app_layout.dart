import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../shared/cubit/cubit.dart';
import '../shared/components/components.dart';
import '../shared/cubit/states.dart';

// ignore: must_be_immutable
class ToDoApp extends StatelessWidget {
  ToDoApp({super.key});

  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  final titleController = TextEditingController();
  final timeController = TextEditingController();
  final dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AppCubit()..createDataBase(),
        child: BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {
            if (state is InsertDataBaseState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            AppCubit cubit = AppCubit.get(context);
            return SafeArea(
              child: Scaffold(
                key: scaffoldKey,
                appBar: AppBar(
                  title: Text(cubit.titles[cubit.currentIndex]),
                  centerTitle: true,
                  backgroundColor: Colors.black,
                ),
                body: cubit.screens[cubit.currentIndex],
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.black,
                  onPressed: () {
                    if (cubit.isBottomSheetShown) {
                      if (formKey.currentState!.validate()) {
                        cubit.insertDataBase(
                            title: titleController.text,
                            time: timeController.text,
                            date: dateController.text);
                      }
                    } else {
                      scaffoldKey.currentState!
                          .showBottomSheet((context) => Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    defaultFormField(
                                        controller: titleController,
                                        hintText: "Title",
                                        keyboardType: TextInputType.text,
                                        prefix: Icon(Icons.title),
                                        validat: (value) {
                                          if (value!.isEmpty) {
                                            return "title must not be empty";
                                          }
                                          return null;
                                        }),
                                    defaultFormField(
                                      controller: timeController,
                                      hintText: 'Task Time',
                                      keyboardType: TextInputType.datetime,
                                      prefix: Icon(Icons.watch_later_outlined),
                                      validat: (value) {
                                        if (value!.isEmpty) {
                                          return "time must not be empty";
                                        }
                                        return null;
                                      },
                                      onTap: () => showTimePicker(
                                              context: context,
                                              initialTime: TimeOfDay.now())
                                          .then((value) => timeController.text =
                                              value!
                                                  .format(context)
                                                  .toString()),
                                    ),
                                    defaultFormField(
                                        controller: dateController,
                                        hintText: "task Date",
                                        keyboardType: TextInputType.datetime,
                                        prefix: Icon(Icons.calendar_month),
                                        validat: (value) {
                                          if (value!.isEmpty) {
                                            return "date must not be empty";
                                          }
                                          return null;
                                        },
                                        onTap: () => showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime.now(),
                                                lastDate: DateTime.parse(
                                                    "2023-08-25"))
                                            .then((value) =>
                                                dateController.text =
                                                    DateFormat.yMMMd()
                                                        .format(value!)))
                                  ],
                                ),
                              ))
                          .closed
                          .then((value) => cubit.changeBottomSheetState(
                              isShow: false, SheetIcon: Icons.edit));
                      cubit.changeBottomSheetState(
                          isShow: true, SheetIcon: Icons.add);
                    }
                  },
                  child: Icon(cubit.fabIcon),
                ),
                bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    backgroundColor: Colors.black,
                    onTap: (index) {
                      cubit.changeIndex(index);
                    },
                    elevation: 50,
                    fixedColor: Colors.white,
                    currentIndex: cubit.currentIndex,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: 30,
                        ),
                        label: "NEW TASKS",
                      ),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.done_outline_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          label: "DONE TASKS"),
                      BottomNavigationBarItem(
                          icon: Icon(
                            Icons.archive_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          label: "ARCHIVED TASKS")
                    ]),
              ),
            );
          },
        ));
  }
}
