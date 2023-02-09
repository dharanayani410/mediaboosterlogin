import 'package:flutter/material.dart';
import 'package:mb1/homePage.dart';
import 'package:mb1/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool? isLoggedVisit = prefs.getBool('isLoggedIn') ?? false;
  bool? isCreatedVisit = prefs.getBool('isSignUp') ?? false;
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: (isCreatedVisit == false)
        ? '/'
        : (isLoggedVisit == false)
            ? 'logIn'
            : 'homePage',
    routes: {
      '/': (context) => const MyApp(),
      'logIn': (context) => const LogIn(),
      'homePage': (context) => const HomePage()
    },
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<FormState> createKey = GlobalKey();
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
            Colors.blue.shade100,
            Colors.blue.shade300,
            Colors.blue.shade900,
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Form(
            key: createKey,
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
                Text(
                  "Create ",
                  style: TextStyle(
                      fontSize: 60,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue.shade700),
                ),
                Text(
                  "account",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade300),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your email..";
                    }
                    return null;
                  },
                  controller: Global.emailController,
                  onSaved: (val) {
                    setState(() {
                      Global.email = Global.emailController.text;
                    });
                  },
                  decoration: const InputDecoration(
                      hintText: 'email',
                      suffixIcon: Icon(Icons.email_outlined)),
                ),
                TextFormField(
                  validator: (val) {
                    if (val!.isEmpty) {
                      return "Enter your user name..";
                    }
                    return null;
                  },
                  controller: Global.email2Controller,
                  onSaved: (val) {
                    setState(() {
                      Global.email = Global.email2Controller.text;
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
                  controller: Global.passwordController,
                  onSaved: (val) {
                    setState(() {
                      Global.password = Global.passwordController.text;
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
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('isSignUp', true);
                    await prefs.setString('email', Global.emailController.text);
                    await prefs.setString(
                        'password', Global.passwordController.text);
                    if (createKey.currentState!.validate()) {
                      createKey.currentState!.save();
                      Navigator.of(context).pushNamed('logIn');
                    }
                  },
                  child: const Text("Sign Up"),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have account?"),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('logIn');
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(color: Colors.blue),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Global {
  static TextEditingController emailController = TextEditingController();
  static TextEditingController passwordController = TextEditingController();
  static TextEditingController userController = TextEditingController();
  static TextEditingController password2Controller = TextEditingController();
  static TextEditingController email2Controller = TextEditingController();
  static String? email;
  static String? password;
  static String? user;
  static bool isActive = false;
}
