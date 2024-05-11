// import 'dart:async';
// import 'dart:convert';
//
// import 'package:ebook_app/view/splsh_screen/splash_screen.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:http/http.dart';
//
// import 'controller/net_check_cont.dart';
// import 'datafile/firebase_data/firebasedata.dart';
//
//
//
//
// /// Working example of FirebaseMessaging.
// /// Please use this in order to verify messages are working in foreground, background & terminated state.
// /// Setup your app following this guide:
// /// https://firebase.google.com/docs/cloud-messaging/flutter/client#platform-specific_setup_and_requirements):
// ///
// /// Once you've completed platform specific requirements, follow these instructions:
// /// 1. Install melos tool by running `flutter pub global activate melos`.
// /// 2. Run `melos bootstrap` in FlutterFire project.
// /// 3. In your terminal, root to ./packages/firebase_messaging/firebase_messaging/example directory.
// /// 4. Run `flutterfire configure` in the example/ directory to setup your app with your Firebase project.
// /// 5. Run the app on an actual device for iOS, android is fine to run on an emulator.
// /// 6. Use the following script to send a message to your device: scripts/send-message.js. To run this script,
// ///    you will need nodejs installed on your computer. Then the following:
// ///     a. Download a service account key (JSON file) from your Firebase console, rename it to "google-services.json" and add to the example/scripts directory.
// ///     b. Ensure your device/emulator is running, and run the FirebaseMessaging example app using `flutter run`.
// ///     c. Copy the token that is printed in the console and paste it here: https://github.com/firebase/flutterfire/blob/01b4d357e1/packages/firebase_messaging/firebase_messaging/example/lib/main.dart#L32
// ///     c. From your terminal, root to example/scripts directory & run `npm install`.
// ///     d. Run `npm run send-message` in the example/scripts directory and your app will receive messages in any state; foreground, background, terminated.
// ///  Note: Flutter API documentation for receiving messages: https://firebase.google.com/docs/cloud-messaging/flutter/receive
// ///  Note: If you find your messages have stopped arriving, it is extremely likely they are being throttled by the platform. iOS in particular
// ///  are aggressive with their throttling policy.
// ///
// /// To verify that your messages are being received, you ought to see a notification appearon your device/emulator via the flutter_local_notifications plugin.
// /// Define a top-level named handler which background/terminated messages will
// /// call. Be sure to annotate the handler with `@pragma('vm:entry-point')` above the function declaration.
// @pragma('vm:entry-point')
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//
//   print("background----true");
//   await Firebase.initializeApp();
//   await setupFlutterNotifications();
//   showFlutterNotification(message);
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   print('Handling a background message ${message.messageId}');
// }
//
// /// Create a [AndroidNotificationChannel] for heads up notifications
// late AndroidNotificationChannel channel;
//
// bool isFlutterLocalNotificationsInitialized = false;
//
// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     return;
//   }
//   channel = const AndroidNotificationChannel(
//     'com.example.ebook', // id
//     'High Importance Notifications', // title
//     description:
//     'This channel is used for important notifications.', // description
//     importance: Importance.high,
//   );
//
//   flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   /// Create an Android Notification Channel.
//   ///
//   /// We use this channel in the `AndroidManifest.xml` file to override the
//   /// default FCM channel to enable heads up notifications.
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//       AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//
//   /// Update the iOS foreground notification presentation options to allow
//   /// heads up notifications.
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   isFlutterLocalNotificationsInitialized = true;
// }
//
// void showFlutterNotification(RemoteMessage message) {
//
//   print("sjkgklgjdfg");
//   RemoteNotification? notification = message.notification;
//
//   print("sjkgklgjdfg1111222222");
//
//   AndroidNotification? android = message.notification?.android;
//
//
//   if (notification != null && android != null && !kIsWeb) {
//
//     print("sjkgklgjdfg1111");
//
//
//     _showNotification(message);
//     // flutterLocalNotificationsPlugin.show(
//     //   notification.hashCode,
//     //   notification.title,
//     //   notification.body,
//     //   NotificationDetails(
//     //     android: AndroidNotificationDetails(
//     //       'com.example.ebook',
//     //       channel.name,
//     //       channelDescription: channel.description,
//     //       // TODO add a proper drawable resource to android, for now using
//     //       //      one that already exists in example app.
//     //       icon: 'launch_background',
//     //     ),
//     //   ),
//     // );
//   }
// }
//
// /// Initialize the [FlutterLocalNotificationsPlugin] package.
// late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   //     //
//
//
//   // Set the background messaging handler early on, as a named top-level function
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//
//   if (!kIsWeb) {
//     await setupFlutterNotifications();
//   }
//
//   runApp(MessagingExampleApp());
// }
//
// /// Entry point for the example application.
// class MessagingExampleApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       title: 'Messaging Example App',
//       theme: ThemeData.dark(),
//       routes: {
//         '/': (context) => Application(),
//         '/message': (context) => SplashScreen(),
//       },
//     );
//   }
// }
//
// // Crude counter to make messages unique
// int _messageCount = 0;
//
// /// The API endpoint here accepts a raw FCM payload for demonstration purposes.
// Future<String> constructFCMPayload(String? token1) async {
//
//   final token = await FirebaseMessaging.instance.getToken();
//
//   print("token==$token");
//
//
//   sendFcmMessage( 'String title', 'String message', token!,'String imageUrl');
//   // _messageCount++;
//   // return jsonEncode({
//   //   'token': token,
//   //   'data': {
//   //     'via': 'FlutterFire Cloud Messaging!!!',
//   //     'count': '_messageCount.toString()',
//   //   },
//   //   'notification': {
//   //     'title': 'Hello FlutterFire!',
//   //     'body': 'This notification (#$_messageCount) was created via FCM!',
//   //   },
//   // });
//
//   return '';
// }
//
//
// Future<bool> sendFcmMessage(String title, String message,String token,String imageUrl)
// async {
//   // print("image----${image}");
//
//
//
//
//   print("url--------${imageUrl}");
//
//   try {
//
//     var url = 'https://fcm.googleapis.com/fcm/send';
//     var header = {
//       "Content-Type": "application/json",
//       "Authorization":
//       'key=AAAA8uxOfTI:APA91bHwyrN0n70EqPAzhxFVL6C-hJx6HpaE87lV3ifNs19WsNxNi0h0hnBdEC5giAKbC8heLpgfjoerQCAkRRfw4RLzXGLWnX6nS2FQwBREkvtxvOkAdL2dPRs--WfdyApGqyByaAST'
//     };
//     var request =
//     {
//       "notification": {
//         "title": title,
//         "body" : message,
//         "text": "${message}",
//         "image": imageUrl,
//         // "click_action": (linkController.text.isNotEmpty)?"FLUTTER_NOTIFICATION_CLICK":"",
//         // "link": linkController.text
//         // "image": image,
//         // "imageUrl": "https://media.istockphoto.com/id/1350993173/photo/winding-coast-road-in-corsica.jpg?s=612x612&w=is&k=20&c=D7sRuENZ3q5oztuqI80bR8-Am0zla1Ax6hdleiG7PgE="
//
//         // "sound": "default",
//         // "color": "#990000",
//       },
//       "pushNotifications":{
//         "foreground": true
//       },
//       // "android":{
//       //   "notification": {
//       //     "imageUrl": "https://media.istockphoto.com/id/1350993173/photo/winding-coast-road-in-corsica.jpg?s=612x612&w=is&k=20&c=D7sRuENZ3q5oztuqI80bR8-Am0zla1Ax6hdleiG7PgE="
//       //     // "sound": "default",
//       //     // "color": "#990000",
//       //   },
//       // },
//       "priority": "high",
//       "to": token,
//       "mutable-content": true,
//       // "to": "d2NW0tA1R1u1EO53tbEMsv:APA91bFTJII4gYbAjskd8DkwBBiKG_CeP0sVVTemoILuW_ksj6L3A4IzpA1uXjmaarvkMpE4NhrNqj6LSjyS_rcUKDOTgVByxSLaSghbVJNcTN0caCH5tTMoi-miaZJb5ZdhSqXnCIOl",
//
//     };
//
//     var client = new Client();
//     var response =
//     await client.post(Uri.parse(url), headers: header, body: json.encode(request));
//
//     print("res--${response.body}");
//     return true;
//   } catch (e, s) {
//     print(e);
//     return false;
//   }
//
// }
//
//
//
// /// Renders the example application.
// class Application extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _Application();
// }
//
// class _Application extends State<Application> {
//   String? _token;
//   String? initialMessage;
//   bool _resolved = false;
//
//   @override
//   void initState() {
//     super.initState();
//
//     FirebaseMessaging.instance.getInitialMessage().then(
//           (value) => setState(
//             () {
//           _resolved = true;
//           initialMessage = value?.data.toString();
//         },
//       ),
//     );
//
//     FirebaseMessaging.onMessage.listen(showFlutterNotification);
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//       print('A new onMessageOpenedApp event was published!');
//
//       showFlutterNotification(message);
//
//
//       // Navigator.pushNamed(
//       //   context,
//       //   '/message',
//       //   arguments: Spla(message, true),
//       // );
//     });
//   }
//
//
//
//   Future<void> sendPushMessage() async {
//     // if (_token == null) {
//     //   print('Unable to send FCM message, no token exists.');
//     //   return;
//     // }
//
//     String s = await constructFCMPayload('token');
//
//     // try {
//     //   await http.post(
//     //     Uri.parse('https://api.rnfirebase.io/messaging/send'),
//     //     headers: <String, String>{
//     //       'Content-Type': 'application/json; charset=UTF-8',
//     //     },
//     //     body: s,
//     //   );
//     //   print('FCM request for device sent!');
//     // } catch (e) {
//     //   print(e);
//     // }
//   }
//
//   Future<void> onActionSelected(String value) async {
//     switch (value) {
//       case 'subscribe':
//         {
//           print(
//             'FlutterFire Messaging Example: Subscribing to topic "fcm_test".',
//           );
//           await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
//           print(
//             'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.',
//           );
//         }
//         break;
//       case 'unsubscribe':
//         {
//           print(
//             'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".',
//           );
//           await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
//           print(
//             'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.',
//           );
//         }
//         break;
//       case 'get_apns_token':
//         {
//           if (defaultTargetPlatform == TargetPlatform.iOS ||
//               defaultTargetPlatform == TargetPlatform.macOS) {
//             print('FlutterFire Messaging Example: Getting APNs token...');
//             String? token = await FirebaseMessaging.instance.getAPNSToken();
//             print('FlutterFire Messaging Example: Got APNs token: $token');
//           } else {
//             print(
//               'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.',
//             );
//           }
//         }
//         break;
//       default:
//         break;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cloud Messaging'),
//         actions: <Widget>[
//           PopupMenuButton(
//             onSelected: onActionSelected,
//             itemBuilder: (BuildContext context) {
//               return [
//                 const PopupMenuItem(
//                   value: 'subscribe',
//                   child: Text('Subscribe to topic'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'unsubscribe',
//                   child: Text('Unsubscribe to topic'),
//                 ),
//                 const PopupMenuItem(
//                   value: 'get_apns_token',
//                   child: Text('Get APNs token (Apple only)'),
//                 ),
//               ];
//             },
//           ),
//         ],
//       ),
//       floatingActionButton: Builder(
//         builder: (context) => FloatingActionButton(
//           onPressed: sendPushMessage,
//           backgroundColor: Colors.white,
//           child: const Icon(Icons.send),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // MetaCard('Permissions', Permissions()),
//             MetaCard(
//               'Initial Message',
//               Column(
//                 children: [
//                   Text(_resolved ? 'Resolved' : 'Resolving'),
//                   Text(initialMessage ?? 'None'),
//                 ],
//               ),
//             ),
//             // MetaCard(
//             //   'FCM Token',
//             //   TokenMonitor((token) {
//             //     _token = token;
//             //     return token == null
//             //         ? const CircularProgressIndicator()
//             //         : SelectableText(
//             //       token,
//             //       style: const TextStyle(fontSize: 12),
//             //     );
//             //   }),
//             // ),
//             // ElevatedButton(
//             //   onPressed: () {
//             //     FirebaseMessaging.instance
//             //         .getInitialMessage()
//             //         .then((RemoteMessage? message) {
//             //       if (message != null) {
//             //         Navigator.pushNamed(
//             //           context,
//             //           '/message',
//             //           arguments: MessageArguments(message, true),
//             //         );
//             //       }
//             //     });
//             //   },
//             //   child: const Text('getInitialMessage()'),
//             // ),
//             // MetaCard('Message Stream', MessageList()),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// UI Widget for displaying metadata.
// class MetaCard extends StatelessWidget {
//   final String _title;
//   final Widget _children;
//
//   // ignore: public_member_api_docs
//   MetaCard(this._title, this._children);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
//       child: Card(
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               Container(
//                 margin: const EdgeInsets.only(bottom: 16),
//                 child: Text(_title, style: const TextStyle(fontSize: 18)),
//               ),
//               _children,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ebook_app/controller/controller.dart';
import 'package:ebook_app/datafile/firebase_data/firebasedata.dart';
import 'package:ebook_app/routes/app_pages.dart';
import 'package:ebook_app/utils/constant.dart';
import 'package:ebook_app/utils/pref_data.dart';
import 'package:ebook_app/utils/theme_data.dart';
import 'package:ebook_app/utils/theme_service.dart';
import 'package:ebook_app/view/home_tab/populer_book_detail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'controller/net_check_cont.dart';
import 'models/book_list_model.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();

final StreamController<Map<String, dynamic>?> onClickStream =
    StreamController<Map<String, dynamic>?>.broadcast();

const String darwinNotificationCategoryPlain = 'plainCategory';

const MethodChannel platform =
    MethodChannel('dexterx.dev/flutter_local_notifications_example');

const String portName = 'notification_send_port';

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

String? selectedNotificationPayload;

// /// A notification action which triggers a url launch event
// const String urlLaunchActionId = 'id_1';

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';
// /// Defines a iOS/MacOS notification category for text input actions.
// const String darwinNotificationCategoryText = 'textCategory';
//
// /// Defines a iOS/MacOS notification category for plain actions.
// const String darwinNotificationCategoryPlain = 'plainCategory';

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  print("called------tapBackground");
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  selectNotificationStream.add(notificationResponse.payload);

  _configureSelectNotificationSubject();
  _configureDidReceiveLocalNotificationSubject();
}

