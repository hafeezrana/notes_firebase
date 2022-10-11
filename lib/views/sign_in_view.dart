import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_firebase/services/auth_service.dart';
import 'package:note_firebase/views/sign_up_view.dart';

import 'home_view.dart';

class SignInView extends ConsumerWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // @override
  // void dispose() {
  //   super.dispose();
  //   emailController.text;
  //   passwordController.text;
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignIn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0).copyWith(left: 24, right: 24),
        child: Column(
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: "Enter your Email...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: "Enter your Password...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Forgot password?',
              style: TextStyle(
                  color: Colors.red, fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 8,
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.watch(notesAuthProvider).loginIn(
                      email: emailController.text,
                      password: passwordController.text);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                  );
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'user-not-found') {
                    showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: Text(e.message.toString()),
                      ),
                    );
                  } else if (e.code == 'wrong-password') {
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
                      child: Text(
                        e.toString(),
                      ),
                    ),
                  );
                }
              },
              child: const Text('SignIn'),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => SignUpView(),
                  ),
                );
              },
              child: const Text('create a new account?'),
            ),
          ],
        ),
      ),
    );
  }
}
