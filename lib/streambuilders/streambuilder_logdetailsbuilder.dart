import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../functions/date.dart';
import '../main.dart';
import '../product/responsive/responsive.dart';

class LogDetailsBuilder extends StatefulWidget {
  const LogDetailsBuilder({Key? key}) : super(key: key);

  @override
  State<LogDetailsBuilder> createState() => _LogDetailsBuilderState();
  
}

class _LogDetailsBuilderState extends State<LogDetailsBuilder> {

  @override
  Widget build(BuildContext context) {
    
    var totalActivities = 0;
    return Obx(() => _logDetailsBuilder(totalActivities),);
  }

  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> _logDetailsBuilder(
      int totalActivities) {
    final _firestore = FirebaseFirestore.instance;
    return StreamBuilder(
        stream: _firestore
            .collection('contacts')
            .doc(controller.documentId.value)
            .collection('logs')
            .where('start',
                isGreaterThanOrEqualTo: controller.startDate.value,
                isLessThanOrEqualTo: controller.endDate.value.add(const Duration(days: 1)))
            .orderBy('start', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          var totalDuration = 0;
          bool isOnline = false;

          if (snapshot.hasData) {
            DateTime onStart = DateTime.now();
            if(snapshot.data!.docs.isNotEmpty){
              isOnline = snapshot.data!.docs.first.get('end') == null ? true : false;
            }

            var i = 0;
            return Column(
              children: snapshot.data!.docs.map((document) {
                totalActivities = snapshot.data!.docs.length;
                final DateTime start;
                final DateTime end;
                Duration diff;

                start = DateTime.parse(formattedDate(document['start']));
                end = document['end'] == null
                    ? DateTime.parse(formattedDate(document['start']))
                    : DateTime.parse(formattedDate(document['end']));
                diff = end.difference(start);

                totalDuration += diff.inSeconds;
                
                document['end'] == null 
                  ? onStart = start
                  : null;

                i++;
                if (i == snapshot.data!.docs.length) {

                  return Row(
                    children: [
                    snapshot.data!.docs.isNotEmpty ? 
                    Container(
                        margin: const EdgeInsets.only(right: 10, left: 20, top: 20),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:Colors.white,),
                        width: Get.width/2 - 30,
                        height: 140,
                        child: Center(child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(parsedJson['totalAc'],style: TextStyle(color: const Color.fromARGB(255, 36, 15, 0),fontWeight: FontWeight.w300,fontSize: SizeConfig().fontSize(18,16)),textAlign: TextAlign.center,), 
                        const SizedBox(height: 5,),
                        Text(totalActivities.toString(),style: TextStyle(fontSize: SizeConfig().fontSize(18,16),color: Colors.black,fontWeight: FontWeight.w400)),
                        ],
                        )),
                      ) : 
                      Container(),
                      snapshot.data!.docs.isNotEmpty ? Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color:Colors.white,),
                        margin: const EdgeInsets.only(right: 20, left: 10, top: 20),
                        width: Get.width/2 - 30,
                        height: 140,
                        child: isOnline
                            ? StreamBuilder(
                                stream:
                                    Stream.periodic(const Duration(seconds: 1)),
                                builder: (context, snapshot) {
                                  final sayac = Duration(
                                      seconds: DateTime.now()
                                          .difference(onStart)
                                          .inSeconds );
                                  return Center(
                                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(parsedJson['totalDur'],style: TextStyle(color: const Color.fromARGB(255, 36, 15, 0),fontWeight: FontWeight.w300,fontSize: SizeConfig().fontSize(18,16)),textAlign: TextAlign.center,), 
                        const SizedBox(height: 5,),
                        Text(printDuration(sayac + totalDuration.seconds),style: TextStyle(fontSize: SizeConfig().fontSize(18,16),color: Colors.black,fontWeight: FontWeight.w400)),
                        ],
                        ),
                                  );
                                },
                              )
                            : 
                            Center(
                                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text(parsedJson['totalDur'],style: TextStyle(color: const Color.fromARGB(255, 36, 15, 0),fontWeight: FontWeight.w300,fontSize: SizeConfig().fontSize(18,16)),textAlign: TextAlign.center,), 
                        const SizedBox(height: 5,),
                        Text(printDuration(totalDuration.seconds),style: TextStyle(fontSize: SizeConfig().fontSize(18,16),color: Colors.black,fontWeight: FontWeight.w400)),
                        ],
                        ),
                                  ),
                      ) : Container(),
                    ],
                  );
                } 
                else {
                  return Container();
                }
              }).toList(),
            );
          } 
          else {
            return Container();
          }
        });
  }
}