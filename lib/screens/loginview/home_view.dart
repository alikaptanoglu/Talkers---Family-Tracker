import 'dart:async';
import 'package:development/models/drawer.dart';
import 'package:development/product/color/image_color.dart';
import 'package:development/product/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
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

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      controller.endDate.value = DateTime.now();
      controller.startDate.value = DateTime.now().subtract(const Duration(days: 1));
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: drawer(context),
      appBar: _appBar(),
      body: SizedBox(
        width: Get.width,
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _addNumberButton(context),
          const UserInfoStreamBuilder(),
        ],
        ),
      )
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
      width: Get.width,
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

  checkPermissionCamera()async {
    //var cameraStatus = await Permission.camera.status;
    //var microphoneStatus = await Permission.microphone.status;
    var notificationStatus = await Permission.notification.status;

    //print(cameraStatus);
    //print(microphoneStatus);
    print(notificationStatus);

    //if(!cameraStatus.isGranted) await Permission.camera.request();
    //if(!microphoneStatus.isGranted) await Permission.microphone.request();
    if(!notificationStatus.isGranted) {
      await Permission.notification.request();
    } else{await Permission.notification.request();}

    if(!notificationStatus.isDenied){
      await Permission.notification.request();
    }else{await Permission.notification.request();}

    if(await Permission.notification.isGranted){
        print('openNotification');
      }else{
      print('!!!');
    }
  }
  