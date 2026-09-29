// ignore_for_file: avoid_print, unused_local_variable

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating/presentation/firebase/chatting_provider.dart';
import 'package:dating/presentation/firebase/pickup_callpage.dart';
import 'package:dating/presentation/screens/BottomNavBar/homeProvider/homeprovier.dart';
import 'package:dating/presentation/widgets/appbarr.dart';
import 'package:dating/presentation/widgets/other_widget.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/config.dart';
import '../../../core/ui.dart';
import '../../../language/localization/app_localization.dart';
import '../../../main.dart';
import '../../firebase/chat_page.dart';
import '../../firebase/chat_service.dart';

const Color _chatBg = Color(0xFF08050D);
const Color _chatSurface = Color(0xFF15101D);
const Color _chatSurface2 = Color(0xFF1D1427);
const Color _chatBorder = Color(0xFF382642);
const Color _chatPink = Color(0xFFFF4FA3);
const Color _chatPurple = Color(0xFF9B5CFF);
const Color _chatText = Color(0xFFF8F2FA);
const Color _chatMuted = Color(0xFFB7AABD);

BoxDecoration _chatCardDecoration() => BoxDecoration(
  gradient: const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [_chatSurface2, _chatSurface],
  ),
  borderRadius: BorderRadius.circular(20),
  border: Border.all(color: _chatBorder),
);

Widget _chatAvatar(String image, {double radius = 25}) {
  final bool hasImage = image != "null" && image.isNotEmpty;
  final ImageProvider<Object> provider = hasImage
      ? NetworkImage("${Config.baseUrl}$image") as ImageProvider<Object>
      : const AssetImage("assets/Image/05.png") as ImageProvider<Object>;
  return Container(
    padding: const EdgeInsets.all(2),
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      gradient: LinearGradient(colors: [_chatPink, _chatPurple]),
    ),
    child: CircleAvatar(
      radius: radius,
      backgroundColor: _chatBg,
      backgroundImage: provider,
    ),
  );
}

