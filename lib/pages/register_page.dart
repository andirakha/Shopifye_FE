import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordRetypeController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final dateOfBirthController = TextEditingController();
  final like_status = List.filled(34, false);
  bool passwordVisible = true;
  bool passwordRetypeVisible = true;

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        dateOfBirthController.text = _picked.toString().split(" ")[0];
      });
    }
  }

  void signUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xffac2c62)),
          ),
        );
      },
    );

    try {
      if (usernameController.text.isNotEmpty &&
          dateOfBirthController.text.isNotEmpty &&
          phoneNumberController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          passwordRetypeController.text.isNotEmpty) {
        if (passwordController.text == passwordRetypeController.text) {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
          );

          FirebaseFirestore.instance
              .collection("Users")
              .doc(userCredential.user!.email)
              .set({
            'username': usernameController.text,
            'dateofbirth': dateOfBirthController.text,
            'phonenumber': phoneNumberController.text,
            'likestatus': like_status
          });
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              backgroundColor: Color(0xffdbb9c7),
              title: const Text(
                'Sign Up Error',
                style: TextStyle(
                  fontFamily: 'Leelawadee',
                  color: Color(0xffac2c62),
                ),
              ),
              content: Text(
                'Something wrong with sign up process\nError message: password-dont-match-\nwith-retype-password',
                style: TextStyle(
                  fontFamily: 'Leelawadee',
                  color: Color(0xffac2c62),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
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
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: Color(0xffdbb9c7),
            title: const Text(
              'Sign Up Error',
              style: TextStyle(
                fontFamily: 'Leelawadee',
                color: Color(0xffac2c62),
              ),
            ),
            content: Text(
              'Something wrong with sign up process\nError message: some-fields-are-still-empty',
              style: TextStyle(
                fontFamily: 'Leelawadee',
                color: Color(0xffac2c62),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
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
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Color(0xffdbb9c7),
          title: const Text(
            'Sign Up Error',
            style: TextStyle(
              fontFamily: 'Leelawadee',
              color: Color(0xffac2c62),
            ),
          ),
          content: Text(
            'Something wrong with sign up process\nError message: ' + e.code,
            style: TextStyle(
              fontFamily: 'Leelawadee',
              color: Color(0xffac2c62),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xffdbb9c7),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(84),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          title: Image.asset(
            'lib/assets/logo.png',
            scale: 2.5,
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: 'ErasDemiITC',
                    fontSize: 45,
                    color: Color(0xffac2c62),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[A-Za-z0-9\s]'),
                      ),
                      LengthLimitingTextInputFormatter(40),
                    ],
                    controller: usernameController,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Leelawadee',
                    ),
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffa96682)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffa96682)),
                        ),
                        fillColor: Color(0xffa96682),
                        filled: true,
                        hintText: 'Username',
                        hintStyle: TextStyle(color: Colors.white70)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                    ],
                    controller: emailController,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Leelawadee',
                    ),
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffa96682)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffa96682)),
                        ),
                        fillColor: Color(0xffa96682),
                        filled: true,
                        hintText: 'Email',
                        hintStyle: TextStyle(color: Colors.white70)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                    ],
                    controller: passwordController,
                    obscureText: passwordVisible,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Leelawadee',
                    ),
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffa96682)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffa96682)),
                      ),
                      fillColor: Color(0xffa96682),
                      filled: true,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Colors.white70),
                      suffixIcon: IconButton(
                        icon: Icon(passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: Colors.white,
                        onPressed: () {
                          setState(
                            () {
                              passwordVisible = !passwordVisible;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                    ],
                    controller: passwordRetypeController,
                    obscureText: passwordRetypeVisible,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Leelawadee',
                    ),
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffa96682)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffa96682)),
                      ),
                      fillColor: Color(0xffa96682),
                      filled: true,
                      hintText: 'Retype Password',
                      hintStyle: TextStyle(color: Colors.white70),
                      suffixIcon: IconButton(
                        icon: Icon(passwordRetypeVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: Colors.white,
                        onPressed: () {
                          setState(
                            () {
                              passwordRetypeVisible = !passwordRetypeVisible;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    onTap: () {
                      _selectDate();
                    },
                    readOnly: true,
                    controller: dateOfBirthController,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Leelawadee',
                    ),
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffa96682)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffa96682)),
                        ),
                        fillColor: Color(0xffa96682),
                        filled: true,
                        hintText: 'Date of Birth',
                        hintStyle: TextStyle(color: Colors.white70)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9]'),
                      ),
                      LengthLimitingTextInputFormatter(20),
                    ],
                    controller: phoneNumberController,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Leelawadee',
                    ),
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffa96682)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffa96682)),
                        ),
                        fillColor: Color(0xffa96682),
                        filled: true,
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(color: Colors.white70)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          fontWeight: FontWeight.w100,
                          fontFamily: 'Leelawadee',
                          fontSize: 15,
                          color: Color(0xffa96682),
                        ),
                      ),
                      const SizedBox(width: 7),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Login now',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w100,
                            fontFamily: 'Leelawadee',
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: signUp,
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Sign Up',
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
                SizedBox(
                  height: 60,
                ),
                Text(
                  'Login to Shopifye for easy access to dresses,\nfootwear, accessories, and bags. Your go-to spot for\neffortless style awaits!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontFamily: 'Consolas',
                    fontSize: 15,
                    color: Color(0xffac2c62),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
