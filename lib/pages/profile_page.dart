import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("Users");

  void logOut() {
    Navigator.pop(context);
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }

  void logOutMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Color(0xffdbb9c7),
        title: const Text(
          'Log Out Message',
          style: TextStyle(
            fontFamily: 'Leelawadee',
            color: Color(0xffac2c62),
          ),
        ),
        content: Text(
          'Are you sure you want to log out?',
          style: TextStyle(
            fontFamily: 'Leelawadee',
            color: Color(0xffac2c62),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontFamily: 'Leelawadee',
                color: Colors.white,
              ),
            ),
          ),
          TextButton(
            onPressed: logOut,
            child: const Text(
              'OK',
              style: TextStyle(
                fontFamily: 'Leelawadee',
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> editField(String field, String fieldname) async {
    String newvalue = '';
    bool cancelNewValue = false;
    if (field != 'dateofbirth') {
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Edit $fieldname",
            style: TextStyle(
              fontFamily: 'Leelawadee',
              color: Color(0xffac2c62),
            ),
          ),
          content: TextField(
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(
                  (field == 'phonenumber' ? r'[0-9]' : r'[A-Za-z0-9\s]')))
            ],
            cursorColor: Color(0xffac2c62),
            keyboardType: (field == 'phonenumber'
                ? TextInputType.number
                : TextInputType.text),
            autofocus: true,
            style: TextStyle(
              fontFamily: 'Leelawadee',
              color: Color(0xffac2c62),
            ),
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffac2c62))),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffac2c62))),
              hintText: "Enter new $fieldname",
              hintStyle: TextStyle(color: Color(0xffac2c62).withOpacity(0.7)),
            ),
            onChanged: (value) {
              newvalue = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(cancelNewValue = true),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'Leelawadee',
                  color: Color(0xffac2c62),
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Save',
                style: TextStyle(
                  fontFamily: 'Leelawadee',
                  color: Color(0xffac2c62),
                ),
              ),
            )
          ],
        ),
      );
    } else {
      DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );

      if (_picked != null) {
        setState(() {
          newvalue = _picked.toString().split(" ")[0];
        });
      }
    }
    if (newvalue.trim().length > 0 && cancelNewValue != true) {
      await usersCollection.doc(currentUser.email).update(
        {field: newvalue},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xffdbb9c7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(84),
        child: AppBar(
          leading: BackButton(color: Color(0xffac2c62)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          title: Text(
            'User Profile',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'ErasDemiITC',
              color: Color(0xffac2c62),
            ),
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: <Color>[
                  Colors.white,
                  Colors.white.withAlpha(0),
                ],
                stops: [0.67, 1],
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(currentUser.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            return ListView(
              children: [
                SizedBox(height: 50),
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Color(0xffac2c62),
                  child: CircleAvatar(
                    radius: 95,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: Image.asset(
                        'lib/assets/default_profile.png',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffa96682),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(left: 15, bottom: 15),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Username',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Leelawadee',
                            ),
                          ),
                          IconButton(
                            onPressed: () => editField('username', 'Username'),
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white60,
                            ),
                          )
                        ],
                      ),
                      Text(
                        userData['username'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Leelawadee',
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffa96682),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(left: 15, bottom: 15),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Leelawadee',
                            ),
                          ),
                          IconButton(
                            hoverColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings,
                              color: Color(0xffa96682),
                            ),
                          )
                        ],
                      ),
                      Text(
                        currentUser.email!,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Leelawadee',
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffa96682),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(left: 15, bottom: 15),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date of Birth',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Leelawadee',
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                editField('dateofbirth', 'Date of Birth'),
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white60,
                            ),
                          )
                        ],
                      ),
                      Text(
                        userData['dateofbirth'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Leelawadee',
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffa96682),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.only(left: 15, bottom: 15),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Phone Number',
                            style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w100,
                              fontFamily: 'Leelawadee',
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                editField('phonenumber', 'Phone Number'),
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white60,
                            ),
                          )
                        ],
                      ),
                      Text(
                        userData['phonenumber'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Leelawadee',
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                UnconstrainedBox(
                  child: GestureDetector(
                    onTap: logOutMessage,
                    child: Container(
                      width: 150,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Log Out',
                          style: const TextStyle(
                            fontWeight: FontWeight.w100,
                            fontFamily: 'Leelawadee',
                            fontSize: 15,
                            color: Color(0xffa96682),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error${snapshot.error}'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xffac2c62)),
            ),
          );
        },
      ),
    );
  }
}
