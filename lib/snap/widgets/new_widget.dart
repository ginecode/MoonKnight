import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Heading', style: Theme.of(context).textTheme.displayMedium),
              Text('Headline', style: Theme.of(context).textTheme.headlineMedium),
              CupertinoSearchTextField(
                // controller: textController,
                placeholder: 'Search',
                // style: Theme.of(context).textTheme.titleMedium,
              ),
              CupertinoTextField.borderless(
                placeholder: 'Borderless',
              ),
              CupertinoTextField(
                placeholder: 'TextFiled',
              ),
              Wrap(
                children: [
                  FilledButton(
                    onPressed: () {},
                    child: Text('Filled'),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(textStyle: CupertinoTheme.of(context).textTheme.textStyle),
                    child: Text('Outlined'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Button'),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text('Button'),
                  ),
                  CupertinoButton.filled(
                    child: Text('Cupertino'),
                    onPressed: () {},
                  ),
                  CupertinoButton(
                    child: Text('Cupertino'),
                    onPressed: () {},
                  ),
                  CupertinoListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: FlutterLogo(),
                    ),
                    // leadingSize: 68,
                    title: Text('Title'),
                  ),
                  ListTile(
                    leading: FlutterLogo(),
                    title: Text('Title', style: CupertinoTheme.of(context).textTheme.textStyle),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
