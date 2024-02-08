import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input_fild_for_register_and_login.dart';

class RegisterPage extends StatefulWidget {
  static String id = 'register';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFF284461), // Background color for the entire page
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
                  'REGISTER',
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
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 10),
                CustomTextField(
                  keyboardType: TextInputType.visiblePassword,
                  visableText: true,
                  hintText: 'Enter your password',
                  onChanged: (value) {
                    password = value;
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(
                  text: 'REGISTER',
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Colors.orangeAccent,
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.orangeAccent),
                              backgroundColor: KPrimaryColor,
                            ));
                          },
                        );
                        await register();
                        if (mounted) {
                          Navigator.of(context).pop();
                        }
                      } on FirebaseAuthException catch (e) {
                        if (mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(e.message ?? "An error occurred"),
                            ),
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("An unexpected error occurred"),
                            ),
                          );
                        }
                      }
                    }
                  },
                ),
                const SizedBox(height: 15),
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Text(
                      "Already have an account? Sign in",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> register() async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    );
  }
}
