import 'package:c4a/modules/simple_counter/cubit/cubit.dart';
import 'package:c4a/modules/simple_counter/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleCounter extends StatelessWidget {
  const SimpleCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              'Simple Counter',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            backgroundColor: Colors.green[300],
          ),
          body: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.grey[300]),
                child: TextButton(
                    onPressed: () {
                  CounterCubit.get(context).minus();
                      },
                    child: Text(
                      "عتنارك",
                      style: TextStyle(color: Colors.red[300], fontSize: 21),
                    )),
              ),
              const SizedBox(
                width: 25,
              ),
              Center(
                child: Text(
                  "${CounterCubit.get(context).counter}",
                  style: const TextStyle(fontSize: 45, fontWeight: FontWeight.w900),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              Container(
                width: 100,
                height: 70,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.grey[300]),
                child: TextButton(
                    onPressed: () {
                  CounterCubit.get(context).plus();
                    },
                    child: const Text(
                      "استغفر الله",
                      style: TextStyle(color: Colors.green, fontSize: 21),
                    )),
              ),
            ],
          ),
        );
      
        },
      ),
    );
  }
}