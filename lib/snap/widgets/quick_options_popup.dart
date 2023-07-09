import 'package:flutter/material.dart';

class Language {}

class QuickLanguageContextMenu extends StatefulWidget {
  final Widget child;
  final List<Language> languages;
  final double iconSize;
  final double height = 80.0;
  final void Function(Language)? onLanguageSelect;

  const QuickLanguageContextMenu(
      {Key? key, required this.child, this.onLanguageSelect, required this.languages, this.iconSize = 24.0})
      : super(key: key);

  @override
  State<QuickLanguageContextMenu> createState() => _QuickLanguageContextMenuState();
}

class _QuickLanguageContextMenuState extends State<QuickLanguageContextMenu> {
  Offset _globalPosition = Offset.zero;

  void _getTapPosition(TapDownDetails tapPosition) {
    setState(() {
      _globalPosition = tapPosition.globalPosition;
    });
  }

  void _showContextMenu(BuildContext context) async {
    final RenderObject? overlay = Overlay.of(context).context.findRenderObject();
    final overlaySize = overlay!.paintBounds.size;

    await showMenu(
      context: context,
      position: RelativeRect.fromRect(
        Rect.fromLTWH(_globalPosition.dx, _globalPosition.dy - widget.height, 100, 100),
        Rect.fromLTWH(0, 0, overlaySize.width, overlaySize.height),
      ),
      items: [
        PopupMenuItem(
          padding: EdgeInsets.zero,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List<Widget>.generate(
                widget.languages.length,
                (index) => _languageIconWidget(widget.languages[index]),
              ),
            ),
          ),
        ),
      ],
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white.withOpacity(0.3),
    );
  }

  Widget _languageIconWidget(Language language) {
    var textStyle = Theme.of(context).textTheme.labelSmall;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          children: [
            RichText(
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                WidgetSpan(
                  child: Icon(Icons.flag_outlined, size: widget.iconSize),
                ),
                const TextSpan(text: "\n"),
                TextSpan(text: 'Lang', style: textStyle),
                const TextSpan(text: "\n"),
                TextSpan(text: 'name', style: textStyle),
              ]),
            ),
          ],
        ),
      ),
      onTap: () {
        widget.onLanguageSelect?.call(language);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (position) => {_getTapPosition(position)},
      onLongPress: () => {_showContextMenu(context)},
      onDoubleTap: () => {_showContextMenu(context)},
      child: widget.child,
    );
  }
}
