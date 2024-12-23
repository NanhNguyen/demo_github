import 'package:firebase.demo.app/data/firebase_auth_service.dart';
import 'package:firebase.demo.app/screens/create_acc_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailEditController = TextEditingController();
  TextEditingController passWordEditController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  'Login here',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1F41BB),
                      fontSize: 25),
                ),
                const Text(
                  "Welcome back you've",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const Text(
                  "been missed!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: emailEditController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Email'),
                ),
                const SizedBox(height: 15),
                TextField(
                  obscureText: true,
                  controller: passWordEditController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), hintText: 'Password'),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot your password?',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xff1F41BB),
                          fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    FirebaseAuthService.signIn(emailEditController.text,
                        passWordEditController.text, context);
                  },
                  child: Container(
                    height: 60,
                    width: 360,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff1F41BB)),
                    child: const Center(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const CreateAccScreen(),
                    ));
                  },
                  child: const Text(
                    'Create new account',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Or continue with',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color(0xff1F41BB)),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        child: Image.network(
                          "https://static-00.iconduck.com/assets.00/google-icon-1024x1024-ilkrdfcp.png",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        child: Image.network(
                          "https://static.vecteezy.com/system/resources/previews/018/910/719/non_2x/facebook-logo-facebook-icon-free-free-vector.jpg",
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: ClipRRect(
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShWNyXKqi1zDEURfD1VE0K_ZHKVJn2X6ilEA&s",
                          fit: BoxFit.fill,
                        ),
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