class ChatScreen extends StatefulWidget {
  static const chatScreenRoute = "/chatScreen";

  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with AutomaticKeepAliveClientMixin<ChatScreen> {
  late ChattingProvider chattingProvider;

  @override
  void initState() {
    super.initState();
    chattingProvider = Provider.of<ChattingProvider>(context, listen: false);
    chattingProvider.demo1(context).then((value) {
      chattingProvider.isLoadingchat = false;
    });
    chattingProvider.getblockklisttApi(context);
    chattingProvider.searchController.clear();
    chattingProvider.isSearch = false;
  }

  bool get wantKeepAlive => true;
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    chattingProvider = Provider.of<ChattingProvider>(context);

    return Theme(
      data: Theme.of(context).copyWith(
        scaffoldBackgroundColor: _chatBg,
        canvasColor: _chatBg,
        cardColor: _chatSurface,
        colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: _chatPink,
          secondary: _chatPurple,
          surface: _chatSurface,
          onSurface: _chatText,
        ),
        textTheme: Theme.of(context).textTheme.copyWith(
          headlineSmall: const TextStyle(
            color: _chatText,
            fontSize: 28,
            fontWeight: FontWeight.w800,
          ),
          bodyMedium: const TextStyle(
            color: _chatText,
            fontSize: 14,
          ),
          bodySmall: const TextStyle(
            color: _chatMuted,
            fontSize: 12,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: _chatBg,
        body: Stack(
          children: [
            Positioned(
              top: -90,
              right: -80,
              child: IgnorePointer(
                child: Container(
                  width: 230,
                  height: 230,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [_chatPink.withOpacity(0.15), Colors.transparent],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -110,
              left: -90,
              child: IgnorePointer(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [_chatPurple.withOpacity(0.13), Colors.transparent],
                    ),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 15, 20, 14),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)?.translate("Messages") ?? "Messages",
                                style: const TextStyle(
                                  color: _chatText,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                AppLocalizations.of(context)?.translate("Connect with your matches") ??
                                    "Connect with your matches",
                                style: const TextStyle(
                                  color: _chatMuted,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: chattingProvider.updateIsSearch,
                          borderRadius: BorderRadius.circular(17),
                          child: Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: _chatSurface,
                              borderRadius: BorderRadius.circular(17),
                              border: Border.all(color: _chatBorder),
                            ),
                            child: const Icon(
                              Icons.search_rounded,
                              color: _chatText,
                              size: 22,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (chattingProvider.isSearch)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                      child: Container(
                        decoration: _chatCardDecoration(),
                        child: TextField(
                          controller: chattingProvider.searchController,
                          style: const TextStyle(color: _chatText, fontSize: 14),
                          cursorColor: _chatPink,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.search_rounded, color: _chatMuted),
                            suffixIcon: InkWell(
                              onTap: chattingProvider.updateIsSearch,
                              child: const Icon(Icons.close_rounded, color: _chatPink),
                            ),
                            hintText: AppLocalizations.of(context)?.translate("Search..") ?? "Search..",
                            hintStyle: const TextStyle(color: _chatMuted),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          ),
                          onChanged: chattingProvider.searchIteam,
                        ),
                      ),
                    ),
                  Expanded(
                    child: chattingProvider.isLoadingchat
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: _chatPink,
                              strokeWidth: 2.5,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: chattingProvider.userData.isEmpty
                                ? _emptyChatView()
                                : chattingProvider.searchController.text.isEmpty
                                    ? _buildUserList()
                                    : chattingProvider.searchIndexList.isEmpty
                                        ? _emptySearchView()
                                        : ListView.builder(
                                            padding: const EdgeInsets.only(bottom: 20),
                                            itemCount: chattingProvider.searchIndexList.length,
                                            itemBuilder: (context, index) {
                                              final result = chattingProvider.searchIndexList[index];
                                              final itemData = Map<String, dynamic>.from(
                                                chattingProvider.searchiteams[result],
                                              );
                                              return _premiumChatTile(
                                                name: itemData["name"]?.toString() ?? "",
                                                image: itemData["image"]?.toString() ?? "null",
                                                message: itemData["message"]?.toString() ?? "",
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => ChattingPage(
                                                        userData: itemData,
                                                        proPic: itemData["image"],
                                                        resiverUserId: itemData["uid"],
                                                        resiverUseremail: itemData["name"],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                          ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyChatView() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 34),
        decoration: _chatCardDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [_chatPink.withOpacity(0.20), _chatPurple.withOpacity(0.20)],
                ),
              ),
              child: const Icon(Icons.forum_rounded, color: _chatPink, size: 34),
            ),
            const SizedBox(height: 15),
            const Text(
              "No Chats Yet",
              style: TextStyle(
                color: _chatText,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              "Your conversations will appear here.",
              textAlign: TextAlign.center,
              style: TextStyle(color: _chatMuted, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptySearchView() {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
        decoration: _chatCardDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.person_search_rounded, color: _chatPink, size: 42),
            const SizedBox(height: 12),
            Text(
              AppLocalizations.of(context)?.translate("User Not Found") ?? "User Not Found",
              style: const TextStyle(
                color: _chatText,
                fontSize: 17,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Try another name or search term.",
              style: TextStyle(color: _chatMuted, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _premiumChatTile({
    required String name,
    required String image,
    required String message,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: _chatCardDecoration(),
            child: Row(
              children: [
                _chatAvatar(image),
                const SizedBox(width: 13),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _chatText,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: _chatMuted, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFF74677D),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  // Widget _buildUserList() {
  //   return StreamBuilder(
  //       stream: FirebaseFirestore.instance.collection("datingUser").snapshots(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasError) {
  //           return const Text("Error");
  //         }
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return ListTile(
  //             contentPadding: const EdgeInsets.symmetric(vertical: 5),
  //             leading: commonSimmer(height: 50, width: 50, radius: 50),
  //             title: Row(
  //               children: [
  //                 commonSimmer(height: 10, width: 50, radius: 10),
  //               ],
  //             ),
  //             subtitle: Row(
  //               children: [
  //                 commonSimmer(height: 10, width: 30, radius: 10),
  //               ],
  //             ),
  //             trailing: commonSimmer(height: 10, width: 30, radius: 10),
  //           );
  //         } else {
  //           return ListView(
  //             // scrollDirection: Axis.vertical,
  //             // physics: NeverScrollableScrollPhysics(),
  //             // controller: _scrollController,
  //             shrinkWrap: true,
  //             children: snapshot.data!.docs.map<Widget>((doc) {
  //               return _buildUserListIteam(doc, snapshot.data!.docs.length);
  //             }
  //            ).toList(),
  //           );
  //           // return ListView.builder(
  //           //   controller: _scrollController,
  //           //   shrinkWrap: true,
  //           //   itemCount: snapshot.data!.docs.length,
  //           //   itemBuilder: (context, index) {
  //           //     final doc = snapshot.data!.docs[index];
  //           //     return _buildUserListIteam(doc, snapshot.data!.docs.length);
  //           //   },
  //           // );
  //         }
  //       });
  // }
  //
  // Widget _buildMessageiteam(document, String email, String uid, String proPic, int legnth, var snapshot) {
  //   Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  //
  //   List apilist = [];
  //
  //   apilist.addAll(chattingProvider.getblockListApi.blockByMe as Iterable);
  //   apilist.addAll(chattingProvider.getblockListApi.blockByOther as Iterable);
  //   print("  + + + + :---  $apilist");
  //
  //   if (chattingProvider.searchiteams.length < legnth - 1) {
  //     if (snapshot.data!.docs.isNotEmpty) {
  //       chattingProvider.searchiteams.add({
  //         "name": email,
  //         "image": proPic,
  //         "uid": uid,
  //         "message": data["message"],
  //         "timestamp": data["timestamp"]
  //       });
  //     }
  //   }
  //
  //   return apilist.contains(uid)
  //       ? const SizedBox()
  //       : ListTile(
  //           dense: true,
  //           onTap: () {
  //             Navigator.push(
  //                 context,
  //                 MaterialPageRoute(
  //                   builder: (context) => ChattingPage(
  //                     proPic: proPic,
  //                     resiverUserId: uid,
  //                     resiverUseremail: email,
  //                     userData: data,
  //                   ),
  //                 )
  //             );
  //           },
  //           contentPadding: const EdgeInsets.symmetric(vertical: 5),
  //           leading: proPic == "null" ? const CircleAvatar(
  //                   backgroundColor: Colors.transparent,
  //                   radius: 25,
  //                   backgroundImage: AssetImage(
  //                     "assets/Image/05.png",
  //                   )) : CircleAvatar(
  //                   backgroundColor: Colors.transparent,
  //                   radius: 25,
  //                   backgroundImage: NetworkImage("${Config.baseUrl}$proPic"),
  //                 ),
  //           title: Text(
  //             email,
  //             style: Theme.of(context).textTheme.bodyMedium!,
  //           ),
  //           subtitle: Text(data["message"],
  //               maxLines: 1,
  //               overflow: TextOverflow.ellipsis,
  //               style: Theme.of(context).textTheme.bodySmall),
  //           trailing: Text(
  //               DateFormat('hh:mm a')
  //                   .format(DateTime.fromMicrosecondsSinceEpoch(
  //                       data["timestamp"].microsecondsSinceEpoch))
  //                   .toString(),
  //               style: const TextStyle(
  //                 fontSize: 10,
  //               ))
  //   );
  // }
  //
  // ChatServices chatservices = ChatServices();
  //
  // Widget _buildUserListIteam(DocumentSnapshot document, int legth) {
  //   Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  //   print("firebase data :- ${data}");
  //   var uid = Provider.of<HomeProvider>(context, listen: false).uid;
  //   List ids = [data["uid"], uid];
  //
  //   if (Provider.of<HomeProvider>(context, listen: false).userlocalData.userLogin!.name != data["name"]) {
  //     return StreamBuilder(
  //         stream: chatservices.getMessage(userId: data["uid"], otherUserId: Provider.of<HomeProvider>(context, listen: false).uid),
  //         builder: (context, snapshot) {
  //           if (snapshot.hasError) {
  //             return Text("Error${snapshot.error}",style: Theme.of(context).textTheme.bodySmall);
  //           }
  //           if (snapshot.connectionState == ConnectionState.waiting) {
  //             return const SizedBox();
  //           } else {
  //             return snapshot.data!.docs.isEmpty
  //                 ? const SizedBox()
  //                 : _buildMessageiteam(snapshot.data!.docs.last, data["name"],
  //                     data["uid"], data["pro_pic"].toString(), legth, snapshot);
  //           }
  //         });
  //     // return Container(
  //     //   height: 40,
  //     //   width: 300,
  //     //   color: Colors.red,
  //     //   margin: EdgeInsets.all(8),
  //     // );
  //   } else {
  //     return const SizedBox();
  //   }
  // }


  Widget _buildUserList() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("datingUser").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("Error");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            leading: commonSimmer(height: 50, width: 50, radius: 50),
            title: Row(
              children: [
                commonSimmer(height: 10, width: 50, radius: 10),
              ],
            ),
            subtitle: Row(
              children: [
                commonSimmer(height: 10, width: 30, radius: 10),
              ],
            ),
            trailing: commonSimmer(height: 10, width: 30, radius: 10),
          );
        } else {
          List<DocumentSnapshot> userDocs = snapshot.data!.docs;
          List<Future<Map<String, dynamic>>> userWithTimestamps = userDocs.map((userDoc) async {
            var userId = userDoc['uid'];
            var currentUserId = Provider.of<HomeProvider>(context, listen: false).uid;

            // Construct the chat room ID
            String chatRoomId = userId.compareTo(currentUserId) < 0
                ? '${userId}_$currentUserId'
                : '${currentUserId}_$userId';

            // Fetch the latest message in the chat room
            var messagesQuery = await FirebaseFirestore.instance.collection("chat_rooms").doc(chatRoomId).collection("message").orderBy("timestamp", descending: true).limit(1).get();

            // Extract the latest timestamp and message
            if (messagesQuery.docs.isNotEmpty) {
              var latestMessageDoc = messagesQuery.docs.first;
              return {
                "userDoc": userDoc,
                "latestMessage": latestMessageDoc["message"],
                "latestTimestamp": latestMessageDoc["timestamp"].millisecondsSinceEpoch,
              };
            } else {
              return {
                "userDoc": userDoc,
                "latestMessage": null,
                "latestTimestamp": 0,
              };
            }
          }).toList();

          return FutureBuilder(
            future: Future.wait(userWithTimestamps),
            builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> userSnapshot) {
              if (!userSnapshot.hasData) {
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  leading: commonSimmer(height: 50, width: 50, radius: 50),
                  title: Row(
                    children: [
                      commonSimmer(height: 10, width: 50, radius: 10),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      commonSimmer(height: 10, width: 30, radius: 10),
                    ],
                  ),
                  trailing: commonSimmer(height: 10, width: 30, radius: 10),
                );
              }

              // Sort the users based on their latest message timestamp
              List<Map<String, dynamic>> sortedUsers = userSnapshot.data!;
              sortedUsers.sort((a, b) {
                return b["latestTimestamp"].compareTo(a["latestTimestamp"]);
              });

              return SingleChildScrollView(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: sortedUsers.length,
                  itemBuilder: (context, index) {
                    final userDoc = sortedUsers[index]["userDoc"];
                    final latestMessage = sortedUsers[index]["latestMessage"];
                    return _buildUserListItem(userDoc, userDocs.length);
                  },
                ),
              );
            },
          );
        }
      },
    );
  }


  Widget _buildMessageItem(document, String email, String uid, String proPic, int legnth, var snapshot) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    List apilist = [];
    apilist.addAll(chattingProvider.getblockListApi.blockByMe as Iterable);
    apilist.addAll(chattingProvider.getblockListApi.blockByOther as Iterable);
    print("  + + + + :---  $apilist");

    if (chattingProvider.searchiteams.length < legnth - 1) {
      if (snapshot.data!.docs.isNotEmpty) {
        chattingProvider.searchiteams.add({
          "name": email,
          "image": proPic,
          "uid": uid,
          "message": data["message"],
          "timestamp": data["timestamp"]
        });
      }
    }
    return apilist.contains(uid)
        ? const SizedBox()
        : ListTile(
        dense: true,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChattingPage(
                  proPic: proPic,
                  resiverUserId: uid,
                  resiverUseremail: email,
                  userData: data,
                ),
              ));
        },
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        leading: proPic == "null"
            ? const CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 25,
            backgroundImage: AssetImage(
              "assets/Image/05.png",
              // "assets/Image/appmainLogo1.png",
            ))
            : CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 25,
          backgroundImage: NetworkImage("${Config.baseUrl}$proPic"),
        ),
        title: Text(
          email,
          style: Theme.of(context).textTheme.bodyMedium!,
        ),
        subtitle: Text(data["message"],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall),
        trailing: Text(
            DateFormat('hh:mm a')
                .format(DateTime.fromMicrosecondsSinceEpoch(
                data["timestamp"].microsecondsSinceEpoch))
                .toString(),
            style: const TextStyle(
              fontSize: 10,
            )));
  }

  ChatServices chatServices = ChatServices();

  Widget _buildUserListItem(DocumentSnapshot document, int legth) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    var uid = Provider.of<HomeProvider>(context, listen: false).uid;
    List ids = [data["uid"], uid];

    if (Provider.of<HomeProvider>(context, listen: false).userlocalData.userLogin!.name != data["name"]) {
      return StreamBuilder(stream: chatServices.getMessage(userId: data["uid"], otherUserId: Provider.of<HomeProvider>(context, listen: false).uid),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text("Error${snapshot.error}",
                  style: Theme.of(context).textTheme.bodySmall);
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox();
            } else {
              return snapshot.data!.docs.isEmpty
                  ? const SizedBox()
                  : _buildMessageItem(snapshot.data!.docs.last, data["name"], data["uid"], data["pro_pic"].toString(), legth, snapshot);
            }
          });
    } else {
      return const SizedBox();
    }
  }

}

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void listenFCM() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              icon: '@mipmap/ic_launcher',
            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentSound: true,
              presentBadge: true,
            ),
          ),
          payload: jsonEncode({
            "name": message.data["name"],
            "id": message.data["id"],
            "propic": message.data["propic"].toString(),
            "vcId": message.data["vcId"].toString(),
            "Audio": message.data["Audio"].toString(),
          }));
    }
  });
}