@pragma('vm:entry-point')
Future<void> backgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("object-------called");

  print(
      "dataOpen===${message.data}===${message.notification!.android!.clickAction}====${message.notification!.body}===");

  if (message.data["story_id"] != null) {
    print("sroryZI------1111${message.data["story_id"]}");
    // PrefData.setStoryId(message.data["story_id"]);
  }

  // if(message.data.isNotEmpty && message.notification!.android!.clickAction!.isNotEmpty) {
  //
  //
  //   // selectNotificationStream.add(json.encode({"action":"FLUTTER_NOTIFICATION_CLICK_STORY","storyId":message.data["story_id"]}));
  //
  //   Map payload = json.decode(json.encode({"action":"FLUTTER_NOTIFICATION_CLICK_STORY","storyId":message.data["story_id"]}));
  //
  //   print("pay----true");
  //
  //   String action = payload["action"];
  //   print("called----notifications---true===${action}===");
  //
  //   if (action == "FLUTTER_NOTIFICATION_CLICK") {
  //     String link = payload["link"] ?? "";
  //
  //     Constant.launchURL(link);
  //   } else if (action == "FLUTTER_NOTIFICATION_CLICK_STORY") {
  //
  //     print("storyId------------true");
  //
  //     String storyId = payload["storyId"];
  //     print("storyId------------===$storyId===");
  //
  //     StoryModel? story = await FireBaseData.fetchStory(storyId);
  //
  //     print("story--------------11--${story!.id}");
  //     Get.to(PopularBookDetailScreen(
  //       storyModel: story,
  //     ));
  //   }
  //
  // }

  print(
      "dataOpen12121212121===${message.data}===${message.notification}====${message.notification!.body}===");

  print(" ");

  await setupFlutterNotifications();

  _configureSelectNotificationSubject();
  _configureDidReceiveLocalNotificationSubject();

  // showCustomToast1(message: "message");

  // selectNotificationStream.add(message.messageId);

  print("data---------${message.data.toString()}");
  print("data1111---------${message.notification!.title}");
}

