// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamannaah/darkknight/extensions/extensions.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tamannaah/forms/sherlock.dart';

import 'data.dart';
import 'widgets/room_card.dart';
import 'widgets/upcoming_rooms.dart';

void clubhouse() {
  runApp(const SuperPreview());
}

class SuperPreview extends StatefulWidget {
  const SuperPreview({super.key});

  @override
  State<SuperPreview> createState() => _SuperPreviewState();
}

class _SuperPreviewState extends State<SuperPreview> {
  int numberOfScreen = 1;
  double debugGrid = 0;
  List<String> previewLink = [];
  int? previewIndex;

  @override
  Widget build(BuildContext context) {
    if (numberOfScreen == 0) return ClubhouseApp(ThemeMode.light);

    return MaterialApp(
      theme: ThemeData.dark(useMaterial3: true),
      // debugShowMaterialGrid: debugShowMaterialGrid,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Preview'),
          actions: [
            SizedBox(width: 250, child: const Sherlock()),
            SizedBox(
              width: 250,
              child: Autocomplete<String>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text == '') {
                    return previewLink;
                  }
                  return previewLink.where(
                    (String option) {
                      return option.contains(textEditingValue.text.toLowerCase());
                    },
                  );
                },
                fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) {
                  return TextField(
                    decoration: InputDecoration(
                      label: Text('Preview image link'),
                      labelStyle: 17.ts.c(Colors.yellow).w4,
                      border: 1.bs.c(Colors.deepPurple).out,
                      isDense: true,
                      suffixIcon: IconButton(
                        icon: Icon(CupertinoIcons.cloud_bolt),
                        onPressed: () {
                          textEditingController.clear();
                        },
                      ),
                    ),
                    controller: textEditingController,
                    focusNode: focusNode,
                    // onSubmitted: onFieldSubmitted,
                    onSubmitted: (v) {
                      if (!v.contains('http')) return;
                      setState(() {
                        previewLink.add(v);
                        previewIndex = previewLink.length - 1;
                      });
                      onFieldSubmitted();
                    },
                  );
                },
                onSelected: (String selection) {
                  setState(() {
                    previewIndex = previewLink.indexOf(selection);
                  });
                },
              ),
            ),
            Slider(
              value: debugGrid / 200,
              onChanged: (v) {
                setState(() {
                  debugGrid = v * 200;
                });
              },
            ),
            SizedBox(width: 10),
            IconButton.filledTonal(
              icon: Text('0'),
              onPressed: () {
                setState(() {
                  numberOfScreen = 0;
                });
              },
            ),
            SizedBox(width: 10),
            IconButton.filledTonal(
              icon: Text('1'),
              onPressed: () {
                setState(() {
                  numberOfScreen = 1;
                });
              },
            ),
            SizedBox(width: 10),
            IconButton.filledTonal(
              icon: Text('2'),
              onPressed: () {
                setState(() {
                  numberOfScreen = 2;
                });
              },
            ),
            SizedBox(width: 10),
            IconButton.filledTonal(
              icon: Text('3'),
              onPressed: () {
                setState(() {
                  numberOfScreen = 3;
                });
              },
            ),
            SizedBox(width: 10),
          ],
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: () {
                if (numberOfScreen == 1)
                  return DevicePreview(
                    enabled: true,
                    builder: (context) => const ProviderScope(
                      child: ClubhouseApp(ThemeMode.light),
                    ),
                  );
                if (numberOfScreen == 2)
                  return Row(
                    children: [
                      Expanded(
                        child: DevicePreview(
                          enabled: true,
                          builder: (context) => const ProviderScope(
                            child: ClubhouseApp(ThemeMode.light),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InteractiveViewer(
                          maxScale: 2,
                          child: AspectRatio(
                            aspectRatio: .55,
                            child: Image.network(
                              previewIndex != null ? previewLink[previewIndex!] : '',
                              errorBuilder: (context, error, stackTrace) => Center(child: Text('No Image')),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: DevicePreview(
                          enabled: true,
                          builder: (context) => const ProviderScope(
                            child: ClubhouseApp(ThemeMode.dark),
                          ),
                        ),
                      ),
                    ],
                  );

                if (numberOfScreen == 3)
                  return Row(
                    children: [
                      Expanded(
                        child: DevicePreview(
                          enabled: true,
                          builder: (context) => const ProviderScope(
                            child: ClubhouseApp(ThemeMode.light),
                          ),
                        ),
                      ),
                      Expanded(
                        child: DevicePreview(
                          enabled: true,
                          builder: (context) => const ProviderScope(
                            child: ClubhouseApp(ThemeMode.dark),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: DevicePreview(
                          enabled: true,
                          builder: (context) => const ProviderScope(
                            child: ClubhouseApp(ThemeMode.light),
                          ),
                        ),
                      ),
                    ],
                  );

                return Text('Empty');
              }(),
            ),
            if (debugGrid != 0)
              Positioned.fill(
                child: GridPaper(
                  color: Colors.black,
                  divisions: 1,
                  interval: debugGrid.toInt().toDouble(),
                  subdivisions: 1,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class ClubhouseApp extends StatefulHookConsumerWidget {
  const ClubhouseApp(this.themeMode, {super.key});

  final ThemeMode themeMode;

  @override
  ConsumerState<ClubhouseApp> createState() => _ClubhouseAppState();
}

class _ClubhouseAppState extends ConsumerState<ClubhouseApp> {
  bool showButton = true;

  @override
  Widget build(BuildContext context) {
    // debugPaintSizeEnabled = true;
    // debugRepaintRainbowEnabled = true;

    final controller = useScrollController();

    void scrollListener() {
      if (!showButton && controller.offset < 100) {
        setState(() {
          showButton = true;
        });
      }
      if (showButton && controller.offset > 100) {
        setState(() {
          showButton = false;
        });
      }
      setState(() {});
      print(showButton);
    }

    useEffect(() {
      controller.addListener(scrollListener);

      return () {
        controller.removeListener(scrollListener);
        controller.dispose();
      };
    }, [controller]);

    return MaterialApp(
      //
      // debugShowMaterialGrid: true,
      debugShowCheckedModeBanner: false,
      // showSemanticsDebugger: true,

      title: 'Clubhouse',

      // themeAnimationDuration: Duration(seconds: 4),

      themeMode: widget.themeMode,

      //
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,

      //
      theme: ThemeData(
        useMaterial3: true,

        brightness: Brightness.light,

        colorSchemeSeed: Colors.purple[700],

        //
        appBarTheme: const AppBarTheme(backgroundColor: Color.fromARGB(255, 238, 238, 238)),
        scaffoldBackgroundColor: const Color.fromARGB(255, 247, 247, 247),
        // iconTheme: const IconThemeData(color: Colors.black),
        // iconButtonTheme: const IconButtonThemeData(
        //   style: ButtonStyle(
        //     iconColor: MaterialStatePropertyAll(Colors.black),
        //   ),
        // ),
        fontFamily: GoogleFonts.montserrat().fontFamily,
        textTheme: GoogleFonts.montserratTextTheme(),

        //
        // floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
        //   backgroundColor: Palette.green,
        //   foregroundColor: Colors.white,
        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        //   // extendedTextStyle: Theme.of(context).textTheme.bodyMedium,
        // ),

        //
      ),
      darkTheme: ThemeData(
        useMaterial3: true,

        brightness: Brightness.dark,

        colorSchemeSeed: Colors.purple[700],

        //
        // appBarTheme: const AppBarTheme(backgroundColor: Palette.background),
        // scaffoldBackgroundColor: Palette.background,
        // iconTheme: const IconThemeData(color: Colors.black),
        // iconButtonTheme: const IconButtonThemeData(
        //   style: ButtonStyle(
        //     iconColor: MaterialStatePropertyAll(Colors.black),
        //   ),
        // ),
        fontFamily: GoogleFonts.montserrat().fontFamily,
        textTheme: GoogleFonts.montserratTextTheme(
          ThemeData.dark().textTheme,
        ),
        //
      ),
      home: Scaffold(
        //
        appBar: AppBar(
          elevation: 0,
          title: Text(showButton.toString()),
          actions: [
            IconButton(
              icon: Icon(CupertinoIcons.mail),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(CupertinoIcons.calendar),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(CupertinoIcons.bell),
              onPressed: () {},
            ),
            IconButton.filledTonal(
              icon: Icon(CupertinoIcons.person),
              onPressed: () {},
            ),
          ],
          leading: IconButton(
            icon: Icon(CupertinoIcons.search),
            onPressed: () {},
          ),
        ),

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              showButton = !showButton;
            });
          },
          // icon: Icon(
          //   Icons.add,
          //   size: 25,
          // ),
          label: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) => FadeTransition(
              opacity: animation,
              child: SizeTransition(
                child: child,
                sizeFactor: animation,
                axis: Axis.horizontal,
              ),
            ),
            child: showButton
                ? Icon(Icons.arrow_upward_outlined)
                : Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 4.0),
                        child: Icon(Icons.add),
                      ),
                      Text(
                        'Start a room',
                        style: TextStyle(
                          // color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

        //
        body: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              controller: controller,
              physics: ClampingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 120.0),
              children: [
                Text(
                  'Find Inspirations',
                  style: context.theme.sh.c(
                    context.theme.csBg,
                  ),
                ),
                15.sz,
                TextField(
                  decoration: InputDecoration(
                    label: Text('Preview image link'),
                    labelStyle: 17.ts.w4,
                    // border: 6.bs.c(Colors.red).out.r(20),
                    // errorBorder: 6.bs.c(Colors.blue).out.r(20),
                    enabledBorder: 1.bs.c(Colors.purple).out.r(10),
                    focusedBorder: 1.bs.c(Colors.lime).out.r(10),

                    // border:
                    // OutlineInputBorder(borderSide: BorderSide(width: 4, color: Colors.red), borderRadius: 29.br),
                    isDense: true,
                    contentPadding: (10, 0).e,
                    prefixIcon: IconButton(
                      icon: Icon(CupertinoIcons.search, size: 32),
                      onPressed: () {},
                    ),
                  ),
                ),
                15.sz,
                UpcomingRooms(upcomingRooms: upcomingRoomsList),
                const SizedBox(height: 12.0),
                ...roomsList.map((e) => RoomCard(room: e)),
              ],
            ),

            //
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 100.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
                      Theme.of(context).scaffoldBackgroundColor,
                    ],
                  ),
                ),
              ),
            ),

            //
            Positioned(
              bottom: 56.0,
              right: 40.0,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.circle_grid_3x3_fill,
                      size: 28.0,
                    ),
                    onPressed: () {},
                  ),
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      height: 12.0,
                      width: 12.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