void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
  } else {}
}

// Future<void> initializeNotifications() async {
//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
//   const InitializationSettings initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);
//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     onSelectNotification: (String? payload) async {
//       print(" 0 0 0 11 0 0 0 11 0 0 0 11 0 0 0 11 0 0 0 $payload");
//
//       if (payload != null) {
//         Map data = jsonDecode(payload);
//
//         if (data["vcId"] == "null" && data["Audio"] == "null") {
//           navigatorKey.currentState?.push(MaterialPageRoute(
//             builder: (context) => ChattingPage(
//                 resiverUserId: data["id"],
//                 resiverUseremail: data["name"],
//                 proPic: data["propic"]),
//           ));
//         } else if (data["vcId"] != null && data["Audio"] == "null") {
//           navigatorKey.currentState?.push(MaterialPageRoute(
//             builder: (context) => PickUpCall(userData: data, isAudio: false),
//           ));
//         } else if (data["Audio"] != null) {
//           navigatorKey.currentState?.push(MaterialPageRoute(
//             builder: (context) => PickUpCall(userData: data, isAudio: true),
//           ));
//         }
//       }
//     },
//   );
// }

Future<void> initializeNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings =
  InitializationSettings(android: initializationSettingsAndroid);

  // Initialization
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) {
      // Handle notification response
      final String? payload = response.payload;

      if (payload != null) {
        Map<String, dynamic> data = jsonDecode(payload);

        if (data["vcId"] == "null" && data["Audio"] == "null") {
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) => ChattingPage(
              resiverUserId: data["id"],
              resiverUseremail: data["name"],
              proPic: data["propic"],
              userData: data,
            ),
          ));
        } else if (data["vcId"] != null && data["Audio"] == "null") {
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) => PickUpCall(userData: data, isAudio: false),
          ));
        } else if (data["Audio"] != null) {
          navigatorKey.currentState?.push(MaterialPageRoute(
            builder: (context) => PickUpCall(userData: data, isAudio: true),
          ));
        }
      }
    },
  );
}

void loadFCM() async {
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
      enableVibration: true,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
}

