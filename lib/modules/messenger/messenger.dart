import 'package:flutter/material.dart';

class Messenger extends StatelessWidget {
  const Messenger({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/34.jpg'),
            radius: 15,
          ),
        ),
        title: const Text(
          "Chats",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.camera_alt),
            color: const Color.fromARGB(255, 26, 26, 26),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            color: const Color.fromARGB(255, 26, 26, 26),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey,
              ),
              child: Row(
                children: [
                  const Icon(Icons.search),
                  const SizedBox(
                    width: 20,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Search",
                      style: TextStyle(color: Colors.black38, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    SizedBox(
                      height: 110,
                      child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) => buildStoriesItem(),
                          separatorBuilder: (context, index) => const SizedBox(
                                width: 20,
                              ),
                          itemCount: 7),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) => buildChatItem(),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 20,
                            ),
                        itemCount: 10)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildStoriesItem() {
    return const SizedBox(
      width: 70,
      height: 100,
      child: Column(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('assets/34.jpg'),
                radius: 30,
              ),
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: 8,
              ),
            ],
          ),
          SizedBox(height: 10),
          Text('Mahmoud Hazmeh',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget buildChatItem() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage('assets/34.jpg'),
          radius: 30,
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Osama Kheir",
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            Row(
              children: [
                Text(
                  "hello how are you my friend?",
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey[700]),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  "Sat",
                  style: TextStyle(color: Colors.grey[999]),
                ),
                const SizedBox(
                  width: 2,
                ),
                Text(
                  '10:24 am',
                  style: TextStyle(color: Colors.grey[900]),
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
