import 'package:tamannaah/darkknight/extensions/extensions.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:firebase_ui_oauth_facebook/firebase_ui_oauth_facebook.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';

import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider, PhoneAuthProvider;

import '../widgets/fire_image.dart';

class SnapAuth extends ConsumerStatefulWidget {
  const SnapAuth({super.key});

  @override
  ConsumerState<SnapAuth> createState() => _SnapAuthState();
}

class _SnapAuthState extends ConsumerState<SnapAuth> {
  final _formKey = GlobalKey<FormState>();

  final providers = <AuthProvider>[
    GoogleProvider(clientId: 'not for mobile'),
    FacebookProvider(clientId: 'not for mobile'),
    EmailAuthProvider(),
    PhoneAuthProvider(),
    EmailLinkAuthProvider(
      actionCodeSettings: ActionCodeSettings(
        url: 'https://<your-project-id>.page.link',
        handleCodeInApp: true,
        androidMinimumVersion: '1',
        androidPackageName: 'io.flutter.plugins.firebase_ui.firebase_ui_example',
        iOSBundleId: 'io.flutter.plugins.flutterfireui.flutterfireUIExample',
      ),
    ),
  ];

  // @override
  // Widget build(BuildContext context) {

  //   if (FirebaseAuth.instance.currentUser == null)
  //     return Theme(
  //       data: Theme.of(context).copyWith(
  //           // inputDecorationTheme: InputDecorationTheme(
  //           //   border: OutlineInputBorder(
  //           //     borderRadius: BorderRadius.circular(8),
  //           //   ),
  //           // ),
  //           // outlinedButtonTheme: OutlinedButtonThemeData(
  //           //   style: ButtonStyle(
  //           //     padding: MaterialStateProperty.all<EdgeInsets>(
  //           //       const EdgeInsets.all(24),
  //           //     ),
  //           //     backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
  //           //     foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  //           //   ),
  //           // ),
  //           ),
  //       child: SignInScreen(
  //         actions: [
  //           AuthStateChangeAction<SignedIn>((context, state) {
  //             if (!state.user!.emailVerified) {
  //               Navigator.of(context).push(
  //                 MaterialPageRoute(
  //                   builder: (context) => EmailVerificationScreen(
  //                     actions: [
  //                       EmailVerifiedAction(() {
  //                         Navigator.pushReplacementNamed(context, '/profile');
  //                       }),
  //                       AuthCancelledAction((context) {
  //                         FirebaseUIAuth.signOut(context: context);
  //                         Navigator.pushReplacementNamed(context, '/');
  //                       }),
  //                     ],
  //                   ),
  //                 ),
  //               );
  //             } else {
  //               Navigator.pushReplacementNamed(context, '/profile');
  //             }
  //           }),
  //         ],
  //         providers: providers,
  //       ),
  //     );

  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ProfileScreen(
        appBar: AppBar(title: Text('App Bar')),
        avatarSize: 200,
        avatarShape: 3.bs.c(Colors.red).round.r(20),
        providers: providers,
        children: [
          Text('uid  ${FirebaseAuth.instance.currentUser?.uid}'),
          Text('email  ${FirebaseAuth.instance.currentUser?.email}'),
          Text('verified  ${FirebaseAuth.instance.currentUser?.emailVerified}'),
          Text('phone  ${FirebaseAuth.instance.currentUser?.phoneNumber}'),
          Text('provider  ${FirebaseAuth.instance.currentUser?.providerData.map((e) => e.providerId)}'),
          FutureBuilder(
            future: FirebaseAuth.instance.fetchSignInMethodsForEmail('shadow@mailinator.com'),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text('No Providers');
              return Text(snapshot.data.toString());
            },
          ),
          // GoogleSignInButton(
          //   clientId: 'clientId',
          //   loadingIndicator: CircularProgressIndicator(),
          //   onSignedIn: (UserCredential credential) {
          //     // perform navigation.
          //   },
          // ),
          // FacebookSignInButton(
          //   clientId: 'clientId',
          //   loadingIndicator: CircularProgressIndicator(),
          //   onSignedIn: (UserCredential credential) {
          //     // perform navigation.
          //   },
          // ),
          // TextField(
          //   name: 'display_name',
          //   onSubmitted: (value) {
          //     print(value);
          //   },
          //   decoration: InputDecoration(
          //     label: Text('Update Display Name'),
          //     hintText: 'Hint',
          //     suffixIcon: IconButton(
          //       icon: Icon(Icons.wind_power_outlined),
          //       onPressed: () {
          //         _formKey.currentState?.saveAndValidate();
          //       },
          //     ),
          //   ),
          //   onSaved: (newValue) {
          //     print('saved : $newValue');
          //     FirebaseAuth.instance.currentUser?.updateDisplayName(newValue);
          //   },
          // ),
          // TextField(
          //   name: 'email_update',
          //   onSubmitted: (value) {
          //     print(value);
          //   },
          //   decoration: InputDecoration(
          //     label: Text('Update Email'),
          //     hintText: 'Hint',
          //     suffixIcon: IconButton(
          //       icon: Icon(Icons.wind_power_outlined),
          //       onPressed: () {
          //         _formKey.currentState?.saveAndValidate();
          //       },
          //     ),
          //   ),
          //   onSaved: (newValue) {
          //     print('saved : $newValue');
          //     try {
          //       FirebaseAuth.instance.currentUser?.updateEmail(newValue ?? '-');
          //     } catch (e) {
          //       print(e);
          //     }
          //   },
          // ),
          // TextField(
          //   name: 'password',
          //   onSubmitted: (value) {
          //     print(value);
          //   },
          //   decoration: InputDecoration(
          //     label: Text('Update Password'),
          //     hintText: 'Hint',
          //     suffixIcon: IconButton(
          //       icon: Icon(Icons.wind_power_outlined),
          //       onPressed: () {
          //         _formKey.currentState?.saveAndValidate();
          //       },
          //     ),
          //   ),
          //   onSaved: (newValue) {
          //     print('saved : $newValue');
          //     FirebaseAuth.instance.currentUser?.updatePassword(newValue ?? '-');
          //   },
          // ),
          FilledButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            child: Text('Sign Out'),
          ),
          FilledButton(
            onPressed: () {
              FirebaseAuth.instance.currentUser?.sendEmailVerification();
            },
            child: Text('Verify'),
          ),
          FilledButton(
            onPressed: () {
              FirebaseAuth.instance.sendPasswordResetEmail(email: 'email');
            },
            child: Text('Password reset'),
          ),
          FilledButton(
            onPressed: () {
              FirebaseAuth.instance.currentUser?.delete();
            },
            child: Text('Delete Account'),
          ),
          const AuthImage(),
        ],
      ),
    );
  }
}
