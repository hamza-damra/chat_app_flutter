import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat_app/screens/register_page.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_fild_for_register_and_login.dart';
import 'chat_page.dart';

class LoginPage extends StatefulWidget {
  static String id = 'login';

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  late String email;
  late String password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KPrimaryColor, // Background color for the entire page
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                const Center(
                  child: Image(
                    image: AssetImage('assets/images/scholar.png'),
                    width: 120,
                    height: 120,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Scholar Chat',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontFamily: 'pacifico',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 90),
                const Text(
                  'Loge In',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                    hintText: 'Enter your email address',
                    onChanged: (value) {
                      email = value;
                    },
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 10),
                CustomTextField(
                    hintText: 'Enter your password',
                    onChanged: (value) {
                      password = value;
                    },
                    keyboardType: TextInputType.visiblePassword,
                    visableText: true),
                const SizedBox(height: 20),
                CustomButton(
                    text: 'Log In',
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.orangeAccent,
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.orangeAccent),
                                    backgroundColor: KPrimaryColor,
                                  ),
                                );
                              });

                          await login();

                          if (mounted) {
                            setState(() {
                              Navigator.pop(context);
                              Navigator.of(context).pushReplacementNamed(
                                  ChatPage.id,
                                  arguments: email);
                            });
                          }
                        } catch (e) {
                          if (mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(e.toString()),
                              ),
                            );
                          }
                        }
                      } else {
                        print('Form is invalid');
                      }
                    }),
                const SizedBox(height: 15),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pushNamed(context, RegisterPage.id),
                    child: const Text(
                      "Already have an account? Sign up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
