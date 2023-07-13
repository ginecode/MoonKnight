import 'dart:math';

import 'package:tamannaah/darkknight/extensions/extensions.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data.dart';
import '../widgets/widgets.dart';

class RoomScreen extends StatelessWidget {
  final Room room;

  const RoomScreen({
    Key? key,
    required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 120.0,
        leading: TextButton.icon(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(CupertinoIcons.chevron_down),
          label: const Text(
            'All rooms',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.doc, size: 28.0),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 10.0, 20.0, 10.0),
              child: UserProfileImage(imageUrl: currentUser.imageUrl, size: 36.0),
            ),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.theme.csBg,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${room.club} 🏠'.toUpperCase(), style: context.theme.lb.fs(14).w5.ls(1)),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(CupertinoIcons.ellipsis),
                        ),
                      ],
                    ),
                    Text(room.name, style: context.theme.lb.fs(16).bold.ls(1)),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverGrid.count(
                mainAxisSpacing: 20.0,
                crossAxisCount: 3,
                children: room.speakers
                    .map(
                      (e) => RoomUserProfile(
                        imageUrl: e.imageUrl,
                        size: 66.0,
                        name: e.givenName,
                        isNew: Random().nextBool(),
                        isMuted: Random().nextBool(),
                      ),
                    )
                    .toList(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  'Followed by speakers',
                  style: context.theme.lb.bold,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(20.0),
              sliver: SliverGrid.count(
                mainAxisSpacing: 20.0,
                crossAxisCount: 4,
                childAspectRatio: 0.7,
                children: room.followedBySpeakers
                    .map(
                      (e) => RoomUserProfile(
                        imageUrl: e.imageUrl,
                        size: 66.0,
                        name: e.givenName,
                        isNew: Random().nextBool(),
                      ),
                    )
                    .toList(),
              ),
            ),
            const SliverPadding(padding: EdgeInsets.only(bottom: 100.0)),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: (12, 20).e,
        height: 110.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilledButton.tonalIcon(
              // style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey[300])),
              onPressed: context.nav.pop,
              icon: Text('✌🏾', style: TextStyle(fontSize: 20.0)),
              label: Text(
                'Leave quietly',
                style: context.theme.lb.fs(15).fc(context.theme.csErr).w6.ls(1),
              ),
            ),
            Spacer(),
            IconButton.filledTonal(
              padding: 6.e,
              // style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.grey[300])),
              icon: Icon(CupertinoIcons.add, size: 30),
              onPressed: () {},
            ),
            const SizedBox(width: 16.0),
            IconButton.filledTonal(
              padding: 6.e,
              icon: Icon(CupertinoIcons.hand_raised, size: 30),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
