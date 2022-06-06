// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables
import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/Screens/loginView/home_view.dart';
import 'package:development/Screens/onboard/onboards_view.dart';
import 'package:development/controller/project_controller.dart';
import 'package:development/models/animatedsplashscreen.dart';
import 'package:development/models/date.dart';
import 'package:development/models/user.dart';
import 'package:development/product/color/image_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final bool IS_COUNTRY_USA  = FirebaseRemoteConfig.instance.getBool('check_country');
String? REVENUE_CAT_API_KEY;
PurchaserInfo? purchaserInfo;
Offerings? offerings; 
Offering? offering;
Package? packageAnnual;
Package? packageWeekly;

ProjectController controller = Get.put(ProjectController());
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
    _initializePurchases();
    _initMessaging();
    _initializeRemoteConfig();
    _messaging.getToken().then((newToken){
      controller.notificationToken.value = newToken!;
    });
  }

  Future<void> _initializeRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(minutes: 1),
    minimumFetchInterval: const Duration(minutes: 1),
    ));
    await remoteConfig.fetchAndActivate();
    final messages = remoteConfig.getValue('messages').asString();
    parsedJson = jsonDecode(messages);
  }

  Future<void> _initializePurchases () async {
    REVENUE_CAT_API_KEY = 'appl_yRUfhCipEFhmWdewvvhCPWSQVVb';
    /// ENABLE/DISABLE DEBUGS LOGS.
    await Purchases.setDebugLogsEnabled(true);

    /// SET API KEY.
    await Purchases.setup(REVENUE_CAT_API_KEY!);

    /// FETCH THE OFFERINGS INFO.
    offerings = await Purchases.getOfferings();

    purchaserInfo = await Purchases.getPurchaserInfo();

    UserService(uid: '').addtoDatabase();
    _checkSubscribe();

    /// FETCH THE OFFERING ENTITLED PREMIUM PLAN 
    offering = offerings!.getOffering('premiumaccessallproducts');

    packageAnnual = offering!.getPackage('\$rc_annual');
    packageWeekly = offering!.getPackage('\$rc_weekly');

    if(!mounted) return;
  }

  Future<void> _checkSubscribe() async {

    DocumentSnapshot _docRef = await FirebaseFirestore.instance.collection('Users').doc(purchaserInfo!.originalAppUserId).get();
    if(_docRef.get('subscribe') == true){
      Duration _diff = DateTime.parse(formattedDate(_docRef.get('expiration_date'))).difference(DateTime.now());
    if(_diff.inSeconds.toInt() <= 0){
      FirebaseFirestore.instance.collection('Users').doc(purchaserInfo!.originalAppUserId).update({
        'subscribe': false,
        'expiration_date': FieldValue.delete(),
        'subscribe_type': FieldValue.delete(),
      });
        controller.isSubscribe.value = false;
        }else{
          controller.isSubscribe.value = true;
        }
      }else{controller.isSubscribe.value = false;}
  }

  Future<void> _initMessaging() async {
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
      message.notification!.hashCode,
      message.notification!.title,
      message.notification!.body,
      generalNotificationDetails
      ); 
    }
  });

  ///when app runned out
  FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
    RemoteNotification? notification = message.notification!;
    AndroidNotification? android = message.notification!.android;

  if (android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          generalNotificationDetails,
        );
      }
  });
}

  void load() async {
    Future.delayed(const Duration(seconds: 3), (){
        setState(() {
  
        });
      });
    }
  @override
  Widget build(BuildContext context) {
  load();
  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(centerTitle: true,color: ProjectColors().themeColor, elevation: 2),
      scaffoldBackgroundColor: ProjectColors().scaffoldBackgroundColor,
    ),
    darkTheme: ThemeData(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(centerTitle: true,color: ProjectColors().themeColor, elevation: 2),
      scaffoldBackgroundColor: ProjectColors().scaffoldBackgroundColor,
    ),
    home: parsedJson == null || offering == null
    ? const SplashScreen()
    : isViewed == 1 ? const HomePage() : const OnboardPageOne(),
    );
  }
}
Future<void> firebaseMessagingBackgroundHandler(message) async {

    FlutterLocalNotificationsPlugin().show(
    message.notification!.hashCode,
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
