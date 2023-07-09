import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moonknight/snap/proto_help/utils.dart';
import 'package:photo_view/photo_view.dart';
import 'package:moonknight/models/lib/chat.pb.dart';
import 'package:moonknight/snap/providers/tweets.dart';
import 'package:moonknight/snap/screens/room_info.dart';
import 'package:moonknight/snap/widgets/fire_image.dart';
import 'package:tamannaah/darkknight/debug_functions.dart';
import 'package:tamannaah/darkknight/extensions/datetime.dart';
import 'package:tamannaah/darkknight/extensions/extensions.dart';

import 'package:flutter_chat_types/flutter_chat_types.dart' show PreviewData;

import 'package:barcode_widget/barcode_widget.dart';
import 'package:tamannaah/darkknight/extensions/regex.dart';

import '../providers/auth.dart';
import '../providers/rooms.dart';
import '../providers/users.dart';
import 'barcode.dart';

class ChatScreen extends StatefulHookConsumerWidget {
  const ChatScreen({super.key, required this.id});

  final String id;

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  void initState() {
    ref.read(currentRoomProvider.notifier).updateRoom(id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scrollCon = useScrollController();

    final roomPro = ref.watch(roomStreamProvider);
    final me = ref.read(currentUserProvider);

    final tweetList = ref.watch(tweetListProvider);

    // return PhotoviewScreen();

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: roomPro.when(
        data: (room) {
          if (room == null) {
            return Scaffold(
              appBar: AppBar(),
              body: const Center(child: Text('Chat Screen Loading...')),
            );
          }

          final roomName = room.members.length == 2
              ? ref.read(GetUserByIdProvider(room.members.where((u) => u.id != me.value?.id).first.id)).value?.id
              : room.nam;

          return WillPopScope(
            onWillPop: () async {
              ref.read(currentRoomProvider.notifier).exitRoom();
              return true;
            },
            child: Scaffold(
              //
              appBar: AppBar(
                title: ListTile(
                  title: Text(roomName ?? 'Room / Friend'),
                  subtitle: Text('Members : ${room.members.length}'),
                  onTap: () {
                    context.bSlidePush(RoomInfo(room.id));
                  },
                ),
                centerTitle: true,
                actions: [
                  //
                  IconButton.filled(
                    onPressed: () {},
                    icon: Text(room.tweetCount.toString()),
                  ),
                  //
                  IconButton.filledTonal(
                    onPressed: () {
                      setState(() {});
                    },
                    icon: const Icon(Icons.add_reaction_outlined),
                  ),
                ],
              ),

              //
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        controller: scrollCon,
                        reverse: true,
                        itemCount: tweetList.length + 1,
                        itemBuilder: (context, index) {
                          //
                          if (tweetList.isEmpty) {
                            return const SizedBox(
                              height: 200,
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                ),
                              ),
                            );
                          }

                          //
                          if (tweetList.length == index && tweetList.length < room.tweetCount) {
                            return Consumer(
                              builder: (context, ref, child) {
                                log('Fetch 10 Tweets : Circular Progress Indicator');
                                ref.read(tweetListProvider.notifier).fetch10Tweets();
                                return const SizedBox(
                                  height: 100,
                                  child: Center(
                                    child: CircularProgressIndicator(color: Colors.green),
                                  ),
                                );
                              },
                            );
                          }

                          //
                          if (index > tweetList.length - 1) {
                            return null;
                          }

                          final tweet = tweetList[index];

                          if (tweet == null) return null;

                          //
                          return TweetBox(
                            me: me.value!,
                            tweet: tweet,
                          );
                        },
                      ),
                    ),

                    //
                    if (me.value != null)
                      SendBox(
                        me: me.value!,
                      ),
                  ],
                ),
              ),
            ),
          );
        },
        error: (e, s) => Scaffold(
          body: ListView(
            children: [
              Text(e.toString()),
              Text(s.toString()),
            ],
          ),
        ),
        loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
    );
  }
}

//TODO : Click on Photo to open photoview dialog
//TODO : Display photoview with textformfield
class PhotoDialog extends StatelessWidget {
  const PhotoDialog({
    super.key,
    required this.imageUrl,
    required this.ref,
    required this.me,
    // required this.scrollCon,
  });

