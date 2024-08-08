import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//header page
class MyHeaderDrawer extends StatefulWidget {
  final String userId;

  const MyHeaderDrawer({super.key, required this.userId});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  late Future<DocumentSnapshot> userData;

  @override
  void initState() {
    super.initState();
    userData = fetchUserData();
  }

  Future<DocumentSnapshot> fetchUserData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: userData,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            color: Colors.purple,
            width: double.infinity,
            height: 200,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Container(
            color: Colors.purple,
            width: double.infinity,
            height: 200,
            child: const Center(child: Text('Error fetching data')),
          );
        } else if (!snapshot.hasData || !snapshot.data!.exists) {
          return Container(
            color: Colors.purple,
            width: double.infinity,
            height: 200,
            child: const Center(child: Text('No user data found')),
          );
        } else {
          var userDocument = snapshot.data;
          return Container(
            color: Colors.purple,
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 70,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('asset/images/husband.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Text(
                  userDocument?['full_name'],
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
                Text(
                  userDocument?['email'],
                  style: TextStyle(
                    color: Colors.grey[200],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
