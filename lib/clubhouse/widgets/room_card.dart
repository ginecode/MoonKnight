import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tamannaah/darkknight/extensions/extensions.dart';

import '../data.dart';
import '../screens/room_screen.dart';
import '../widgets/widgets.dart';

class RoomCard extends StatelessWidget {
  final Room room;

  const RoomCard({
    Key? key,
    required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.nav.rSlidePush(RoomScreen(room: room)),
      child: Padding(
        padding: 4.ev,
        child: Card(
          shape: 20.rRound,
          // color: context.scafBg,
          child: Padding(
            padding: 20.e,
            child: Column(
              crossAxisAlignment: cStart,
              children: [
                Text(
                  '${room.club} 🏠'.toUpperCase(),
                  style: context.theme.sl.w5.ls(1).fs(12),
                ),
                Text(
                  room.name,
                  style: context.theme.lb.fs(15).bold,
                ),
                const SizedBox(height: 12.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 100.0,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 28.0,
                              top: 20.0,
                              child: UserProfileImage(
                                imageUrl: room.speakers[1].imageUrl,
                                size: 48.0,
                              ),
                            ),
                            UserProfileImage(
                              imageUrl: room.speakers[0].imageUrl,
                              size: 48.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: cStart,
                        children: [
                          ...room.speakers.map(
                            (e) => Text(
                              '${e.givenName} ${e.familyName} 💬',
                              style: context.theme.lb.fs(16.0),
                            ),
                          ),
                          Padding(
                            padding: (0, 4, 0, 0).e,
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text:
                                        '${room.speakers.length + room.followedBySpeakers.length + room.others.length} ',
                                  ),
                                  const WidgetSpan(
                                    child: Icon(
                                      CupertinoIcons.person_fill,
                                      size: 18.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  TextSpan(text: ' / ${room.speakers.length} '),
                                  const WidgetSpan(
                                    child: Icon(
                                      CupertinoIcons.chat_bubble_fill,
                                      size: 18.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              style: 15.ts.c(Colors.grey[400] ?? Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
