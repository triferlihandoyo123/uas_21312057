import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uas_21312057/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  void signup(String emailAddress, String password) async {
    try {
      UserCredential myUser = await auth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await myUser.user!.sendEmailVerification();
      Get.defaultDialog(
          title: "Verifikasi Email",
          middleText:
              "Kami telah mengirimkan verifikasi ke email $emailAddress.",
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: "OK");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void login(String emailAddress, String password) async {
    try {
      UserCredential myUser = await auth.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (myUser.user!.emailVerified) {
        Get.offAllNamed(Routes.HOME);
      } else {
        Get.defaultDialog(
          title: "Verifikasi Email",
          middleText: "Harap Verifikasi Email Terlebih Dahulu",
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.defaultDialog(
            title: "Terjadi Kesalahan ",
            middleText: "Wrong password provided for that user.",
            onConfirm: () {
              Get.back();
              Get.back();
            },
            textConfirm: "OK");
        print('Wrong password provided for that user.');
      }
    }
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  void input() async {}

  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
            title: "Berhasil ",
            middleText: "Kami Telah mengirimkan Reset Password ke $email",
            onConfirm: () {
              Get.back();
              Get.back();
            },
            textConfirm: "OK");
      } catch (e) {
        Get.defaultDialog(
            title: "Terjadi Kesalahan",
            middleText: "Tidak dapat melakukan Reset Password $email");
      }
    } else {
      Get.defaultDialog(
          title: "Terjadi Kesalahan", middleText: "Email Tidak Valid");
    }
  }

  void loginGoogle() async {
    try {
      GoogleSignIn _googleSigIn = GoogleSignIn();
      GoogleSignInAccount? googleUser = await _googleSigIn.signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        Get.offNamed(Routes.HOME);
      } else {
        throw "Belum Memilih Akun Google";
      }
    } catch (error) {
      print(error);
      Get.defaultDialog(
        title: "Terjadi Kesalahan",
        middleText: "${error.toString()}",
      );
    }
  }
}