setupFlutterNotifications() async {
  channel = const AndroidNotificationChannel(
    'com.example.ebook', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
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
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

// bool isAppBg = false;
AndroidNotificationChannel channel = AndroidNotificationChannel(
    "com.example.ebook", "big text channel name",
    importance: Importance.high, playSound: true);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  MobileAds.instance.initialize();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyBZITKH9BMhc5zHkTVUFa843P_CG4Ys_Eg",
      authDomain: "ebook-4d358.firebaseapp.com",
      projectId: "ebook-4d358",
      storageBucket: "ebook-4d358.appspot.com",
      messagingSenderId: "52319249413",
      appId: "1:52319249413:web:078a67869a1d175e61286c",
      measurementId: "G-KX0SWDPN8N",
    ));

    await FirebaseMessaging.instance.setAutoInitEnabled(false);

    requestPermissions();

    runApp(MyApp());
  } else {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();

    setIndex();

    // final token = await FirebaseMessaging.instance.getToken();
    //
    // FireBaseData.addToken(token ?? "");

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    FirebaseMessaging messages = FirebaseMessaging.instance;

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print("routeFromMessageOpen---_${message.data}");

      // final routeFromMessage = message.data[""];

      if (message.data.isNotEmpty) {
        print("sroryZI------${message.data["story_id"]}");

        print("link--------${message.data["link"]}");

        if (message.data["story_id"] != null) {
          await PrefData.setStoryId(message.data["story_id"]);
        }

        if (message.data["link"] != null) {
          print("setLink--------${message.data["link"]}");

          PrefData.setLink(message.data["link"]);

          // Constant.launchURL(message.notification!.android!.link!);
        }
      }
    });

    messages.requestPermission();

    await _configureLocalTimeZone();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        didReceiveLocalNotificationStream.add(
          ReceivedNotification(
            id: id,
            title: title,
            body: body,
            payload: payload,
          ),
        );
      },
      // notificationCategories: darwinNotificationCategories,
    );

    // final LinuxInitializationSettings initializationSettingsLinux =
    // LinuxInitializationSettings(
    //   defaultActionName: 'Open notification',
    //   defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
    // );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
      macOS: initializationSettingsDarwin,
      // linux: initializationSettingsLinux,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        print("selectNotification===true");

        selectNotificationStream.add(notificationResponse.payload);

        switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            selectNotificationStream.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              selectNotificationStream.add(notificationResponse.payload);
            }

            break;
        }
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );

    await FireBaseData.getAppDetail();

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    final RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    await FlutterDownloader.initialize(
        debug: true,
        // optional: set to false to disable printing logs to console (default: true)
        ignoreSsl:
            true // option: set to false to disable working with http links (default: false)
        );
    runApp(MyApp(
      message: message,
    ));
  }
}

