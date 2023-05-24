import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome To The App",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          color: Colors.white,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.message),
            color: Colors.white,
          ),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.search), color: Colors.white)
        ],
        backgroundColor: Colors.purple,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/users_data');
        },
        backgroundColor: Colors.blueGrey,
        child: const Text(
          'USERS',
          style: TextStyle(fontSize: 11),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 400,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/messenger');
                },
                child: const Text("Messenger",
                    style: TextStyle(color: Colors.white, fontSize: 40)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 400,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text("Login",
                    style: TextStyle(color: Colors.white, fontSize: 40)),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              width: 400,
              height: 60,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.deepPurple),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text("Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 40)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 400,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: const BorderRadius.all(Radius.circular(25)),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/simplecounter');
                },
                child: const Text("Simple Counter",
                    style: TextStyle(color: Colors.white, fontSize: 40)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/bmical"),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[200]),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.boy_rounded,
                          color: Colors.black,
                          size: 60,
                        ),
                        // SizedBox(
                        //   height: 7,
                        // ),
                        Text(
                          'BMI CAL',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/todo_app"),
                  child: Container(
                    alignment: Alignment.topCenter,
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: Colors.grey[200]),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Icon(
                          Icons.check_box,
                          color: Colors.black,
                          size: 40,
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'ToDo\n Tasks',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
