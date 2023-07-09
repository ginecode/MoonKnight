import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moonknight/snap/providers/themes.dart';
import 'package:moonknight/snap/widgets/new_widget.dart';

import '../providers/auth.dart';
import '../providers/loading.dart';
import '../providers/local_cache.dart';
import '../widgets/sliver_nav.dart';

class CupertinoTest extends ConsumerWidget {
  const CupertinoTest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //
    // onionLoad(ref, context);

    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: Theme.of(context).brightness,
        //
        primaryColor: Theme.of(context).primaryColor, //CupertinoColors.systemPurple,
        // primaryContrastingColor: Colors.green,

        // barBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scaffoldBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      child: Scaffold(
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            child: Icon(Icons.add_location_outlined),
            onPressed: () => Scaffold.of(context).openDrawer(), // <-- Opens drawer.
          );
        }),
        appBar: AppBar(
          title: Text('Title', style: Theme.of(context).textTheme.titleMedium),
          centerTitle: true,
          titleSpacing: 0,
          actions: [
            Switch(
              value: true,
              onChanged: null,
            ),
            IconButton(
              icon: Icon(Icons.yard_outlined),
              onPressed: () async {
                // LoadingScreen.instance().show(context: context);
                // Future.delayed(Duration(seconds: 1), () {
                //   LoadingScreen.instance().hide();
                // });

                //
                ref.read(onionProvider.notifier).onionTrue();
              },
            ),
            Builder(
              builder: (context) {
                return IconButton(
                  icon: Icon(Icons.light_outlined),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          width: MediaQuery.of(context).size.width / 2,
          child: Column(
            children: [
              DrawerHeader(
                child: Container(width: 100, height: 100, color: Colors.green, child: const FlutterLogo()),
              ),
              InkWell(
                onTap: () {
                  ref.watch(authProvider.notifier).logOut();
                  // FirebaseAuth.instance.signOut();
                },
                child: Container(
                  // width: double.infinity,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.red,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 10),
                      Icon(Icons.api_outlined, color: Colors.white),
                      Text('Log out'),
                      Spacer(),
                      Icon(Icons.star_border_outlined, color: Colors.white),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  ref.read(localCacheProvider.notifier).clear();
                },
                child: Container(
                  // width: double.infinity,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.red,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.folder, color: Colors.white),
                      SizedBox(width: 10),
                      Text('Clear Cache'),
                      Spacer(),
                      Icon(Icons.star_border_outlined, color: Colors.white),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  // width: double.infinity,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.red,
                      ],
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.folder, color: Colors.white),
                      SizedBox(width: 10),
                      Text('Chat'),
                      Spacer(),
                      Icon(Icons.star_border_outlined, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: NewWidget(),
              ),
            ),
            Expanded(
              child: CupertinoTabScaffold(
                // appBar: AppBar(title: Text('Title')),
                // body: Text('Home Screen'),
                tabBar: CupertinoTabBar(
                  items: [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.wb_sunny_outlined),
                      label: 'Sunny',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.sunny_snowing),
                      label: 'Moony',
                      tooltip: 'Moony',
                    ),
                  ],
                  onTap: (value) {
                    ref.read(globalThemeProvider.notifier).add(value == 0 ? -1 : 1);
                  },
                ),
                tabBuilder: (context, index) {
                  return SliverNavBarExample();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
