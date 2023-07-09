import 'package:flutter/material.dart';

class CustomSliverAppBar extends StatefulWidget {
  @override
  _CustomSliverAppBarState createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  double _appBarHeight = 200.0;
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {
        _appBarHeight = _scrollController.offset <= 0 ? 200.0 : 100.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _CustomSliverAppBarDelegate(
        appBarHeight: _appBarHeight,
      ),
      pinned: true,
      floating: true,
    );
  }
}

class _CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double appBarHeight;

  _CustomSliverAppBarDelegate({required this.appBarHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: appBarHeight,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(shrinkOffset > 0 ? 20.0 : 0.0),
        ),
      ),
      child: Center(
        child: Text(
          'Custom SliverAppBar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => appBarHeight;

  @override
  double get minExtent => 100.0;

  @override
  bool shouldRebuild(_CustomSliverAppBarDelegate oldDelegate) {
    return appBarHeight != oldDelegate.appBarHeight;
  }
}

class CustomScrollHeaderScreen extends StatefulWidget {
  const CustomScrollHeaderScreen({super.key});

  @override
  State<CustomScrollHeaderScreen> createState() => _CustomScrollHeaderScreenState();
}

class _CustomScrollHeaderScreenState extends State<CustomScrollHeaderScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          CustomSliverAppBar(),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(title: Text('Item $index'));
              },
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}
