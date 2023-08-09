import 'package:flutter/material.dart';
import 'package:moonknight/food_ui/view/start_page/start_page_view.dart';

class FoodOrder extends StatelessWidget {
  const FoodOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const StartPageView(),
    );
  }
}
