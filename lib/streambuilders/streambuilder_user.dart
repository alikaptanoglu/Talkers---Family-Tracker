import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/product/responsive/responsive.dart';
import 'package:development/product/space/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Screens/loginView/logs_view.dart';
import '../functions/user.dart';
import '../main.dart';
import '../product/color/image_color.dart';
import '../product/dialog/snackbar_dialog.dart';

TextEditingController _nameController = TextEditingController();
bool _isNameOk = false;



class UserInfoStreamBuilder extends StatefulWidget {
  const UserInfoStreamBuilder({Key? key}) : super(key: key);

  @override
  State<UserInfoStreamBuilder> createState() => _UserInfoStreamBuilderState();
}

class _UserInfoStreamBuilderState extends State<UserInfoStreamBuilder> {

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() { 
        if(_nameController.text.isEmpty || _nameController.text.contains(RegExp(r'[0-9]'))){
        setState(() {
          _isNameOk = false;
        });
      }else{
        setState(() {
          _isNameOk = true;
        });
      }
    });
  }
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
              controller.isNotEmptyUserData.value = true;
              return _buildUserInfo(snapshot, randomNumber, context);
            } else {
              controller.isNotEmptyUserData.value = false;
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
                    Future.delayed(const Duration(milliseconds: 200),() async {
                      Get.to(() => ShowLogView(documentId: document.id));
                    });
                    },
                  child: Container(
                    height: 80,
                    margin: const EdgeInsets.only(top: 20) +  const EdgeInsets.symmetric(horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!*5 <= 25 ? SizeConfig.blockSizeHorizontal!*5 : 25),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: document['is_online'] ? Colors.green : Colors.red, width: 2),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 20,
                              child: Padding(padding: const EdgeInsets.all(1),child:  Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Image.asset('assets/images/ic_personicon.png',color: Colors.black, fit: BoxFit.cover,)),
                              ),)),
                              Space().spaceWidth(10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                  child: Row(
                                  children: [
                                  Container(
                                    constraints: BoxConstraints(maxWidth: SizeConfig.screenWidth!/2.5),
                                    child: FittedBox(
                                      child: Text(
                                        document['name'],
                                        style: TextStyle(color: Colors.white,fontSize: SizeConfig().fontSize(18,16)),
                                      ),
                                    ),
                                  ),
                                  Space().spaceWidth(4),
                                  Icon(
                                    Icons.edit_note_sharp,
                                    size: 15,
                                    color: Colors.white.withOpacity(0.4),
                                  ),
                                                            ],
                                                          ),
                          onTap: () {
                            _nameController.clear();
                            _changeNameDialog(context, document);
                          },  
                        ),
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
                  left: Get.width/2 - 50,
                  child: Container(
                    decoration: BoxDecoration(color: document['is_online'] ? Colors.green : Colors.red, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),),
                    height: 20,
                    width: 100,
                    child: Center(child: Text(document['is_online'] ? parsedJson['online'] : parsedJson['offline'], style: TextStyle(color: Colors.white, fontSize: SizeConfig().fontSize(12,10)),),)
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
                                        height: (Get.height*3/16) + 10,
                                        child: Column(
                                          children: [
                                            Container(
                                              width: Get.width,
                                              height: Get.height/8,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                      child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            FittedBox(child: Text('${document['name']}, ',style: TextStyle(fontWeight:FontWeight.bold, fontSize: SizeConfig().fontSize(16,14)),)),
                                                            FittedBox(child: Text(parsedJson['dialogquestion'], style: TextStyle(fontSize: SizeConfig().fontSize(16,14)),))
                                                          ])),
                                                  const Divider(color: Colors.grey,height: 1,),
                                                  Expanded(
                                                    child: GestureDetector(
                                                      child: Container(
                                                        width: Get.width,
                                                        decoration: const BoxDecoration(borderRadius:BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),color: Colors.white),
                                                        child: Center(
                                                          child: Text(
                                                            parsedJson['dialogdelete'],
                                                            style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: SizeConfig().fontSize(18,16)),
                                                          ),
                                                        )),
                                                      onTap: () async {
                                                        Navigator.of(context).pop();
                                                        Future.delayed(Duration.zero, () async {
                                                          await UserService(uid: document.id).deleteUserData();
                                                        });
                                                        ScaffoldMessenger.of(context).showSnackBar(SnackbarDialog().messageSuccess);
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Space().spaceHeight(10),
                                            GestureDetector(
                                              child: Container(
                                                height: Get.height/16,
                                                width: Get.width,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(20),
                                                    color: Colors.white),
                                                child: Center(
                                                    child: Text(
                                                  parsedJson['dialogcancel'],
                                                  style: TextStyle(
                                                      color: const Color.fromARGB( 250, 20, 22, 91),
                                                      fontSize: SizeConfig().fontSize(18,16)),
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

  Future<dynamic> _changeNameDialog(BuildContext context, QueryDocumentSnapshot<Object?> document) {
    return showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                insetPadding: const EdgeInsets.all(0),
                                content: Stack(children: [
                                  Container(
                                    decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),color: Colors.white),
                                    height: 180,
                                    width: Get.width,
                                    constraints: const BoxConstraints(maxWidth: 400),
                                    child: Column(children: [
                                      SizedBox(
                                        height: 30,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 10, right: 10),
                                          child: Align(
                                            alignment: Alignment.topRight,
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              icon: const Icon(Icons.close,color: Colors.black,size: 25,),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.symmetric(vertical: 10),
                                        child: TextField(
                                          maxLength: 15,
                                          decoration: InputDecoration(
                                            counterText: "",
                                            suffixIconConstraints: const BoxConstraints(maxHeight: 15,maxWidth: 15),
                                            suffixIcon: _nameController.text.isEmpty ? const SizedBox() : CircleAvatar(radius: 10, backgroundColor: _isNameOk ? Colors.green : Colors.red, child: Icon( _isNameOk ? Icons.check : Icons.close,color: Colors.white,size: 10),),
                                            labelText: parsedJson['dialogname'],
                                            prefixIcon: const Icon(Icons.person),
                                          ),
                                          keyboardType: TextInputType.name,
                                          controller: _nameController,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Container(
                                          constraints: const BoxConstraints(maxWidth: 300),
                                          width: Get.width/3,
                                          child: TextButton(
                                            child: Text(parsedJson['dialogchange'],style: const TextStyle(color: Colors.white),),
                                            style: TextButton.styleFrom(backgroundColor: ProjectColors().themeColor),
                                            onPressed: () {
                                              Future.delayed(Duration.zero, (){
                                              if(!_isNameOk){
                                                return;
                                              }else{
                                                // Name updated 
                                                Navigator.of(context).pop();
                                                UserService(uid: document.id).updateUserName(_nameController.text);
                                                _nameController.clear();
                                                ScaffoldMessenger.of(context).showSnackBar(SnackbarDialog().messageSuccess);
                                              }
                                              });
                                            },
                                          ),
                                        ),
                                      )
                                    ]),
                                  )
                                ]),
                              );
                            });
  }
}
