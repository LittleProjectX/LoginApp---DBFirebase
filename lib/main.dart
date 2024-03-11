import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutfire/controllers/auth_controller.dart';
import 'package:flutfire/controllers/login_controller.dart';
import 'package:flutfire/controllers/signin_controller.dart';
import 'package:flutfire/routes/name_route.dart';
import 'package:flutfire/routes/page_route.dart';
import 'package:flutfire/utils/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final authC = Get.put(AuthController(), permanent: true);
  final loginC = Get.put(LoginController());
  final signinC = Get.put(SigninController());

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: authC.streamAuthStatus,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute:
                snapshot.data != null && snapshot.data!.emailVerified == true
                    ? NameRoutes.home
                    : NameRoutes.login,
            getPages: PageRoutes.pages,
            // home: snapshot.data != null ? HomePage() : LoginPage(),
          );
        }
        return LoadingView();
      },
    );
  }
}