  final String imageUrl;
  final WidgetRef ref;
  final User me;
  // final ScrollController scrollCon;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ClipRRect(
        borderRadius: 25.br,
        child: Scaffold(
          // appBar: AppBar(
          //   title: Text('Send Image'),
          // ),
          body: Stack(
            children: [
              ClipRRect(
                child: Container(
                  constraints: BoxConstraints.expand(
                    height: MediaQuery.of(context).size.height,
                  ),
                  child: PhotoView(
                    imageProvider: NetworkImage(imageUrl),
                    // tightMode: true,
                    // maxScale: PhotoViewComputedScale.covered * 2.0,
                    // minScale: PhotoViewComputedScale.contained * 0.8,
                    initialScale: PhotoViewComputedScale.covered,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black,
                    ],
                    stops: [0.7, 1],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SendBox(
                    me: me,
                    link: imageUrl,
                    mediaType: MediaType.IMAGE,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QrDialog extends HookWidget {
  const QrDialog({
    super.key,
    required this.me,
  });

  final User me;

  @override
  Widget build(BuildContext context) {
    final qrtext = useState('');

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Qr'),
          bottom: TabBar.secondary(
            tabs: [
              Tab(text: 'Generate'),
              Tab(text: 'Scan'),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TabBarView(
            children: [
              //
              SingleChildScrollView(
                child: Column(
                  children: [
                    //
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        if (qrtext.value.isEmpty)
                          const SizedBox(
                            height: 300,
                            width: 300,
                            child: Center(
                              child: Text('Generate qr code'),
                            ),
                          ),
                        if (qrtext.value.isNotEmpty)
                          QrBox(
                            qrtext: qrtext.value,
                          ),

                        // Icon(Icons.heart_broken_rounded),

                        // Container(
                        //   color: Colors.white,
                        //   width: 60,
                        //   height: 60,
                        //   child: const FlutterLogo(),
                        // ),
                      ],
                    ),

                    //
                    Container(
                      height: 40,
                      child: Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              child: Center(
                                child: Text('Hello'),
                              ),
                              onTap: () {
                                //
                              },
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              child: Center(
                                child: Text('Send'),
                              ),
                              onTap: () {
                                //
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    //
                    Divider(),

                    //
                    SendBox(
                      me: me,
                      onChanged: (value) {
                        qrtext.value = value;
                      },
                      mediaType: MediaType.QR,
                    ),
                  ],
                ),
              ),

              //
              BarcodeScannerView(),
              // SingleChildScrollView(
              //   child: Column(
              //     children: [
              //       //
              //       GestureDetector(
              //         onTap: () {},
              //         child: AspectRatio(
              //           aspectRatio: 1,
              //           child: FittedBox(
              //             fit: BoxFit.fill,
              //             child: Icon(Icons.qr_code_rounded),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class QrBox extends StatelessWidget {
  const QrBox({
    super.key,
    required this.qrtext,
  });

  final String qrtext;

  @override
  Widget build(BuildContext context) {
    double size = (qrtext.length > 1250 ? 2 : qrtext.length ~/ 500) * 100 + 200;

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BarcodeWidget(
        barcode: Barcode.qrCode(
          errorCorrectLevel: BarcodeQRCorrectionLevel.high,
        ),
        padding: const EdgeInsets.all(16),
        // margin: EdgeInsets.all(4),
        errorBuilder: (context, error) => Center(
          child: Text(
            error,
            style: TextStyle(color: Colors.red),
          ),
        ),
        data: qrtext,
        width: size,
        height: size,
        // decoration: BoxDecoration(
        //   border: Border.all(
        //     color: Colors.yellow,
        //     width: 3,
        //   ),
        // ),
        color: Colors.black,
        backgroundColor: Colors.white,
      ),
    );
  }
}

class SendBox extends HookConsumerWidget {
  const SendBox({
    required this.me,
    this.mediaType = MediaType.TEXT,
    this.link,
    this.onChanged,
    super.key,
  });

  final User me;
  final MediaType mediaType;
  final String? link;
  final Function(String value)? onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tweetCon = useTextEditingController();

    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: tweetCon,
        minLines: 1,
        // expands: true,
        maxLines: mediaType == MediaType.QR ? 25 : 3,
        onChanged: onChanged,

        decoration: InputDecoration(
          hintText: 'Type...',
          enabledBorder: 1.bs.out.r(30),
          focusedBorder: 1.bs.out.r(30),
          fillColor: theme.pri.withAlpha(20),
          filled: true,
          contentPadding: 16.e,
          prefixIcon: Icon(Icons.star),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.qr_code_rounded),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return QrDialog(
                        me: me,
                      );
                    },
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.tag),
                onPressed: () async {
                  final userId = me.id;
                  log('Hello');
                  final imageTask = await saveFirePickCropImage(
                    '$userId/tweets',
                  );
                  imageTask?.streamSnap().map((event) async {
                    final t = await event;
                    dino('__________');
                    dino(t);
                    dino('__________');
                  });

                  imageTask?.streamPrint();

                  imageTask?.streamIt().map((event) async {
                    final t = await event;
                    lava('__________');
                    lava(t);
                    lava('__________');
                  });
                  imageTask?.onError(
                    (error, stackTrace) => lava(error),
                  );
                  final imageUrl = await imageTask?.then(
                    (p0) => p0.ref.getDownloadURL(),
                  );
                  log(imageUrl.toString());

                  if (imageUrl != null && context.mounted) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return PhotoDialog(
                          imageUrl: imageUrl,
                          ref: ref,
                          me: me,
                          // scrollCon: scrollCon,
                        );
                      },
                    );
                  }
                },
              ),
              // IconButton(
              //   icon: const Icon(Icons.tag),
              //   onPressed: () async {
              //     final userId = me.id;
              //     log('Hello');
              //     final multiTask = await saveFireMedia(
              //       '$userId/tweets',
              //     );
              //     final multiUrl = await multiTask?.then(
              //       (p0) => p0.ref.getDownloadURL(),
              //     );
              //     // log(imageUrl.toString());

              //     // if (imageUrl != null && context.mounted) {
              //     //   showDialog(
              //     //     context: context,
              //     //     builder: (context) {
              //     //       return PhotoDialog(
              //     //         imageUrl: imageUrl,
              //     //         ref: ref,
              //     //         me: me,
              //     //         // scrollCon: scrollCon,
              //     //       );
              //     //     },
              //     //   );
              //     // }
              //   },
              // ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  if (tweetCon.text.isNotEmpty) {
                    //
                    ref.read(tweetListProvider.notifier).sendTweet(
                          text: tweetCon.text,
                          type: mediaType,
                          link: link,
                        );

                    //
                    log(tweetCon.text);
                    tweetCon.clear();
                    FocusManager.instance.primaryFocus?.unfocus();

                    // scrollCon.jumpTo(
                    //   scrollCon.position.minScrollExtent,
                    // );

                    if (mediaType != MediaType.TEXT) {
                      context.pop();
                    }
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FireChat extends HookConsumerWidget {
  const FireChat({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final room = ref.watch(roomStreamProvider).value;

    final me = ref.read(currentUserProvider).value;

    final meInRoom = ref.read(isUserIsInRoomProvider);

    useEffect(() {
      ref
          .read(
            currentRoomProvider.notifier,
          )
          .updateRoom(
            id: roomId,
          );

      lava('Use effect : $roomId');

      return null;
    }, [room]);

    dino(room);

    Query<Tweet?>? query = room?.tweetCol?.orderBy(
      Const.created.name,
      descending: true,
    );

    if (query == null || room == null) {
      return const Scaffold(
        body: Center(
          child: Text('Loading room'),
        ),
      );
    }

    if (!meInRoom && room.open != Visible.OPEN) {
      return WillPopScope(
        onWillPop: () async {
          ref.read(currentRoomProvider.notifier).exitRoom();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Me in room : $meInRoom'),
                Text(me?.id ?? 'Id'),
                Text(beautifyMap(room.toMap()).toString()),
                if (room.open == Visible.MODERATED &&
                    !room.members
                        .map(
                          (e) => e.id,
                        )
                        .contains(me?.id))
                  FilledButton(
                    onPressed: () {
                      ref.read(currentRoomProvider.notifier).requestMemberToRoom(
                        [
                          me!.id,
                        ],
                      );
                    },
                    child: const Text('Send Request'),
                  ),
                if (room.members
                    .map(
                      (e) => e.id,
                    )
                    .contains(me?.id))
                  const Text('Request Sent'),
              ],
            ),
          ),
        ),
      );
    }

    final roomName = room.members.length == 2
        ? ref.read(GetUserByIdProvider(room.members.where((u) => u.id != me?.id).first.id)).value?.id
        : room.nam;

    return WillPopScope(
      onWillPop: () async {
        ref.read(currentRoomProvider.notifier).exitRoom();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: ListTile(
            title: Text(roomName ?? 'Room / Friend'),
            subtitle: Text('Members : ${room.members.length}'),
            onTap: () {
              context.bSlidePush(RoomInfo(room.id));
            },
          ),
          centerTitle: true,
          actions: [
            Text(
              room.members.where((element) => element.id == me?.id).firstOrNull?.role.name ?? 'role',
              style: const TextStyle(
                color: Colors.teal,
              ),
            ),
            //
            IconButton.filled(
              onPressed: () {},
              icon: Text(room.tweetCount.toString()),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: FirestoreQueryBuilder(
                  query: query,
                  builder: (context, snapshot, child) {
                    return ListView(
                      // itemExtent: 25,
                      cacheExtent: 1000,
                      reverse: true,
                      children: snapshot.docs
                          .map(
                            (e) => TweetBox(
                              tweet: e.data()!,
                              me: me!,
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
                // child: FirestoreListView<Tweet?>(
                //   query: query,
                //   pageSize: 10,
                //   cacheExtent: 5,
                //   reverse: true,
                //   padding: const EdgeInsets.all(8),
                //   itemBuilder: (context, snapshot) {
                //     // Data is now typed!
                //     Tweet? tweet = snapshot.data();

                //     return TweetBox(
                //       tweet: tweet!,
                //       me: me!,
                //     );
                //   },
                //   loadingBuilder: (context) {
                //     return const Center(
                //       child: Text('Loading'),
                //       // child: CircularProgressIndicator(),
                //     );
                //   },
                //   emptyBuilder: (context) {
                //     return const Center(
                //       child: Text('Empty'),
                //     );
                //   },
                //   errorBuilder: (context, error, stackTrace) {
                //     return Column(
                //       children: [
                //         Text(error.toString()),
                //         Text(stackTrace.toString()),
                //       ],
                //     );
                //   },
                // ),
              ),

              //
              if (me != null) SendBox(me: me),
            ],
          ),
        ),
      ),
    );
  }
}

class TweetBox extends HookConsumerWidget {
  const TweetBox({
    super.key,
    required this.tweet,
    required this.me,
  });

  final Tweet tweet;
  final User me;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    isWebsite(tweet.text);

    final ValueNotifier<PreviewData?> linkPreviewData = useState(null);

    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actionsPadding: const EdgeInsets.all(8),
            title: const Text('Delete this tweet'),
            actions: [
              OutlinedButton(
                onPressed: () {
                  ref.read(tweetListProvider.notifier).deleteTweet(tweet);
                  Navigator.pop(context);
                },
                child: const Text('Delete'),
              ),
            ],
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.red, width: 1),
          borderRadius: 12.br,
        ),
        padding: (12, 0).e,
        child: Row(
          children: [
            const Expanded(
              flex: 2,
              child: SizedBox(),
            ),
            Expanded(
              flex: 8,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 1),
                  borderRadius: 12.br,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 50,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Icon(Icons.palette_outlined),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SelectableText(tweet.text),
                          // SuperLink(tweet.text),

                          if (tweet.mediaType == MediaType.IMAGE)
                            ClipRRect(
                              borderRadius: 25.br,
                              child: SizedBox(
                                height: 300,
                                width: 300,
                                child: Image.network(
                                  tweet.link,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          if (tweet.mediaType == MediaType.QR)
                            QrBox(
                              qrtext: tweet.text,
                            ),
                          if (isWebsite(tweet.text)) ...[
                            LinkPreview(
                              enableAnimation: true,
                              onPreviewDataFetched: (p0) {
                                linkPreviewData.value = p0;
                              },
                              previewData: linkPreviewData.value,
                              text: tweet.text,
                              width: 300,
                            ),
                          ],

                          Text(
                            'Time : ${dateMDYYYYHMP(
                              DateTime.tryParse(tweet.created),
                            )}',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]..sort(
              (_, __) => me.id == tweet.senderId ? -1 : 1,
            ),
        ),
      ),
    );
  }
}
