// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import '../../models/lib/chat.pb.dart';
import '../providers/contacts.dart';

part 'api_test.g.dart';

@riverpod
FutureOr<String> futuresayHello(FuturesayHelloRef ref) async {
  final allUser = await FirebaseFunctions.instance.httpsCallable('sayHello').call(
    {'Hello': 5},
  );
  return allUser.data.toString();
}

@riverpod
class FunctionCall extends _$FunctionCall {
  @override
  Future<String> build() async {
    return 'No Data';
  }

  void allUsers() async {
    _function('allUsers');
  }

  void delAllUsers() async {
    _function('delAllUsers');
  }

  void sayHello() async {
    _function('sayHello');
  }

  void _function(String name) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final allUser = await FirebaseFunctions.instance.httpsCallable(name).call(
        {'Hello': 5},
      );
      log(allUser.data.toString());
      try {
        for (var e in (allUser.data as List)) {
          log(e.runtimeType.toString());
          log(e.toString());
          log(json.encode(e));

          log('-------------');

          final hello = User();
          hello.mergeFromProto3Json({
            'rooms': ['Hoopa']
          });
          hello.mergeFromProto3Json({
            'rooms': ['Juniper']
          });
          log(hello.toProto3Json().toString());
          hello.mergeFromProto3Json(e, ignoreUnknownFields: true);
          log(hello.writeToJson());
          log(User.fromJson(hello.writeToJson()).toProto3Json().toString());
          log(hello.toProto3Json().toString());

          // return User.fromJson(hello.writeToJson());
        }
      } catch (error, stacktrace) {
        log('$error, $stacktrace');
      }

      return allUser.data.toString();
    });
  }
}

class SnapRest extends HookConsumerWidget {
  const SnapRest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expandedIndex = useState<int?>(null);

    List<FunctionItem> items = [
      FunctionItem(name: 'All User', caller: (f) => f.allUsers()),
      FunctionItem(name: 'Say Hello', caller: (f) => f.sayHello()),
      FunctionItem(name: 'Delete All Users', caller: (f) => f.delAllUsers()),
    ];

    return Material(
      child: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: const Text('Api'),
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                bottom: const TabBar(
                  tabs: <Widget>[
                    Tab(text: 'Tab 1'),
                    Tab(text: 'Tab 2'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: ExpansionTile(
                      title: Text('Say Hello'),
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            return ref.watch(futuresayHelloProvider).when(
                                  data: (data) {
                                    return Text(data);
                                  },
                                  error: (error, stackTrace) => Text(error.toString()),
                                  loading: () => Text('Loading'),
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(12)),
                        child: ExpansionPanelList(
                          expansionCallback: (panelIndex, isExpanded) {
                            expandedIndex.value = expandedIndex.value == panelIndex ? null : panelIndex;
                            items[panelIndex].caller(ref.read(functionCallProvider.notifier));
                          },
                          children:
                              items.mapIndexed((index, fi) => fi.build(ref, expandedIndex.value == index)).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                ),
                itemCount: 100,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Theme.of(context).primaryColor,
                    margin: const EdgeInsets.all(8),
                    child: Center(child: Text('Item $index')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FunctionItem {
  final String name;
  final void Function(FunctionCall) caller;

  const FunctionItem({
    required this.name,
    required this.caller,
  });

  ExpansionPanel build(WidgetRef ref, bool expanded) {
    final watcher = ref.watch(functionCallProvider);

    return ExpansionPanel(
      canTapOnHeader: true,
      isExpanded: expanded,
      headerBuilder: (context, isExpanded) => ListTile(
        tileColor: Theme.of(context).primaryColor,
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
        child: watcher.when(
          data: (data) => Text(data),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const Text('Loading...'),
        ),
      ),
    );
  }
}
