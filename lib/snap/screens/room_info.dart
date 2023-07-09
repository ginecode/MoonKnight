import 'dart:developer';

import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moonknight/snap/providers/rooms.dart';
import 'package:moonknight/snap/providers/users.dart';
import 'package:tamannaah/darkknight/extensions/extensions.dart';
import 'package:tamannaah/ui/mario/mario.dart';

import 'package:moonknight/models/lib/chat.pb.dart';
import '../widgets/fire_image.dart';

class RoomInfo extends StatefulHookConsumerWidget {
  const RoomInfo(this.id, {super.key});

  final String id;

  @override
  ConsumerState<RoomInfo> createState() => _RoomInfoState();
}

class _RoomInfoState extends ConsumerState<RoomInfo> {
  @override
  Widget build(BuildContext context) {
    final roomProvider = ref.watch(currentRoomProvider);
    final me = ref.watch(currentRoomUserProvider)!;

    final scrollCon = useScrollController();
    final scrollPer = useState(0.0);

    useEffect(() {
      void scrollUpdate() {
        scrollPer.value = math.min(
          1,
          math.max(
            0,
            (1 - scrollCon.offset / (200 - 80)),
          ),
        );
        // setState(() {});
      }

      scrollCon.addListener(scrollUpdate);

      log('Use Effect');

      return () {
        scrollCon.removeListener(scrollUpdate);
        // scrollCon.dispose();
      };
    }, [scrollCon]);

    // return WhatsAppFab();
    // return WhatsappProfilePage();
    // return GmailComposeButton();
    // return WhatsAppAppbar();
    // return Sliver2();
    // return SliverTab1();

    return roomProvider.when(
      data: (room) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            body: CustomScrollView(
              controller: scrollCon,

              //
              physics: BouncingScrollPhysics(),

              //
              slivers: [
                SliverAppBar(
                  expandedHeight: 200,
                  // flexibleSpace: Image.network(
                  //   'https://vedicfeed.com/wp-content/uploads/2019/08/satyabhama-killing-narakasura.jpg',
                  //   fit: BoxFit.cover,
                  // ),

                  primary: true,

                  backgroundColor: context.theme.pri,
                  collapsedHeight: 80,
                  shadowColor: Colors.yellow,

                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: [
                      StretchMode.fadeTitle,
                      StretchMode.zoomBackground,
                      StretchMode.blurBackground,
                    ],
                    background: Container(
                      foregroundDecoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.blue.withOpacity(0.4),
                            Colors.purple.withOpacity(0.0),
                          ],
                        ),

                        color: Colors.blue,

                        // backgroundBlendMode: BlendMode.color,

                        //
                        // image: DecorationImage(
                        //   image: NetworkImage(
                        //     'https://vedicfeed.com/wp-content/uploads/2019/08/satyabhama-killing-narakasura.jpg',
                        //   ),
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Image.network(
                              'https://vedicfeed.com/wp-content/uploads/2019/08/satyabhama-killing-narakasura.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                          if (scrollCon.hasClients)
                            Positioned(
                              left: context.mq.w * 0.5 * scrollPer.value,
                              top: 100 * scrollPer.value,
                              child: Container(
                                width: 50 * scrollPer.value,
                                height: 50 * scrollPer.value,
                                color: Colors.white,
                                child: Text(scrollPer.value.toStringAsFixed(2)),
                              ),
                            ),
                        ],
                      ),
                    ),

                    //
                    centerTitle: true,
                    title: Text('_${room?.id}'),
                  ),

                  // bottom: PreferredSize(
                  //   preferredSize: Size.fromHeight(4.0),
                  //   child: Opacity(
                  //     opacity: 1,
                  //     child: Container(
                  //       height: 40.0,
                  //       color: Colors.blue,
                  //     ),
                  //   ),
                  // ),

                  // bottom: TabBar(
                  //   // labelColor: Colors.red,
                  //   dividerColor: Colors.yellow,
                  //   indicatorColor: Colors.blue,
                  //   unselectedLabelColor: Colors.cyan,
                  //   indicator: BoxDecoration(
                  //     border: Border.all(),
                  //   ),
                  //   // indicatorPadding: 8.e,
                  //   indicatorSize: TabBarIndicatorSize.label,
                  //   tabs: [
                  //     Tab(
                  //       text: 'Hello',
                  //     ),
                  //     Tab(
                  //       text: 'Hello',
                  //     ),
                  //   ],
                  // ),

                  //
                  actions: [
                    IconButton(
                      icon: Icon(Icons.exit_to_app),
                      onPressed: () {},
                    ),
                  ],

                  //
                  snap: true,
                  pinned: true,
                  floating: true,

                  //
                  surfaceTintColor: Colors.red,
                  foregroundColor: context.theme.csBg,

                  //
                  title: Text(room?.id ?? 'Room name', style: 15.ts),
                ),
                SliverToBoxAdapter(
                  child: TextButton(
                    child: Text('update room'),
                    onPressed: () {
                      if (room?.id != null) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return RoomUpdateDialog(room!.id);
                          },
                        );
                      }
                    },
                  ),
                ),
                SliverPadding(
                  padding: (16, 4, 16, 4).e,
                  sliver: SliverToBoxAdapter(
                    child: Text('Members', style: 20.ts.c(context.theme.csOnBg).bold),
                  ),
                ),
                SliverList.builder(
                  itemCount: room?.members.length ?? 0,
                  itemBuilder: (context, index) {
                    //
                    return Consumer(
                      builder: (context, ref, child) {
                        final memberProvider = ref.watch(
                          GetUserByIdProvider(room!.members[index].id),
                        );
                        return memberProvider.when(
                          data: (member) {
                            return ListTile(
                              tileColor: me.id == room.members[index].id ? context.theme.pri : null,
                              onLongPress: (me.isAdminOrMod &&
                                      me.id != room.members[index].id &&
                                      room.members[index].role.value <= Role.USER.value)
                                  ? () async {
                                      // if (await showYesNo(
                                      //   context,
                                      //   title: 'Kick user out',
                                      //   content: '',
                                      // )) {
                                      //   ref.read(currentRoomProvider.notifier).kickUser(room.members[index]);
                                      // }
                                    }
                                  : null,
                              leading: ClipRRect(
                                borderRadius: 30.br,
                                child: Image.network(
                                  '${member?.avatar}',
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(Icons.person);
                                  },
                                ),
                              ),
                              title: Text('${member?.nam}'),
                              subtitle: Text('${member?.email ?? member?.phone}'),
                              trailing: ((me.isAdminOrMod) && room.members[index].isRequest)
                                  ? ElevatedButton(
                                      onPressed: () {
                                        ref.read(currentRoomProvider.notifier).changeRole(
                                              room.members[index],
                                              Role.USER,
                                            );
                                      },
                                      child: Text(room.members[index].role.name),
                                    )
                                  : Text(room.members[index].role.name),
                            );
                          },
                          error: (error, stackTrace) => Text('Error'),
                          loading: () => ListTile(
                            leading: CircularProgressIndicator(),
                            title: Text('${room.members[index].id}'),
                            trailing: Text('${room.members[index].role.name}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
      error: (error, stackTrace) {
        return Text(error.toString());
      },
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
      },
    );
  }
}

//TODO : Delete Room
//TODO : Update Room
//TODO : Update profile pic
class RoomUpdateDialog extends HookConsumerWidget {
  final String id;

  const RoomUpdateDialog(this.id, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.read(currentRoomProvider).value;

    final roomNameCon = useTextEditingController(text: room?.nam);
    final roomDescriptionCon = useTextEditingController(text: room?.description);
    final roomOpen = useState(room?.open);
    final roomAvatar = useState(room?.avatar);

    final formKey = useState(GlobalKey<FormState>());

    return Form(
      key: formKey.value,
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FireImage(
                  location: '${room?.id}/avatar',
                  imageUrl: '${room?.avatar}',
                  function: (url) {
                    roomAvatar.value = url;
                  },
                ),
                Text('Change room name', style: 20.ts.c(context.theme.csOnBg).bold),
                TextFormField(
                  controller: roomNameCon,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                Text('Change room Description', style: 20.ts.c(context.theme.csOnBg).bold),
                TextFormField(
                  controller: roomDescriptionCon,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Description',
                  ),
                ),
                CheckboxListTile(
                  value: roomOpen.value == Visible.CLOSE,
                  tristate: true,
                  onChanged: (bool? value) {
                    roomOpen.value =
                        (value == true) ? Visible.OPEN : (value == false ? Visible.CLOSE : Visible.MODERATED);
                  },
                ),
                TextButton(
                  child: const Text('Save'),
                  onPressed: () {
                    if (formKey.value.currentState?.validate() ?? false) {
                      log({
                        Const.avatar.name: roomAvatar.value,
                        Const.open.name: roomOpen.value,
                        Const.description.name: roomDescriptionCon.text,
                        'name': roomNameCon.text,
                      }.toString());
                      // ref.read(updateRoomInfoProvider.notifier).updateRoom();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
