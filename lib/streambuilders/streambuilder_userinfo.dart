import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/product/color/image_color.dart';
import 'package:development/product/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../functions/date.dart';
import '../main.dart';
import '../product/space/space.dart';

class TrackedPersonInfo extends StatefulWidget {
  final String documentID;
  const TrackedPersonInfo({ Key? key, required this.documentID}) : super(key: key);

  @override
  State<TrackedPersonInfo> createState() => _TrackedPersonInfoState();
  
}

class _TrackedPersonInfoState extends State<TrackedPersonInfo> {

  @override
  Widget build(BuildContext context) {
    return _trackedPersonInfoBuilder();
  }

  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>_trackedPersonInfoBuilder() {
    final _firestore = FirebaseFirestore.instance;
    return StreamBuilder(
      stream: _firestore.collection('contacts').doc(widget.documentID).snapshots(),
      builder:(BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          var field = snapshot.data;
          return _user(field!);
        } else {
        return Container();
      }
    });
  }

  Container _user(DocumentSnapshot<Object?> field) {
    return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 90,
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)),
            child:_userInfo(field)
          );
  }

  Row _userInfo(DocumentSnapshot<Object?> field) {
    return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _avatarUser(field),
                field.get('is_online')
                    ? _onlineView()
                    : _offlineView(field),
              ],
            );
  }

  Row _avatarUser(DocumentSnapshot<Object?> field) {
    return Row(
                children: [
                  _avatar(),
                  Space().spaceWidth(15),
                  _namePhone(field),
                ],
              );
  }

  Column _namePhone(DocumentSnapshot<Object?> field) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth!/2.5),child: FittedBox(child: Text(field.get('name'), style: TextStyle(fontSize: SizeConfig().fontSize(20,18)),))),
      Space().spaceHeight(4),
      Text(widget.documentID, style: TextStyle(fontSize: SizeConfig().fontSize(16,14),color: Colors.grey)),
    ],
  );
  }

  Column _offlineView(DocumentSnapshot<Object?> field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                              Text(
                                parsedJson['lastseen'],
                                style: TextStyle(color: Colors.green, fontSize: SizeConfig().fontSize(20,18)),
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeVertical!/2,
                              ),
                              Text(
                                DateFormat().add_MMMd().format(
                                        DateTime.parse(formattedDate(
                                            field.get('last_seen')))) +
                                    ', ' +
                                    DateFormat.Hm().format(DateTime.parse(
                                        formattedDate(
                                            field.get('last_seen')))),
                                style: TextStyle(
                                    color: Colors.grey, fontSize: SizeConfig().fontSize(16,14)),
                              )
                            ]);
  }

  Row _onlineView() {
    return Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 6,
                                height: 6,
                                child: CircleAvatar(
                                    backgroundColor:
                                        ProjectColors().onlineColor)),
                            const SizedBox(
                              width: 4,
                            ),
                            Container(
                                margin: const EdgeInsets.only(right: 10),
                                child: Text(parsedJson['online'], style: TextStyle(fontSize: SizeConfig().fontSize(20,18))))
                          ],
                        );
  }

  CircleAvatar _avatar() {
    return CircleAvatar(
                        radius: 25,
                        backgroundColor: controller.isOnline.value
                            ? ProjectColors().onlineColor
                            : ProjectColors().offlineColor,
                        child: CircleAvatar(radius: 24,backgroundColor: Colors.white,child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Image.asset('assets/images/ic_personicon.png', fit: BoxFit.cover,),
                        )),
                      );
  }
}

