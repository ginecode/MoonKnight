import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:moonknight/models/lib/chat.pb.dart';
import 'package:moonknight/platform_design/profile_tab.dart';
import 'package:moonknight/snap/proto_help/utils.dart';
import 'package:tamannaah/darkknight/debug_functions.dart';
import 'package:tamannaah/ui/mario/mario_test.dart';
import 'package:tamannaah/darkknight/extensions/extensions.dart';

import '../providers/auth.dart';
import '../providers/contacts.dart';
import '../providers/tweets.dart';
import '../providers/users.dart';
import '../providers/rooms.dart';
import '../providers/router.dart';

class SnapHome extends StatelessWidget {
  const SnapHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Text('Snap'),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(child: Text('Rooms')),
                Tab(child: Text('Contacts')),
                Tab(child: Text('Search')),
                Tab(child: Text('Users')),
                Tab(child: Text('Profile')),
              ],
            ),
          ),
          drawer: NavigationDrawer(
            selectedIndex: null,
            children: [
              NavigationDrawerDestination(
                icon: IconButton(
                  icon: Icon(Icons.add_reaction_outlined),
                  onPressed: () {
                    ApiTestRoute().push(context);
                  },
                ),
                label: Text('Api Test'),
              ),
              NavigationDrawerDestination(
                icon: IconButton(
                  icon: Icon(Icons.add_reaction_outlined),
                  onPressed: () {
                    ProfileRoute().push(context);
                  },
                ),
                label: Text('Profile'),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // SplashRoute().push(context);
              CupertinoTestRoute().push(context);
            },
            tooltip: "fab",
            child: const Icon(Icons.add),
          ),
          body: const TabBarView(
            children: [
              //
              AllRoomsPage(),

              //
              FlutterContactPage(),

              //
              SearchRoomPage(),

              //
              AllUsersPage(),

              //
              ProfilePage(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPro = ref.watch(currentUserProvider);

    return userPro.when(
      data: (user) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  // decoration: BoxDecoration(
                  //   image: DecorationImage(
                  //     image: NetworkImage(user?.avatar ?? 'Avatar'),
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  accountName: Text(user?.nam ?? 'Name'),
                  accountEmail: Text(user?.email ?? 'Email'),
                ),

                //
                const PreferenceCard(
                  header: 'Preference',
                  content: 'content',
                  preferenceChoices: ['1', '2', '3'],
                ),

                //
                ListTile(
                  leading: IconButton(
                    icon: const Icon(Icons.add_reaction_outlined),
                    onPressed: () {
                      ref.read(authProvider.notifier).logOut();
                    },
                  ),
                  title: const Text('Log out'),
                ),

                //
                MarioTest(),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Center(
          child: Column(
            children: [
              Text(error.toString()),
              Text(stackTrace.toString()),
            ],
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class SearchRoomPage extends HookConsumerWidget {
  const SearchRoomPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomCon = useTextEditingController();
    final searchRooms = ref.watch(getRoomProvider);

    return Scaffold(
      body: Column(
        children: [
          TextFormField(
            controller: roomCon,
            decoration: const InputDecoration(
              hintText: 'Find Rooms',
            ),
            onChanged: (text) async {
              ref.read(roomTextProvider.notifier).change(text);
            },
          ),
          Expanded(
            child: searchRooms.map(
              data: (room) {
                if (room.value == null) return const Text('No Room');
                return InkWell(
                  onTap: () {
                    if (room.value != null) {
                      // ref.read(currentRoomProvider.notifier).changeRoom(room.value!, context);
                    }
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Text(room.value?.avatar ?? 'Avatar'),
                        Text(room.value?.nam ?? 'Name'),
                        Text(room.value?.description ?? 'Description'),
                      ],
                    ),
                  ),
                );
              },
              error: (e) => Text(e.toString()),
              loading: (o) => const Text('...Loading'),
            ),
          ),
        ],
      ),
    );
  }
}

class AllRoomsPage extends ConsumerWidget {
  const AllRoomsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allRooms = ref.watch(getAllRoomsProvider);

    return Scaffold(
      body: allRooms.map(
        data: (data) {
          return ListView.builder(
            itemCount: data.value.length,
            itemBuilder: (context, index) {
              final room = data.value[index];
              return ListTile(
                title: Text(room?.id ?? 'Name'),
                subtitle: Text(room?.nam ?? 'Description'),
                trailing: Text(room?.open.toString() ?? 'status'),
                onTap: () async {
                  if (room != null) {
                    // ref.read(currentRoomProvider.notifier).enterRoomById(r.id, context);

                    // final rrr = ref.read(currentRoomProvider).value;
                    // log('------------');
                    // rrr?.log();
                    // log('------------');

                    if (context.mounted /*&& ref.read(isUserIsInRoomProvider)*/) {
                      ChatScreenRoute(room.id).push(context);
                    }
                  }
                },
              );
            },
          );
        },
        error: (e) => Text(e.toString()),
        loading: (o) => const Text('...Loading'),
      ),
    );
  }
}

class AllUsersPage extends ConsumerWidget {
  const AllUsersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allUsers = ref.watch(getAllUsersProvider);
    final currentUser = ref.watch(currentUserProvider).value;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(getAllUsersProvider);
          return 2.sec.delay();
        },
        child: allUsers.map(
          data: (user) {
            return ListView.builder(
              itemCount: user.value.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(user.value[index]?.id ?? 'Id'),
                  subtitle: Text(user.value[index]?.email ?? 'Email'),
                  trailing: Text(user.value[index]?.rooms.length.toString() ?? 'Rooms'),
                  onTap: user.value[index]! == currentUser
                      ? null
                      : () async {
                          final room = await ref.read(currentRoomProvider.notifier).createRoom(
                            roomName: 'Room : ${math.Random().nextInt(100000)}',
                            users: [
                              user.value[index]!,
                            ],
                          );
                          if (context.mounted && room?.id != null && room?.id != '') {
                            ChatScreenRoute(room!.id).go(context);
                          }
                        },
                );
              },
            );
          },
          error: (e) => Text(e.toString()),
          loading: (o) => const Text('...Loading'),
        ),
      ),
    );
  }
}

// TODO : getUserByPhone : (send invitation link) (create room)
class FlutterContactPage extends ConsumerWidget {
  const FlutterContactPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneProvider = ref.watch(phoneContactProvider);

    return phoneProvider.when(
      data: (contacts) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              contacts.length.toString(),
            ),
          ),
          body: ListView.builder(
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  contacts[index].name,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(contacts[index].phone),
              );
            },
          ),
        );
      },
      error: (e, s) => Text(e.toString()),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
