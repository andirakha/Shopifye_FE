import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:shopifye_e_commerce/pages/home_page.dart";
import "package:shopifye_e_commerce/pages/login_page.dart";
import "package:shopifye_e_commerce/pages/register_page.dart";
import "package:shopifye_e_commerce/pages/testing_page.dart";

class AuthRouting extends StatelessWidget {
  const AuthRouting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TestingPage();
          } else {
            return LoginOrRegisterRouting();
          }
        },
      ),
    );
  }
}

class LoginOrRegisterRouting extends StatefulWidget {
  const LoginOrRegisterRouting({super.key});

  @override
  State<LoginOrRegisterRouting> createState() => _LoginOrRegisterRoutingState();
}

class _LoginOrRegisterRoutingState extends State<LoginOrRegisterRouting> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
