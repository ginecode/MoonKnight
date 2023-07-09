import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:pinput/pinput.dart';
import 'package:moonknight/insta/views/login/facebook_button.dart';
import 'package:moonknight/insta/views/login/google_button.dart';
import 'package:moonknight/snap/providers/auth.dart';
import 'package:country_picker/country_picker.dart';

class Login extends HookConsumerWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController(text: 'shadow@mailinator.com');
    final passwordController = useTextEditingController(text: 'HelloHippo');
    final phoneController = useTextEditingController(text: '');
    final countryCode = useState('');

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'
            // GoRouterState.of(context).location
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: emailController,
              ),
              TextFormField(
                controller: passwordController,
              ),
              ElevatedButton(
                onPressed: () async {
                  ref.read(authProvider.notifier).createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                },
                child: const Text('Sign up'),
              ),
              ElevatedButton(
                onPressed: () async {
                  ref.read(authProvider.notifier).signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                },
                child: const Text('Sign in'),
              ),

              //
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () async {
                  // ref.read(authProvider.notifier).phoneLogin(context);

                  showCountryPicker(
                    context: context,
                    showPhoneCode: true,
                    countryListTheme: CountryListThemeData(
                      flagSize: 25,
                      backgroundColor: Colors.white,
                      textStyle: TextStyle(fontSize: 16, color: Colors.blueGrey),
                      bottomSheetHeight: 500, // Optional. Country list modal height
                      //Optional. Sets the border radius for the bottomsheet.
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                      //Optional. Styles the search field.
                      inputDecoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Start typing to search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF8C98A8).withOpacity(0.2),
                          ),
                        ),
                      ),
                    ),
                    onSelect: (Country country) => countryCode.value = '+${country.phoneCode}',
                  );
                },
                child: Text('Country code : ${countryCode.value}'),
              ),

              //
              ElevatedButton(
                onPressed: () {
                  ref.read(authProvider.notifier).phoneLogin(
                        context,
                        '${countryCode.value}${phoneController.text}',
                      );
                },
                child: Text('Phone Login'),
              ),

              //
              ElevatedButton(
                onPressed: () async {
                  ref.read(authProvider.notifier).anonymousLogin();
                },
                child: const Text('Guest'),
              ),
              ElevatedButton(
                onPressed: () async {
                  ref.read(authProvider.notifier).loginWithGoogle();
                },
                child: const GoogleButton(),
              ),
              ElevatedButton(
                onPressed: () async {
                  ref.read(authProvider.notifier).loginWithFacebook();
                },
                child: const FacebookButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
