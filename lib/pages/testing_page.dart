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

  List like_status = [];

  dynamic firestoreData;

  Future<dynamic> getFirestoreData() async {
    final DocumentReference document =
        FirebaseFirestore.instance.collection("Users").doc(currentUser.email);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        firestoreData = snapshot.data()! as Map<String, dynamic>;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFirestoreData();
  }

  @override
  Widget build(BuildContext context) {
    if (firestoreData == null) {
      return Center(
        child: Text('wait'),
      );
    } else {
      like_status = firestoreData['likestatus'];
      return Center(
        child: Column(
          children: [
            Container(
              color: Colors.red,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Image(
                          image: AssetImage('lib/assets/home.png'),
                          height: 20,
                          width: 20,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Image(
                          image: AssetImage('lib/assets/home.png'),
                          height: 20,
                          width: 20,
                        )
                      ],
                    ),
                    Expanded(
                        child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                'asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf asdf '))),
                    Column(
                      children: [
                        Image(
                          image: AssetImage('lib/assets/home.png'),
                          height: 20,
                          width: 20,
                        )
                      ],
                    )
                  ]),
            )
          ],
        ),
      );
    }
  }
}
