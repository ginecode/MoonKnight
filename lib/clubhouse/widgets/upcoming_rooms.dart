import 'package:flutter/material.dart';
import '../data.dart';

import 'package:tamannaah/darkknight/extensions/extensions.dart';

class UpcomingRooms extends StatelessWidget {
  final List<Room> upcomingRooms;

  const UpcomingRooms({
    Key? key,
    required this.upcomingRooms,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.only(left: 32.0, top: 4.0, bottom: 4.0),
      decoration: BoxDecoration(
        color: theme.csSur,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: upcomingRooms
            .map(
              (e) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: e.club.isNotEmpty ? 2.0 : 0),
                      child: Text(
                        e.time,
                        style: theme.ml.w6.ls(1).fc(theme.csSec),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (e.club.isNotEmpty)
                            Flexible(
                              child: Text(
                                '${e.club} 🏠'.toUpperCase(),
                                style: theme.sl.w6.ls(1).fc(theme.csSec),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          Flexible(
                            child: Text(
                              e.name,
                              style: theme.sl.w6.ls(1).fc(theme.csSec),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
