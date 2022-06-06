import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/product/responsive/responsive.dart';
import 'package:development/product/space/space.dart';
import 'package:flutter/material.dart';
import '../Screens/loginView/logs_view.dart';
import '../models/user.dart';
import '../main.dart';

class UserInfoStreamBuilder extends StatefulWidget {
  const UserInfoStreamBuilder({Key? key}) : super(key: key);

  @override
  State<UserInfoStreamBuilder> createState() => _UserInfoStreamBuilderState();
}

class _UserInfoStreamBuilderState extends State<UserInfoStreamBuilder> {

  @override
  Widget build(BuildContext context) {
    return _userInfo();
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> _userInfo() {
    final _firestore = FirebaseFirestore.instance;
    return StreamBuilder(
        stream: _firestore
            .collection('contacts')
            .where('notification_token', isEqualTo: controller.notificationToken.value)
            //.orderBy('is_online', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          
          int randomNumber = 0;
          if (snapshot.hasData) {
            if (snapshot.data!.docs.isNotEmpty) {
              return _buildUserInfo(snapshot, randomNumber, context);
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        });
  }

  Column _buildUserInfo(AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
    int randomNumber, BuildContext context) {
      SizeConfig().init(context);
    return Column(
      children: snapshot.data!.docs.map((document) {
        randomNumber <= 2 ? randomNumber++ : randomNumber = 0;
        return Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    document['is_online'] == null
                    ? null
                    : Navigator.pushAndRemoveUntil<dynamic>(context,MaterialPageRoute<dynamic>(builder: (BuildContext context) => ShowLogView(documentId: document.id),),(route) => false);
                    },
                  child: Container(
                    height: 80,
                    margin: const EdgeInsets.only(top: 20) +  const EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!*5 <= 25 ? SizeConfig.blockSizeHorizontal!*5 : 25),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: document['is_online'] == null ? Colors.grey : document['is_online'] ?Colors.green : Colors.red, width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              child: Image.asset('assets/images/ic_personicon.png',color: Colors.white, fit: BoxFit.cover,)),
                              Space().spaceWidth(10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth!/2.5),
                                    child: FittedBox(
                                      child: Text(
                                        document['name'],
                                        style: TextStyle(color: Colors.white,fontSize: SizeConfig().fontSize(18,16), fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Space().spaceHeight(2),
                        Text(
                          document.id,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8), fontSize: SizeConfig().fontSize(16,14)),
                        ),
                                ],
                              ),
                            ],
                          ),
                          GestureDetector(
                                child:
                                    const Icon(Icons.delete, color: Colors.red, size: 30),
                                onTap: () async {
                                  await _showDeleteDialog(context, document);
                                }),
                      ],)
                    ),
                  ),
                Positioned(
                  bottom: (80 - 20),
                  left: document['is_online'] == null ? SizeConfig.screenWidth!/2 - 70 : SizeConfig.screenWidth!/2 - 35,
                  child: Container(
                    decoration: BoxDecoration(color: document['is_online'] == null ? Colors.grey : document['is_online']  ?Colors.green : Colors.red, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),),
                    height: 20,
                    width: document['is_online'] == null ? 140 : 70,
                    child: Center(child: FittedBox(child: Text(document['is_online'] == null ? 'Waiting for first login' : document['is_online'] ? parsedJson['online'] : parsedJson['offline'], style: TextStyle(color: Colors.white, fontSize: SizeConfig().fontSize(12,10)),)),)
                  ),
                ),
              ],
            ),
          ],
        );
      }).toList(),
    );
  }

  _showDeleteDialog(BuildContext context, QueryDocumentSnapshot<Object?> document) async {
    showModalBottomSheet<void>(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return SafeArea(
                                      child: Container(
                                        color: Colors.transparent,
                                        height: (SizeConfig.screenHeight!*3/16) + 10,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: SizeConfig.screenWidth!,
                                              height: SizeConfig.screenHeight!/8,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                      child: FittedBox(
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 40),
                                                          child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                FittedBox(child: Text('${document['name']}, ',style: TextStyle(fontWeight:FontWeight.bold, fontSize: SizeConfig().fontSize(18,16)),)),
                                                                FittedBox(child: Text(parsedJson['dialogquestion'], style: TextStyle(fontSize: SizeConfig().fontSize(18,16)),))
                                                              ]),
                                                        ),
                                                      )),
                                                  const Divider(color: Colors.grey,height: 1,),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      child: Container(
                                                        width: SizeConfig.screenWidth!,
                                                        decoration: const BoxDecoration(borderRadius:BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),color: Colors.white),
                                                        child: Center(
                                                          child: Text(
                                                            parsedJson['dialogdelete'],
                                                            style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: SizeConfig().fontSize(22,20)),
                                                          ),
                                                        )),
                                                      onTap: () async {
                                                        Navigator.of(context).pop();
                                                        Future.delayed(Duration.zero, () async {
                                                          await UserService(uid: document.id).deleteUserData();
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Space().spaceHeight(10),
                                            GestureDetector(
                                              child: Container(
                                                height: SizeConfig.screenHeight!/16,
                                                width: SizeConfig.screenWidth!,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    color: Colors.white),
                                                child: Center(
                                                    child: Text(
                                                  parsedJson['dialogcancel'],
                                                  style: TextStyle(
                                                      color: const Color.fromARGB( 250, 20, 22, 91),
                                                      fontSize: SizeConfig().fontSize(22,20)),
                                                )),
                                              ),
                                              onTap: Navigator.of(context).pop,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
  }
}
