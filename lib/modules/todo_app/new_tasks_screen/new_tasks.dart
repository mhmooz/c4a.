import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/components/components.dart';
import '../../../shared/cubit/cubit.dart';
import '../../../shared/cubit/states.dart';

class NewTasks extends StatelessWidget {
  const NewTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        var tasks = cubit.newtasks;

        if (tasks.isEmpty) {
          return Scaffold(
            backgroundColor: Colors.grey[200],
            body: Center(
              child: Text('No tasks found.'),
            ),
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.grey[200],
            body: ListView.separated(
              itemBuilder: (context, index) {
                return buildTaskItem(tasks[index], context);
              },
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 10,
              ),
              itemCount: tasks.length,
            ),
          );
        }
      },
    );
  }
}
