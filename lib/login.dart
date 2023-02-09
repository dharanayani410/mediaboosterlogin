import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'main.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  GlobalKey<FormState> loginKey = GlobalKey();

  Future getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var emailVal = prefs.getString('email');
    var passwordVal = prefs.getString('password');
    setState(() {
      Global.email = emailVal;
      Global.password = passwordVal;
    });
  }

  String userName = '';
  String obtainedPassword = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.blue.shade900,
            Colors.blue.shade300,
            Colors.blue.shade300,
            Colors.blue.shade700,
            Colors.blue.shade900,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Form(
              key: loginKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.blue.shade900,
                      child: Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 80,
                        color: Colors.blue.shade200,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your username..";
                        }
                        return null;
                      },
                      controller: Global.userController,
                      onSaved: (val) {
                        setState(() {
                          userName = Global.userController.text;
                        });
                      },
                      decoration: const InputDecoration(
                          hintText: 'user Name',
                          suffixIcon: Icon(Icons.person_outline)),
                    ),
                    TextFormField(
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter your password..";
                        }
                        return null;
                      },
                      controller: Global.password2Controller,
                      onSaved: (val) {
                        setState(() {
                          obtainedPassword = Global.password2Controller.text;
                        });
                      },
                      obscureText: (Global.isActive == false) ? true : false,
                      decoration: InputDecoration(
                          hintText: 'password',
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                Global.isActive = !Global.isActive;
                              });
                            },
                            icon: (Global.isActive == false)
                                ? Icon(Icons.lock_outline)
                                : Icon(Icons.lock_open),
                          )),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 100),
                          backgroundColor: Colors.blue.shade900),
                      onPressed: () async {
                        if (loginKey.currentState!.validate()) {
                          loginKey.currentState!.save();
                          if (Global.email == userName &&
                              Global.password == obtainedPassword) {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setBool('isLoggedIn', true);
                            Navigator.of(context)
                                .pushReplacementNamed('homePage');
                          } else {
                            Navigator.of(context).pushNamed('/');
                          }
                          Global.user = Global.userController.text;
                          print(Global.user);
                        }
                      },
                      child: const Text("Sign In"),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account?"),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/');
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                  ])),
        ),
      ),
    );
  }
}
