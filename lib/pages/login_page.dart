import 'package:flutfire/controllers/auth_controller.dart';
import 'package:flutfire/controllers/login_controller.dart';
import 'package:flutfire/routes/name_route.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    final loginC = Get.find<LoginController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('LOGIN PAGE'),
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
              controller: loginC.email,
            ),
            TextField(
              autocorrect: false,
              autofocus: false,
              decoration: InputDecoration(
                label: Text('Password'),
              ),
              controller: loginC.password,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Belum memiliki akun ?'),
                TextButton(
                  onPressed: () {
                    loginC.email.clear();
                    loginC.password.clear();
                    Get.toNamed(NameRoutes.signin);
                  },
                  child: Text(
                    'Buat akun',
                    style: TextStyle(color: Colors.red),
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
                    authC.login(
                      loginC.email.text,
                      loginC.password.text,
                    );
                  },
                  child: Text(
                    'LOGIN',
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
