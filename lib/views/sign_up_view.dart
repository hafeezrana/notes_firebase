import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_firebase/models/user.dart';
import 'package:note_firebase/services/auth_service.dart';
import 'package:note_firebase/services/firestore_service.dart';
import 'package:note_firebase/widgets/reusable_textform.dart';

import 'home_view.dart';
import 'sign_in_view.dart';

class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  static const routeName = '/sign-up';

  static Route<void> route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return FadeTransition(
          opacity: animation,
          child: const SignUpView(),
        );
      },
    );
  }

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SignUpViewState();
}

class SignUpViewState extends ConsumerState<SignUpView> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    addressController.dispose();
    contactController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void _onSignUpPressed() async {
    final newUser = UserModel(
      userName: nameController.text,
      contactNo: contactController.text,
      address: addressController.text,
    );
    try {
      await ref
          .watch(notesAuthProvider)
          .createUser(email: emailController.text, password: passwordController.text);
      await ref.watch(notesFireStoreProvider).addUser(newUser);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Text(e.message.toString()),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(e.message.toString()),
            ),
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0).copyWith(left: 24, right: 24),
        child: Column(
          children: [
            const SizedBox(height: 8),
            ReUsableTextFormField(
              controller: nameController,
              labelText: 'Name',
              hintText: "Enter Name...",
            ),
            const SizedBox(height: 8),
            ReUsableTextFormField(
              controller: addressController,
              labelText: 'Address',
              hintText: "Enter address...",
            ),
            const SizedBox(height: 8),
            ReUsableTextFormField(
              controller: contactController,
              labelText: 'Contact',
              hintText: "Enter your contact...",
            ),
            const SizedBox(height: 8),
            ReUsableTextFormField(
              controller: emailController,
              icon: const Icon(Icons.email),
              labelText: 'Email',
              hintText: "Enter your Email...",
            ),
            const SizedBox(height: 8),
            ReUsableTextFormField(
              controller: passwordController,
              icon: const Icon(Icons.lock),
              labelText: 'Password',
              hintText: "Enter your password...",
            ),
            const SizedBox(height: 8),
            const Text(
              'Forgot password?',
              style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: _onSignUpPressed,
              child: const Text('SignUp'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  SignInView.route(),
                  (route) => false,
                );
              },
              child: const Text('already have an account?'),
            ),
          ],
        ),
      ),
    );
  }
}
