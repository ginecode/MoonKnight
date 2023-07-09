import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'new_widget.dart';

class SliverNavBarExample extends StatelessWidget {
  const SliverNavBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        padding: EdgeInsetsDirectional.zero,
        trailing: IconButton(
          icon: Icon(Icons.yard_outlined),
          onPressed: () {
            // Supabase.instance.client.auth.signOut();
          },
        ),
        middle: Text('Title', style: Theme.of(context).textTheme.titleMedium),
        leading: IconButton(
          icon: Icon(Icons.yard_outlined),
          onPressed: () {
            // Supabase.instance.client.auth.signOut();
          },
        ),
      ),
      // A ScrollView that creates custom scroll effects using slivers.
      child: SafeArea(
        child: CustomScrollView(
          // A list of sliver widgets.
          slivers: <Widget>[
            const CupertinoSliverNavigationBar(
              leading: Icon(CupertinoIcons.person_2),
              // This title is visible in both collapsed and expanded states.
              // When the "middle" parameter is omitted, the widget provided
              // in the "largeTitle" parameter is used instead in the collapsed state.
              largeTitle: Text('Contacts'),
              trailing: Icon(CupertinoIcons.add_circled),
            ),
            SliverSafeArea(
              top: false,
              minimum: const EdgeInsets.only(top: 4),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    switch (index) {
                      case 0:
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: CupertinoTextField(
                            prefix: const Icon(
                              CupertinoIcons.person_solid,
                              color: CupertinoColors.lightBackgroundGray,
                              size: 28,
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
                            clearButtonMode: OverlayVisibilityMode.editing,
                            textCapitalization: TextCapitalization.words,
                            autocorrect: false,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: 0,
                                  color: CupertinoColors.inactiveGray,
                                ),
                              ),
                            ),
                            placeholder: 'Name',
                            onChanged: (newName) {},
                          ),
                        );
                      case 1:
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const <Widget>[
                                      Icon(
                                        CupertinoIcons.clock,
                                        color: CupertinoColors.lightBackgroundGray,
                                        size: 28,
                                      ),
                                      SizedBox(width: 6),
                                      Text(
                                        'Delivery time',
                                        // style: Styles.deliveryTimeLabel,
                                      ),
                                    ],
                                  ),
                                  Text('Date'
                                      // DateFormat.yMMMd().add_jm().format(dateTime),
                                      // style: Styles.deliveryTime,
                                      ),
                                ],
                              ),
                              SizedBox(
                                height: 216,
                                child: CupertinoDatePicker(
                                  mode: CupertinoDatePickerMode.dateAndTime,
                                  // initialDateTime: dateTime,
                                  onDateTimeChanged: (newDateTime) {
                                    // setState(() {
                                    //   dateTime = newDateTime;
                                    // });
                                  },
                                ),
                              ),
                            ],
                          ),
                        );

                      default:
                        if (index < 5)
                          return CupertinoListTile(
                            title: Text('Title : $index'),
                          );
                        if (index == 5)
                          return CupertinoListTile(
                            title: Text('Total : $index'),
                          );
                    }
                    return null;
                  },
                ),
              ),
            ),

            SliverSafeArea(
              // ADD from here...
              top: false,
              minimum: const EdgeInsets.only(top: 0),
              sliver: SliverToBoxAdapter(
                child: CupertinoListSection(
                  topMargin: 0,
                  children: [
                    CupertinoListTile.notched(title: Text('Hello')),
                    CupertinoListTile.notched(title: Text('Hello')),
                    CupertinoListTile.notched(title: Text('Hello')),
                  ],
                ),
              ),
            ),
            // This widget fills the remaining space in the viewport.
            // Drag the scrollable area to collapse the CupertinoSliverNavigationBar.
            SliverToBoxAdapter(
              child: NewWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
