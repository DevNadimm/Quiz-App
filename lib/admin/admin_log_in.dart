import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/admin/add_quiz.dart';
import 'package:quiz_app/utils/toast.dart';

class AdminLogIn extends StatefulWidget {
  const AdminLogIn({super.key});

  @override
  State<AdminLogIn> createState() => _AdminLogInState();
}

class _AdminLogInState extends State<AdminLogIn> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/login.jpg",
                        scale: 3.5,
                      ),
                      Text(
                        'Let\'s start with Admin!',
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Colors.blueAccent),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: usernameController,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your username";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.blue.withOpacity(0.1),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Username",
                          prefixIcon: const Icon(Icons.email_outlined),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        obscureText: true,
                        // Hide password input
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a strong password";
                          } else if (value.length < 6) {
                            return "Password must be at least 6 characters long";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.blue.withOpacity(0.1),
                          filled: true,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock_outline_rounded),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_key.currentState!.validate()) {
                              adminLogin();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(15),
                            child: Text('Log In'),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void adminLogin() {
    FirebaseFirestore.instance
        .collection('Admin')
        .where('username', isEqualTo: usernameController.text.trim())
        .get()
        .then((snapshot) {
      if (snapshot.docs.isEmpty) {
        ToastMessage.errorToast('Incorrect username');
      } else {
        var adminData = snapshot.docs.first.data();

        if (adminData['password'] != passwordController.text.trim()) {
          ToastMessage.errorToast('Incorrect password');
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AddQuiz(),
            ),
          );
          ToastMessage.successToast('Admin login successful!');
        }
      }
    }).catchError((error) {
      ToastMessage.errorToast('Error connecting to database: $error');
    });
  }
}