//
GetXNetworkManager networkManager = Get.put(GetXNetworkManager());

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();

  var timeZoneName = tz.getLocation('America/Detroit');

  // final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(timeZoneName);
  // tz.setLocalLocation(tz.getLocation(detroit!));
}

Future<String> _downloadAndSaveFile(String url, String fileName) async {
  final Directory directory = await getApplicationDocumentsDirectory();
  final String filePath = '${directory.path}/$fileName';
  final http.Response response = await http.get(Uri.parse(url));
  final File file = File(filePath);
  await file.writeAsBytes(response.bodyBytes);
  return filePath;
}

Future<void> _showNotificationWithImage(RemoteMessage message) async {
  Map mapData = {
    "link": message.notification!.android!.link,
    "action": message.notification!.android!.clickAction,
    "storyId": message.data["story_id"]
  };

  String payload = json.encode(mapData);

  final String largeIconPath = await _downloadAndSaveFile(
      message.notification!.android!.imageUrl!, 'largeIcon');

  final String bigPicturePath = await _downloadAndSaveFile(
      message.notification!.android!.imageUrl!, 'bigPicture');

  final BigPictureStyleInformation bigPictureStyleInformation =
      BigPictureStyleInformation(FilePathAndroidBitmap(bigPicturePath),
          largeIcon: FilePathAndroidBitmap(largeIconPath),
          contentTitle: message.notification!.title,
          htmlFormatContentTitle: true,
          summaryText: message.notification!.body!,
          htmlFormatSummaryText: true);

  final AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails('com.example.ebook', 'big text channel name',
          channelDescription: 'big text channel description',
          styleInformation: bigPictureStyleInformation);

  const DarwinNotificationDetails iosNotificationDetails =
      DarwinNotificationDetails(
    categoryIdentifier: darwinNotificationCategoryPlain,
    presentAlert: true,
  );

  final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails, iOS: iosNotificationDetails);
  await flutterLocalNotificationsPlugin.show(1, message.notification!.title,
      message.notification!.body!, notificationDetails,
      payload: payload);

  // setStoryId(message.data["story_id"]);
  _configureSelectNotificationSubject();
  _configureDidReceiveLocalNotificationSubject();
}

