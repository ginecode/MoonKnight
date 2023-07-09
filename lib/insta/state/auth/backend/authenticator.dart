import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pinput/pinput.dart';
import 'package:moonknight/insta/state/auth/constants/constants.dart';
import 'package:moonknight/insta/state/auth/models/auth_result.dart';

class Authenticator {
  const Authenticator();

  // getters

  bool get isAlreadyLoggedIn => user != null;
  User? get user => FirebaseAuth.instance.currentUser;

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  Future<void> deleteAccount() async {
    await FirebaseAuth.instance.currentUser?.delete();
  }

  Future<AuthResult> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;
    if (token == null) {
      return AuthResult.aborted;
    }
    final oauthCredentials = FacebookAuthProvider.credential(token);

    try {
      await FirebaseAuth.instance.signInWithCredential(
        oauthCredentials,
      );
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;
      if (e.code == Constants.accountExistsWithDifferentCredentialsError && email != null && credential != null) {
        final providers = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
          FirebaseAuth.instance.currentUser?.linkWithCredential(credential);
        }
        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginAnonymously() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      return AuthResult.success;
    } catch (e) {
      print(e);
      return AuthResult.failure;
    }
  }

  Future<AuthResult> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final res = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(res.toString());
      print(res.user);

      return AuthResult.success;
    } catch (e) {
      print(e);
      return AuthResult.failure;
    }
  }

  Future<AuthResult> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final res = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print(res.toString());
      print(res.user);

      return AuthResult.success;
    } catch (e) {
      print(e);
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        Constants.emailScope,
      ],
    );
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    try {
      await FirebaseAuth.instance.signInWithCredential(
        oauthCredentials,
      );
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithPhone(BuildContext context, String phone) async {
    bool done = false;

    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
        //
        phoneNumber: phone,

        //
        verificationCompleted: (PhoneAuthCredential credential) async {
          log('verification compeleted');
          // await FirebaseAuth.instance.signInWithCredential(credential);
        },

        //
        verificationFailed: (FirebaseAuthException e) {
          log(e.toString());
          if (e.code == 'invalid-phone-number') {
            log('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          log('code sent');

          // Update the UI - wait for the user to enter the SMS code
          String smsCode = '';

          await showDialog(
            context: context,
            builder: (con) {
              final defaultPinTheme = PinTheme(
                width: 56,
                height: 56,
                textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                  borderRadius: BorderRadius.circular(20),
                ),
              );

              final focusedPinTheme = defaultPinTheme.copyDecorationWith(
                border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
                borderRadius: BorderRadius.circular(8),
              );

              final submittedPinTheme = defaultPinTheme.copyWith(
                decoration: defaultPinTheme.decoration?.copyWith(
                  color: Color.fromRGBO(234, 239, 243, 1),
                ),
              );

              return Dialog(
                child: Column(
                  children: [
                    Pinput(
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      // validator: (s) {
                      //   return s == '2222' ? null : 'Pin is incorrect';
                      // },
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      showCursor: true,
                      onCompleted: (pin) => smsCode = pin,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // Create a PhoneAuthCredential with the code
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: smsCode,
                        );

                        // Sign the user in (or link) with the credential
                        try {
                          await FirebaseAuth.instance.signInWithCredential(credential).then(
                            (value) {
                              done = true;
                              log(credential.toString());
                            },
                          );
                          if (context.mounted) {
                            Navigator.pop(context);
                          }
                        } catch (e) {
                          log('Error otp : $e');
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ],
                ),
              );
            },
          );
        },

        //
        codeAutoRetrievalTimeout: (String verificationId) {
          log('code auto retrieval timeout : $verificationId');
        },
      );

      if (done) {
        return AuthResult.success;
      } else {
        return AuthResult.failure;
      }
    } catch (e) {
      return AuthResult.failure;
    }
  }
}
