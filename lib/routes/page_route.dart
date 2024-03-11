import 'package:flutfire/pages/home_page.dart';
import 'package:flutfire/pages/login_page.dart';
import 'package:flutfire/pages/signin_page.dart';
import 'package:flutfire/routes/name_route.dart';
import 'package:get/get_navigation/get_navigation.dart';

class PageRoutes {
  static final pages = [
    GetPage(
      name: NameRoutes.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: NameRoutes.home,
      page: () => HomePage(),
    ),
    GetPage(
      name: NameRoutes.signin,
      page: () => SigninPage(),
    )
  ];
}