NotificationTabController notificationTabController =
    Get.put(NotificationTabController());

Future<void> _showNotification(RemoteMessage message) async {
  Map mapData = {
    "link": message.notification!.android!.link,
    "action": message.notification!.android!.clickAction,
    "storyId": message.data["story_id"]
  };

  String payload = json.encode(mapData);
  const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
    'com.example.ebook',
    'big text channel name',
    channelDescription: 'big text channel description',
    importance: Importance.max,
    priority: Priority.high,
  );

  const DarwinNotificationDetails iosNotificationDetails =
      DarwinNotificationDetails(
    categoryIdentifier: darwinNotificationCategoryPlain,
  );
  const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails, iOS: iosNotificationDetails);
  await flutterLocalNotificationsPlugin.show(1, message.notification!.title,
      message.notification!.body!, notificationDetails,
      payload: payload);
}

//
void _configureDidReceiveLocalNotificationSubject() {
  print("receive---true");

  didReceiveLocalNotificationStream.stream
      .listen((ReceivedNotification receivedNotification) async {
    print("receive---${receivedNotification.payload}");

    Map payload = json.decode(receivedNotification.payload!);

    String action = payload["action"];

    if (action == "FLUTTER_NOTIFICATION_CLICK") {
      String link = payload["link"];

      Constant.launchURL(link);
    } else if (action == "FLUTTER_NOTIFICATION_CLICK_STORY") {
      String storyId = payload["storyId"];

      StoryModel? story = await FireBaseData.fetchStory(storyId);

      print("story--------------${story!.id}");
      Get.to(PopularBookDetailScreen(
        storyModel: story,
      ));
    }
  });
}

