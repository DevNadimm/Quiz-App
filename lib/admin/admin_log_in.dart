import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/ui/screens/home_screen.dart';
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
                        obscureText: true, // Hide password input
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
                              adminLogin(); // Call adminLogin on button press
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
    // Get the 'Admin' collection from Firestore and look for the username (id)
    FirebaseFirestore.instance
        .collection('Admin')
        .where('username', isEqualTo: usernameController.text.trim())
        .get()
        .then((snapshot) {

      // Step 1: Check if the username exists
      if (snapshot.docs.isEmpty) {
        // No document with the given username (id), show error for incorrect username
        ToastMessage.errorToast('Incorrect username');
      } else {
        // Username exists, now check the password
        var adminData = snapshot.docs.first.data();

        // Step 2: Check if the password matches
        if (adminData['password'] != passwordController.text.trim()) {
          // Password is incorrect, show error
          ToastMessage.errorToast('Incorrect password');
        } else {
          // Both username and password are correct, navigate to HomeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        }
      }
    }).catchError((error) {
      // Step 3: If there's any problem (like network/database error), show error
      ToastMessage.errorToast('Error connecting to database: $error');
    });
  }
}
