import 'dart:async';
import 'dart:convert';
import 'package:development/Screens/onboard/onboards_view.dart';
import 'package:development/controller/countrycode_controller.dart';
import 'package:development/product/color/image_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

CountryCodeConrtroller controller = Get.put(CountryCodeConrtroller());
var parsedJson;
int? isViewed;
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getInt('onBoard');
  await Firebase.initializeApp(name: 'Wseen',options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
  alert: true,
  announcement: true,
  badge: false,
  carPlay: false,
  criticalAlert: false,
  provisional: false,
  sound: true,
);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const BenimUyg());

}

class BenimUyg extends StatefulWidget {
  const BenimUyg({Key? key}) : super(key: key);

  @override
  State<BenimUyg> createState() => _BenimUygState(); 
}

class _BenimUygState extends State<BenimUyg> {

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  initState(){
    super.initState();
    initMessaging();
    initializeRemoteConfig();
    _messaging.getToken().then((newToken){
      controller.notificationToken.value = newToken!;
    });
  }



  Future<void> initializeRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(minutes: 1),
    ));
    await remoteConfig.fetchAndActivate();
    final messages = remoteConfig.getValue('messages').asString();
    parsedJson = jsonDecode(messages);
  }

  Future<void> initMessaging() async {
  var androidInit = const AndroidInitializationSettings('@drawable/splash');
  var iosInit = const IOSInitializationSettings();
  var initSettings = InitializationSettings(android: androidInit, iOS: iosInit);

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.initialize(initSettings);

  var androidDetails = const AndroidNotificationDetails(
    '1',
    'Default',
    channelDescription: "Channel Description",
    importance: Importance.high,
    priority: Priority.high,
    playSound: true,
    channelShowBadge: false,
    );

  var iosDetails = const IOSNotificationDetails();

  var generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

  ///when app background
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  ///when app terminated
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if(message != null){
    FlutterLocalNotificationsPlugin().show(
      message.notification.hashCode,
      message.notification!.title,
      message.notification!.body,
      generalNotificationDetails
      ); 
    }
  });

  ///when app runned out
  FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification!.android;

  if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          generalNotificationDetails,
        );
      }
  });
}

  @override
  Widget build(BuildContext context) {
  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
    textTheme: GoogleFonts.sourceSansProTextTheme(
      Theme.of(context).textTheme,
    ),
    appBarTheme: AppBarTheme(centerTitle: true,color: ProjectColors().themeColor, elevation: 2),
    scaffoldBackgroundColor: ProjectColors().scaffoldBackgroundColor,
    ),
    home: const OnboardPageOne(),
    //isViewed == 1 ? const PaymentPage() : const OnboardPageOne(),
    );
  }
}
Future<void> firebaseMessagingBackgroundHandler(message) async {
    print('Handling a background Message ${message.messageId}');
    print(message.notification!.title);
    print(message.notification!.body);
    FlutterLocalNotificationsPlugin().show(
    message.notification.hashCode,
    message.notification!.title,
    message.notification!.body,

    const NotificationDetails(
    android: AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    channelDescription: "Channel Description",
    importance: Importance.high,
    priority: Priority.high,
    playSound: true,
    channelShowBadge: false,
    ),
    iOS: IOSNotificationDetails())); 
  }
