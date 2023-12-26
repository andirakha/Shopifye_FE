import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passwordVisible = true;

  void logIn() async {
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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          backgroundColor: Color(0xffdbb9c7),
          title: const Text(
            'Log In Error',
            style: TextStyle(
              fontFamily: 'Leelawadee',
              color: Color(0xffac2c62),
            ),
          ),
          content: Text(
            'Something wrong with log in process\nError message: ' + e.code,
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
                  'Log In',
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
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Type in your email',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontFamily: 'Leelawadee',
                        fontSize: 18,
                        color: Color(0xffa96682),
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
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Type in your password',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontFamily: 'Leelawadee',
                        fontSize: 18,
                        color: Color(0xffa96682),
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
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Don\'t have an account?',
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
                          'Register now',
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
                  onTap: logIn,
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'Log In',
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    'Login to Shopifye for easy access to dresses, footwear, accessories, and bags. Your go-to spot for effortless style awaits!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontFamily: 'Consolas',
                      fontSize: 15,
                      color: Color(0xffac2c62),
                    ),
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
