import 'package:flutter/material.dart';

import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.blue.shade900,
            Colors.blue.shade300,
            Colors.blue.shade100,
            Colors.blue.shade300,
            Colors.blue.shade900,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                height: 20,
              ),
              Text(
                "Welcome ",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 60,
                    color: Colors.blue.shade700),
              ),
              Text(
                "back",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade500),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    backgroundColor: Colors.blue.shade900),
                onPressed: () {},
                child: Text("LogIn as  ${Global.userController.text}"),
              ),
              const Spacer(),
              GestureDetector(
                child: const Center(child: Text("Delete Account")),
                onTap: () {
                  Global.password2Controller.clear();
                  Global.emailController.clear();
                  Global.userController.clear();
                  Global.passwordController.clear();
                  Navigator.of(context).pushNamed('/');
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
