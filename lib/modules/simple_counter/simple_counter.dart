import 'package:flutter/material.dart';

class SimpleCounter extends StatefulWidget {
  const SimpleCounter({super.key});

  @override
  State<SimpleCounter> createState() => _SimpleCounterState();
}

class _SimpleCounterState extends State<SimpleCounter> {
  int counter = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  setState(() {
                    counter--;
                  });
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
              "$counter",
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
                  setState(() {
                    counter++;
                  });
                },
                child: const Text(
                  "استغفر الله",
                  style: TextStyle(color: Colors.green, fontSize: 21),
                )),
          ),
        ],
      ),
    );
  }
}
