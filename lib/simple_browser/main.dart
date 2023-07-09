import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonknight/simple_browser/resources/strings_manager.dart';
import 'package:moonknight/simple_browser/screens/home.dart';

void main() {
  runApp(const ProviderScope(child: BrowserApp()));
}

class BrowserApp extends StatelessWidget {
  const BrowserApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData.dark(),
      home: const Home(),
    );
  }
}
