import 'package:flutfire/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authC = Get.find<AuthController>();
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: Lottie.asset('assets/login.json'),
            ),
            Text('LOGIN'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          authC.logout();
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
