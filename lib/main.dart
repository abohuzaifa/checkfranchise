import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:franchise_app/screens/bottom_bar_screen/bottom_bar_screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:franchise_app/screens/welcome/welcome_view.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'fcm_handle.dart';
import 'firebase_options.dart';
import 'languages/languages.dart';
import 'ssl.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  print("message.data: ${message.notification!.title}");
}

String? fcmToken;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
         options: DefaultFirebaseOptions.currentPlatform
        );
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await getFCMToken();
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

Future<String?> getFCMToken() async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // Request permission to receive notifications
    NotificationSettings settings = await messaging.requestPermission();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Get the token
      fcmToken = await messaging.getToken();
      if (fcmToken != null) {
        print(
            'FCM Token     >>>>>>>>>>>>>>>>>>>> $fcmToken <<<<<<<<<<<<<<<<<<');
        return fcmToken;
      } else {
        print('Failed to retrieve FCM Token');
        return null;
      }
    } else {
      print('User denied notification permissions');
      return null;
    }
  } catch (e) {
    print('Error fetching FCM Token: $e');
    return null;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final String savedLanguage = GetStorage().read('selectedLanguage') ?? 'en';
  final _messagingService = MessagingService();
  RemoteMessage? _initialMessage;
  bool _isSplashDone = false;

  @override
  void initState() {
    super.initState();
    _messagingService.init(context);
  }

  void _handleMessage(RemoteMessage message) {
    // Navigate to the desired screen with the message data
    if (message.notification?.title == 'New Message') {
      // Get.to(() => ChatPage(message: message));
    } else if (message.notification?.title == 'Accept Offer') {}
  }

  void _setupInteractedMessage() async {
    // Get the initial message
    _initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // If the initial message is not null, it means the app was opened via a notification
    if (_initialMessage != null) {
      _navigateToInitialRoute();
    }

    // Handle interaction when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _handleMessage(message);
    });
  }

  void _navigateToInitialRoute() {
    if (_isSplashDone && _initialMessage != null) {
      _handleMessage(_initialMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: savedLanguage == 'ar'
          ? const Locale('ar', 'AR')
          : const Locale('en', 'US'),
      translations: Languages(),
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
      home: GetStorage().read("token") == null
          ? WelcomeView()
          : BottomBarScreen(),
    );
  }
}
