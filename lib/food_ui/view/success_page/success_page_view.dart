import 'package:flutter/material.dart';
import 'package:moonknight/food_ui/view/home_page/components/size_config.dart';
import 'package:moonknight/food_ui/view/success_page/widgets/lottie_widget.dart';
import 'package:moonknight/food_ui/view/success_page/widgets/ok_button.dart';
import 'package:moonknight/food_ui/view/success_page/widgets/router_text.dart';

class CheckCart extends StatelessWidget {
  const CheckCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        LottieWidget(),
        RouterText(),
        SizedBox(
          height: SizeConfig.screenHeight! / 68.3,
        ),
        OkButton(),
      ]),
    );
  }
}
