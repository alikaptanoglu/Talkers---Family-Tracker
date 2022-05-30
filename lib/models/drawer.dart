import 'package:development/Screens/loginView/terms_view.dart';
import 'package:development/product/color/image_color.dart';
import 'package:development/product/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';

Drawer drawer(BuildContext context) {
  SizeConfig().init(context);
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: SizeConfig.screenHeight!/7,
          child: DrawerHeader(
            child: Text(
              parsedJson['settings'],
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: ProjectColors().themeColor,
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.security),
          title: Text(parsedJson['privacy']),
          onTap: () => {Get.to(const PrivacyPolicyView())},
        ),
        ListTile(
          leading: const Icon(Icons.file_open),
          title: Text(parsedJson['terms']),
          onTap: () => {Get.to(const TermsOfUseView())},
        ),
        ListTile(
          leading: const Icon(Icons.change_circle),
          title: Text(parsedJson['subscriptions']),
          onTap: () => {Get.to(const AboutSubscriptions())},
        ),
        ListTile(
          leading: const Icon(Icons.star),
          title: Text(parsedJson['rateUs']),
          onTap: () => {Navigator.of(context).pop()},
        ),
      ],
    ),
  );
}
