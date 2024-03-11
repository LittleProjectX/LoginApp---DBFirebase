import 'package:flutfire/controllers/auth_controller.dart';
import 'package:flutfire/controllers/signin_controller.dart';
import 'package:flutfire/routes/name_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    final signinC = Get.find<SigninController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('SIGNIN PAGE'),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              autocorrect: false,
              autofocus: false,
              decoration: InputDecoration(
                label: Text('Email'),
              ),
              controller: signinC.emailC,
            ),
            TextField(
              autocorrect: false,
              autofocus: false,
              decoration: InputDecoration(
                label: Text('Password'),
              ),
              controller: signinC.passwordC,
            ),
            TextField(
              autocorrect: false,
              autofocus: false,
              decoration: InputDecoration(
                label: Text('Confirm Password'),
              ),
              controller: signinC.confirmPassC,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Sudah memiliki akun ?'),
                TextButton(
                  onPressed: () {
                    Get.toNamed(NameRoutes.login);
                  },
                  child: Text(
                    'Masuk',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                )
              ],
            ),
            Container(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                  onPressed: () {
                    authC.signin(
                      signinC.emailC.text,
                      signinC.passwordC.text,
                      signinC.confirmPassC.text,
                    );
                  },
                  child: Text(
                    'SIGNIN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  )),
            )
          ],
        ),
      )),
    );
  }
}
