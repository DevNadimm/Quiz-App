import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app/ui/screens/add_quiz_screen.dart';
import 'package:quiz_app/ui/widgets/gradient_background.dart';
import 'package:quiz_app/utils/toast.dart';

class AdminLogInScreen extends StatefulWidget {
  const AdminLogInScreen({super.key});

  @override
  State<AdminLogInScreen> createState() => _AdminLogInScreenState();
}

class _AdminLogInScreenState extends State<AdminLogInScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Admin Login',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: GradientBackground(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                      elevation: 4,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Form(
                          key: _key,
                          child: Column(
                            children: [
                              Text(
                                'Quiz-App',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium!
                                    .copyWith(color: Colors.black),
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
                                decoration: const InputDecoration(
                                  hintText: "Username",
                                  prefixIcon: Icon(Icons.person_outline_rounded),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextFormField(
                                controller: passwordController,
                                style: const TextStyle(fontWeight: FontWeight.w600),
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please enter your password";
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.lock_outline_rounded),
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
                                  child: const Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Text('Log In'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
              builder: (context) => const AddQuizScreen(),
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
