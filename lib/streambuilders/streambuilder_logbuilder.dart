import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/product/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/date.dart';
import '../main.dart';


class LogBuilder extends StatelessWidget {
  const LogBuilder({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Obx(() =>  _logBuilder(),);
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> _logBuilder() {
    final _firestore = FirebaseFirestore.instance;
    return StreamBuilder(
      stream: _firestore
          .collection('contacts')
          .doc(controller.documentId.value)
          .collection('logs')
          .where('start',
            isLessThanOrEqualTo: controller.endDate.value.add(const Duration(days: 1)),
            isGreaterThanOrEqualTo: controller.startDate.value)
          .orderBy('start', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData) {
          return _loadingView();
        } 
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty){
          return Container(
          height: 60,
          width: SizeConfig.screenWidth! - 40,
          margin: const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
          child: const Center(child: Text('No Activity', style: TextStyle(color: Colors.black))));
          }
          else{return _logView(snapshot, context);}
        } 
        else {
          return Container();
        }
      },
    );
  }

  Widget _logView(
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot, BuildContext context) {
    return Column(
      children: snapshot.data!.docs.map((document) {
        final DateTime now = DateTime.now();
        final DateTime start;
        final DateTime end;
        Duration diff;
        bool isOnline = document['end'] == null ? true : false;

        start = DateTime.parse(formattedDate(document['start']));
        end = isOnline
            ? DateTime.parse(formattedDate(document['start']))
            : DateTime.parse(formattedDate(document['end']));
        diff = isOnline ? now.difference(start) : end.difference(start);

        return Container(
          height: 80,
          margin: const EdgeInsets.only(top: 20) + const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8), 
            border: Border.all(color: isOnline ? Colors.green : Colors.white, width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _startDate(start),
                      _space(),
                      _startHour(start),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _textDuration(),
                    _space(),
                    _duration(isOnline, start, diff),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _endDate(isOnline, end),
                      _space(),
                      _endHour(isOnline, end),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  SizedBox _space() => const SizedBox(height: 2,);

  Container _startHour(DateTime start) {
    return Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                DateFormat.Hms().format(start),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: SizeConfig().fontSize(16,14),
                                    fontWeight: FontWeight.w700),
                              ));
  }

  Container _startDate(DateTime start) {
    return Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                DateFormat().add_MMMd().format(start),
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: SizeConfig().fontSize(16, 14)),
                              ));
  }

  Container _duration(bool isOnline, DateTime start, Duration diff) {
    return Container(
                            child: isOnline
                                ? _sayac(start)
                                : Text(printDuration(diff), style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: SizeConfig().fontSize(16, 14)),));
  }

  Text _textDuration() {
    return Text(
                          parsedJson['durationtext'],
                          style: TextStyle(
                              color: Colors.black.withOpacity(0.6),
                              fontSize: SizeConfig().fontSize(16, 14)),
                        );
  }

  Container _endHour(bool isOnline, DateTime end) {
    return Container(
                              alignment: Alignment.centerRight,
                              child: isOnline
                                  ? null
                                  : Text(
                                      DateFormat.Hms().format(end),
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: SizeConfig().fontSize(16, 14),
                                          fontWeight: FontWeight.w700),
                                    ));
  }

  Container _endDate(bool isOnline, DateTime end) {
    return Container(
                            child: isOnline
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                      margin:
                                      const EdgeInsets.only(right: 5),
                                          width: 5,
                                          height: 5,
                                          child: const CircleAvatar(
                                          backgroundColor: Colors.green)),
                                          Text(parsedJson['online'],
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: SizeConfig().fontSize(16, 14),
                                              fontWeight: FontWeight.w700)),
                                    ],
                                  )
                                : Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      DateFormat().add_MMMd().format(end),
                                      style: TextStyle(
                                          color:
                                              Colors.black.withOpacity(0.7),
                                          fontSize: SizeConfig().fontSize(16, 14)),
                                    )),
                          );
  }

  StreamBuilder<dynamic> _sayac(DateTime start) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),builder: (context, snapshot) {
        final sayac = Duration(seconds: DateTime.now().difference(start).inSeconds);
        return Center(child: Text(printDuration(sayac),style: TextStyle(
          fontSize: SizeConfig().fontSize(16, 14),color: Colors.black.withOpacity(0.8)),
          ),
        );
      },
    );
  }

  Column _loadingView() {
    return Column(
      children: const [
        Center(
          child: CircularProgressIndicator(),
        ),
        Text('Loading...')
      ],
    );
  }
}



  

  