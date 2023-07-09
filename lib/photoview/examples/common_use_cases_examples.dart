import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../common/app_bar.dart';
import '../common/common_example_wrapper.dart';
import '../common/example_button.dart';

const String largeImageUrl =
    "https://images.pexels.com/photos/1366919/pexels-photo-1366919.jpeg?auto=compress&cs=tinysrgb&w=1600";

const largeImage = NetworkImage(largeImageUrl);

class CommonUseCasesExamples extends StatelessWidget {
  const CommonUseCasesExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return ExampleAppBarLayout(
      title: "Common use cases",
      showGoBack: true,
      child: ListView(
        children: <Widget>[
          ExampleButtonNode(
            title: "Large Image",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommonExampleRouteWrapper(
                    imageProvider: largeImage,
                  ),
                ),
              );
            },
          ),
          ExampleButtonNode(
            title: "Large Image (filter quality: medium)",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommonExampleRouteWrapper(
                    imageProvider: largeImage,
                    filterQuality: FilterQuality.medium,
                  ),
                ),
              );
            },
          ),
          ExampleButtonNode(
            title: "Small Image (custom background)",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommonExampleRouteWrapper(
                    imageProvider: largeImage,
                    backgroundDecoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[Colors.white, Colors.grey],
                        stops: [0.1, 1.0],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          ExampleButtonNode(
            title: "Small Image (custom alignment)",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommonExampleRouteWrapper(
                    imageProvider: largeImage,
                    backgroundDecoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    basePosition: Alignment(0.5, 0.0),
                  ),
                ),
              );
            },
          ),
          ExampleButtonNode(
            title: "Animated GIF",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommonExampleRouteWrapper(
                    imageProvider: largeImage,
                  ),
                ),
              );
            },
          ),
          ExampleButtonNode(
            title: "Limited scale",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommonExampleRouteWrapper(
                    imageProvider: largeImage,
                    minScale: PhotoViewComputedScale.contained * 0.8,
                    maxScale: PhotoViewComputedScale.covered * 1.1,
                    initialScale: PhotoViewComputedScale.covered * 1.1,
                  ),
                ),
              );
            },
          ),
          ExampleButtonNode(
            title: "Custom Initial scale",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommonExampleRouteWrapper(
                    imageProvider: largeImage,
                    initialScale: PhotoViewComputedScale.contained * 0.7,
                  ),
                ),
              );
            },
          ),
          ExampleButtonNode(
            title: "One tap to dismiss",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const OneTapWrapper(
                    imageProvider: largeImage,
                  ),
                ),
              );
            },
          ),
          ExampleButtonNode(
            title: "No gesture ",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommonExampleRouteWrapper(
                    imageProvider: largeImage,
                    disableGestures: true,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class OneTapWrapper extends StatelessWidget {
  const OneTapWrapper({
    super.key,
    required this.imageProvider,
  });

  final ImageProvider imageProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: GestureDetector(
          onTapDown: (_) {
            Navigator.pop(context);
          },
          child: PhotoView(
            imageProvider: imageProvider,
          ),
        ),
      ),
    );
  }
}
