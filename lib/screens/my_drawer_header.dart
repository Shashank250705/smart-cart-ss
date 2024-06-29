import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//.
class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({super.key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          height: 70,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage('asset/images/shashank.png'))),
        ),
        const Text(
          "Simple pay",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Text(
          "info@simplepay.dev",
          style: TextStyle(
            color: Colors.grey[200],
            fontSize: 14,
          ),
        ),
      ]),
    );
  }
}

/*
class MyHeaderDrawer extends StatelessWidget {
  const MyHeaderDrawer({super.key});

  //const MyHeaderDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50.0,
            backgroundImage: NetworkImage(
                'https://www.example.com/user_image.jpg'), // Add your image URL here
          ),
          SizedBox(height: 10.0),
          Text(
            'User Name',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          Text(
            'user.email@example.com',
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}*/