Future<void> _configureSelectNotificationSubject() async {
  print("called----notification");

  // if(isAppBg){
  //
  //   print("isAppBg---$isAppBg");
  //
  // }else{

  selectNotificationStream.stream.listen((receive) async {
    print("pay1111----true===${receive}");

    if (receive != null && receive.isNotEmpty) {
      Map message = json.decode(receive);
      // var message = jsonDecode(receive);

      print("storyId-------_${message["storyId"]}");

      if (message["storyId"] != null) {
        // PrefData.setStoryId(message["storyId"]);
        // PrefData.setIsBack(true);

        StoryModel? story = await FireBaseData.fetchStory(message["storyId"]);

        Get.to(PopularBookDetailScreen(
          storyModel: story!,
        ));
      } else if (message["link"] != null) {
        Constant.launchURL(message["link"]);
      }
    }

    // Map payload = json.decode(receive!);
    //
    // print("pay----true");
    //
    // String action = payload["action"];
    // print("called----notifications---true===${action}===${receive}");
    //
    // if (action == "FLUTTER_NOTIFICATION_CLICK") {
    //   String link = payload["link"] ?? "";
    //
    //   Constant.launchURL(link);
    // } else if (action == "FLUTTER_NOTIFICATION_CLICK_STORY") {
    //   String storyId = payload["storyId"];
    //
    //   StoryModel? story = await FireBaseData.fetchStory(storyId);
    //
    //   print("story--------------11--${story!.id}");
    //   Get.to(PopularBookDetailScreen(
    //     storyModel: story,
    //   ));
    // }
  });
  // }
}

