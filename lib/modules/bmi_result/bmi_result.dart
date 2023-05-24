import 'package:flutter/material.dart';

class BMI_RESULT extends StatelessWidget {
  final int result;
  final int age;
  final bool isMale;
  const BMI_RESULT({super.key, 
    required this.result,
    required this.age,
    required this.isMale,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 29, 49),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 6, 29, 49),
        centerTitle: true,
        title: const Text(
          'BMI CALCULATOR',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender : ${isMale ? 'Male' : 'Female'}',
              style: const TextStyle(color: Colors.white, fontSize: 40),
            ),
            Text(
              "Age : $age",
              style: const TextStyle(color: Colors.white, fontSize: 40),
            ),
            Text(
              "BMI COUNT : $result",
              style: const TextStyle(color: Colors.white, fontSize: 40),
            )
          ],
        ),
      ),
    );
  }
}
