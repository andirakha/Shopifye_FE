import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class TestingPage extends StatefulWidget {
  const TestingPage({super.key});

  @override
  State<TestingPage> createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  List category = [];
  dynamic data;
  Future<dynamic> getData() async {
    final DocumentReference document =
        FirebaseFirestore.instance.collection("Users").doc(currentUser.email);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        data = snapshot.data()! as Map<String, dynamic>;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Center(
        child: Text('wait'),
      );
    } else {
      category = data['catalog'];
      return Center(
        child: Column(
          children: [
            Text(category[1]),
          ],
        ),
      );
    }
  }
}