void requestPermissions() async {
  if (Platform.isIOS || Platform.isMacOS) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  if (Platform.isAndroid) {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    // ignore: unused_local_variable
    final bool? granted =
        await androidImplementation?.requestNotificationsPermission();
  }
}

// AppLifecycleState? _notification;

// ignore: must_be_immutable
class MyApp extends StatefulWidget {
  RemoteMessage? message;
  MyApp({super.key, this.message});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      requestPermissions();

      _configureSelectNotificationSubject();

      // _configureDidReceiveLocalNotificationSubject();
    }

    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: AppPages.routes,
      // home: (widget.message != null)?SplashScreen(message: widget.message):null,
    );
  }

  initInfo() async {
    print("notifications-----true");

    final fcmToken = await FirebaseMessaging.instance.getToken();

    print("fcmToken----------$fcmToken");

    FirebaseMessaging.instance.getToken().then((value) {
      print("value------$value");
    });

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    // FirebaseMessaging.instance
    //     .getInitialMessage()
    //     .then((value) {
    //   print("FirebaseMessaging.getInitialMessage");
    //   if (value != null) {
    //     //
    //     Get.to(LatestStoryScreen());
    //   }
    // });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("message------$message");

      print("background2222===true");

      Future.delayed(Duration.zero, () {
//       FirebaseService._localNotificationsPlugin.cancelAll();
//       FirebaseService.showNotification(message);

        flutterLocalNotificationsPlugin.cancelAll();

        if (message.notification != null &&
            message.notification!.android != null) {
          if (message.notification!.android!.imageUrl != null &&
              message.notification!.android!.imageUrl!.isNotEmpty) {
            _showNotificationWithImage(message);
          } else {
            _showNotification(message);
          }
        }

        _configureSelectNotificationSubject();
        _configureDidReceiveLocalNotificationSubject();
      });

      // if(message.notification!.android!.imageUrl!.isNotEmpty && message.notification!.android!.imageUrl != null){
      //   _showNotificationWithImage(message);
      // }else{
      //   _showNotification(message);
      // }
    });

    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   final routeFromMessage = message.data[""];
    //
    //
    //   // _handleMessage(message);
    //
    //
    //   // showCustomToast(context: context, message: "message");
    //
    //   // if (message.notification!.android!.imageUrl!.isNotEmpty &&
    //   //     message.notification!.android!.imageUrl != null) {
    //   // _showNotificationWithImage(message);
    //   // } else {
    //   // _showNotification(message);
    //   // }
    //
    //   _configureSelectNotificationSubject();
    //   _configureDidReceiveLocalNotificationSubject();
    //
    //
    //   print("routeFromMessage---_$routeFromMessage");
    // });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        PrefData.setInForeground(false);
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        PrefData.setInForeground(false);
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        PrefData.setInForeground(true);
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        PrefData.setInForeground(false);
        print("app in detached");
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    // setupInteractedMessage();

    if (!kIsWeb) {
      initInfo();
    }

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   if (widget.message != null) {
    //     Future.delayed(const Duration(milliseconds: 1000), () async {
    //       String storyId = widget.message!.data["storyId"];
    //
    //             StoryModel? story = await FireBaseData.fetchStory(storyId);
    //
    //             print("story--------------${story!.id}");
    //             Get.to(PopularBookDetailScreen(
    //               storyModel: story,
    //             ));
    //     });
    //   }
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   if (widget.message != null) {
    //     Future.delayed(const Duration(milliseconds: 1000), () async {
    //
    //
    //       String storyId = widget.message!.data["storyId"];
    //
    //       StoryModel? story = await FireBaseData.fetchStory(storyId);
    //
    //       print("story--------------${story!.id}");
    //       Get.to(PopularBookDetailScreen(
    //         storyModel: story,
    //       ));
    //
    //
    //     });
    //   }
    // });

    print("mess----_${widget.message}");
  }
}
