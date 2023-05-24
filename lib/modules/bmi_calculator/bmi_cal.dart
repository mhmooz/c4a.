import 'dart:math';

import 'package:c4a/modules/bmi_result/bmi_result.dart';
import 'package:flutter/material.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> { 
  bool isMale = true;

  int age = 25;
  int weight = 60;
  double height = 165;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = true;
                    });
                  },
                  child: Container(
                    width: 160,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: isMale
                          ? const Color.fromARGB(255, 9, 37, 59)
                          : const Color.fromARGB(255, 5, 27, 44),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.male,
                          color: Colors.white,
                          size: 100,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "MALE",
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isMale = false;
                    });
                  },
                  child: Container(
                    width: 160,
                    height: 180,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: isMale
                          ? const Color.fromARGB(255, 5, 27, 44)
                          : const Color.fromARGB(255, 9, 37, 59),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.female,
                          color: Colors.white,
                          size: 100,
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          "FEMALE",
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color.fromARGB(255, 9, 37, 59),
              ),
              alignment: Alignment.topCenter,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'HEIGHT',
                    style: TextStyle(color: Colors.grey[700], fontSize: 20),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '${height.round()}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 50),
                      ),
                      const Text(
                        'cm',
                        style: TextStyle(fontSize: 20, color: Colors.white30),
                      ),
                    ],
                  ),
                  Slider(
                      value: height,
                      max: 220,
                      min: 80,
                      onChanged: (value) {
                        setState(() {
                          height = value;
                        });
                      }),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 160,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromARGB(255, 9, 37, 59),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "WEIGHT",
                        style: TextStyle(color: Colors.grey[700], fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '$weight',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 50),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                weight--;
                              });
                            },
                            heroTag: 'weight.remove',
                            backgroundColor: const Color.fromARGB(255, 20, 51, 75),
                            child: const Icon(
                              Icons.remove,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                weight++;
                              });
                            },
                            heroTag: 'weight.add',
                            backgroundColor: const Color.fromARGB(255, 20, 51, 75),
                            child: const Icon(
                              Icons.add,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 160,
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromARGB(255, 9, 37, 59),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "AGE",
                        style: TextStyle(color: Colors.grey[700], fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '$age',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 50),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                age--;
                              });
                            },
                            heroTag: 'age.remove',
                            backgroundColor: const Color.fromARGB(255, 20, 51, 75),
                            child: const Icon(
                              Icons.remove,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                age++;
                              });
                            },
                            heroTag: 'age.add',
                            backgroundColor: const Color.fromARGB(255, 20, 51, 75),
                            child: const Icon(
                              Icons.add,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.pink[400]),
            child: MaterialButton(
              onPressed: () {
                double result = weight / pow(height / 100, 2);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BMI_RESULT(
                            result: result.round(), age: age, isMale: isMale)));
              },
              child: const Text(
                'CALCULATE',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
