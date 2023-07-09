import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'basic_app2.g.dart';

@riverpod
int snakes(SnakesRef ref) {
  return 32;
}

@riverpod
int rover(RoverRef ref, {int? id}) {
  return id ?? 0;
}

@riverpod
class Count extends _$Count {
  @override
  int build({int? id}) {
    return 0;
  }

  void increment(int add) {
    state = state + add;
  }
}

@riverpod
class CrocoDile extends _$CrocoDile {
  @override
  Stream<int> build() async* {
    yield 0;
    Future.delayed(Duration(seconds: 1));
    yield 71;
    Future.delayed(Duration(seconds: 1));
    yield 3;
  }
}

extension on AutoDisposeRef<Object?> {
  void cacheFor(Duration duration) {
    final keepAliveLink = keepAlive();
    Timer(duration, () {
      keepAliveLink.close();
    });
  }
}

@riverpod
Future<List<String>> fetchItem(
  FetchItemRef ref, {
  required int page,
}) async {
  ref.cacheFor(Duration(minutes: 5));
  if (page > 2) return ['a', 'b'];
  await Future.delayed(const Duration(seconds: 3));
  print('Fetching... $page');
  return List.generate(20, (index) => 'Hello $index $page');
}

class BasicApp2 extends ConsumerWidget {
  const BasicApp2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snakesValue = ref.watch(snakesProvider);
    final countValue1 = ref.watch(countProvider(id: 8));
    final countValue2 = ref.watch(CountProvider(id: 2));
    final roverValue = ref.watch(RoverProvider(id: 17));

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('River'),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Orangutan $countValue1'),
                IconButton(
                  icon: Icon(Icons.add_alarm_rounded),
                  onPressed: () {
                    ref.read(countProvider(id: 8).notifier).increment(5);
                  },
                ),
                Text('Orangutan $countValue2'),
                IconButton(
                  icon: Icon(Icons.add_alarm_rounded),
                  onPressed: () {
                    ref.read(countProvider(id: 2).notifier).increment(5);
                  },
                ),
                Text('$roverValue'),
                Text('$snakesValue'),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (c, i) {
                  final page = i ~/ 20;
                  final itemIndex = i % 20;

                  final pageValue = ref.watch(fetchItemProvider(page: page));

                  return pageValue.when(
                    data: (data) {
                      if (itemIndex >= data.length) return null;
                      return Text(data[itemIndex]);
                    },
                    error: (error, stackTrace) {
                      return Text('$error');
                    },
                    loading: () {
                      if (itemIndex != 0) return null;
                      return LinearProgressIndicator();
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
