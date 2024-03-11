import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutfire/controllers/login_controller.dart';
import 'package:flutfire/controllers/signin_controller.dart';
import 'package:flutfire/routes/name_route.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  FirebaseAuth authn = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => authn.authStateChanges();

  void snackErr(String msg) {
    Get.snackbar('PEMBERITAHUAN', msg);
  }

  void dialogConfim(String midText, Function onConf) {
    Get.defaultDialog(
      title: 'PEMBERITAHUAN',
      middleText: midText,
      textConfirm: 'Ok',
      onConfirm: onConf(),
    );
  }

  void login(String email, String password) async {
    final loginC = Get.find<LoginController>();
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential myUser = await authn.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (myUser.user!.emailVerified == true) {
          loginC.email.clear();
          loginC.password.clear();
          Get.offAllNamed(NameRoutes.home);
        } else {
          Get.defaultDialog(
              title: 'PEMBERITAHUAN',
              middleText:
                  'Kamu belum verifikasi email kamu, silahkan cek email kamu untuk verifikasi',
              onConfirm: () => Get.back(),
              textConfirm: 'Ok');
        }
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == 'user-not-found') {
          Get.defaultDialog(
              title: 'PEMBERITAHUAN',
              middleText: 'Akun tidak ditemukan',
              onConfirm: () => Get.back(),
              textConfirm: 'Ok');
        } else if (e.code == 'wrong-password') {
          Get.defaultDialog(
              title: 'PEMBERITAHUAN',
              middleText:
                  'Password yang anda masukkan salah, harap periksa kembali',
              onConfirm: () => Get.back(),
              textConfirm: 'Ok');
        }
      }
    } else {
      Get.defaultDialog(
          title: 'PEMBERITAHUAN',
          middleText: 'Mohon untuk tidak mengosongkan field',
          onConfirm: () => Get.back(),
          textConfirm: 'Ok');
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(NameRoutes.login);
  }

  void signin(String email, String password, String confirmPass) async {
    final signinC = Get.find<SigninController>();
    if (email.isNotEmpty && password.isNotEmpty && confirmPass.isNotEmpty) {
      if (password == confirmPass) {
        try {
          UserCredential myUser = await authn.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          Get.defaultDialog(
            title: 'PEMBERITAHUAN',
            middleText:
                'Verifikasi akun anda, kami sudah mengirim email ke akun $email',
            textConfirm: 'Ok',
            onConfirm: () async {
              await myUser.user!.sendEmailVerification();
              signinC.emailC.clear();
              signinC.passwordC.clear();
              signinC.confirmPassC.clear();
              Get.back();
              Get.back();
            },
            textCancel: 'Batal',
            onCancel: () async {
              await myUser.user!.delete();
            },
          );
        } on FirebaseAuthException catch (e) {
          if (e.code == 'weak-password') {
            Get.defaultDialog(
                title: 'PEMBERITAHUAN',
                middleText:
                    'Password terlalu lemah, gunakan minimal 6 karakter',
                onConfirm: () => Get.back(),
                textConfirm: 'Ok');
          } else if (e.code == 'email-already-in-use') {
            Get.defaultDialog(
              title: 'PEMBERITAHUAN',
              middleText: 'Email sudah digunakan',
              textConfirm: 'Ok',
              onConfirm: () {
                signinC.emailC.clear();
                signinC.passwordC.clear();
                signinC.confirmPassC.clear();
                Get.back();
              },
            );
          }
        } catch (e) {
          print(e);
        }
      } else {
        Get.defaultDialog(
            title: 'PEMBERITAHUAN',
            middleText: 'Password berbeda, harap untuk periksa dengan benar',
            onConfirm: () => Get.back(),
            textConfirm: 'Ok');
      }
    } else {
      Get.defaultDialog(
          title: 'PEMBERITAHUAN',
          middleText: 'Mohon untuk mengisi email dan password',
          onConfirm: () => Get.back(),
          textConfirm: 'Ok');
    }
  }
}
