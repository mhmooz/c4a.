import 'package:c4a/shared/components/components.dart';
import 'package:c4a/shared/cubit/cubit.dart';
import 'package:c4a/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasksScreen extends StatelessWidget {
  const NewTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks = AppCubit.get(context).tasks;
        return ListView.separated(
            itemBuilder: (context, index) => buildTaskItem(tasks[index]),
            separatorBuilder: (context, index) => seperatorLine(),
            itemCount: tasks.length);
      },
    );
    //ListView.separated(itemBuilder: (context, index) => buildTaskItem(tasks[index]), separatorBuilder: (context, index) => seperatorLine(), itemCount: tasks.length);
  }
}
