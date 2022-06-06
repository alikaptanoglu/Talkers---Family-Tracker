import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:development/models/drawer.dart';
import 'package:development/product/color/image_color.dart';
import 'package:development/product/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../product/dialog/adduser_dialog.dart';
import '../../product/space/space.dart';
import '../../streambuilders/streambuilder_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ConnectivityResult? result;

  @override
  void initState() {
    Future<void> _checkConnection () async {
      Connectivity().onConnectivityChanged.listen((result) { 
        setState(() => this.result = result);
      });
    }
  
    _checkConnection();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      controller.endDate.value = DateTime.now();
      controller.startDate.value = DateTime.now().subtract(const Duration(days: 1));  
    });

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          endDrawer: drawer(context),
          appBar: _appBar(),
          body: SizedBox(
            width: SizeConfig.screenWidth!,
            child: Obx(() => 
            Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _addNumberButton(context),
              controller.isSubscribe.value
              ? const UserInfoStreamBuilder()
              : const SizedBox.shrink(),
            ],
            ),)
          )
        ),
        result == ConnectivityResult.none
        ? AlertDialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        content: SizedBox(height: SizeConfig.screenHeight!, width: SizeConfig.screenWidth!, child: Center(child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('⚠️', style: TextStyle(color: Colors.red, fontSize: 18)),
            SizedBox(width: 5,),
            Text('No internet', style: TextStyle(color: Colors.white, fontSize: 16)),
          ],
        )),),)
        : const SizedBox.shrink()
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
        title: Text(parsedJson['hometitle'],style: TextStyle(fontSize: SizeConfig().fontSize(30,28))),
      );
  }
  
  GestureDetector _addNumberButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
        context: context,
        builder: (BuildContext context) {
        return const AddUserDialog();
        });
      },
    child: Container(
      margin: const EdgeInsets.only(top: 20) + const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.white, width: 1), color: ProjectColors().themeColor),
      height: 60,
      constraints: const BoxConstraints(minHeight: 50),
      width: SizeConfig.screenWidth!,
      child: Center(child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add, size: 20, color: Colors.white),
          Space().spaceWidth(10),
          Text(parsedJson['addnumber'],style: TextStyle(color: Colors.white, fontSize: SizeConfig().fontSize(20,18)),),
        ],
      ),
      ),
      ),
    );
  }
}

  
  // checkPermissionNotification() async {
  //   var notificationStatus = await Permission.notification.status;
  //   if(!notificationStatus.isGranted) {
  //     await Permission.notification.request();
  //   } else{await Permission.notification.request();}
  //   if(!notificationStatus.isDenied){
  //     await Permission.notification.request();
  //   }else{await Permission.notification.request();}
  //   if(await Permission.notification.isGranted){
  //     }else{
  //   }
  // }
  