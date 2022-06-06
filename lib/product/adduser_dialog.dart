// ignore_for_file: non_constant_identifier_names
import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/Screens/loginView/payment_view.dart';
import 'package:development/product/color/image_color.dart';
import 'package:development/product/dialog/snackbar_dialog.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../controller/project_controller.dart';
import '../../models/user.dart';
import '../../main.dart';
import '../responsive/responsive.dart';
import 'package:country_codes/country_codes.dart';

final TextEditingController _verifyController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _numberController = TextEditingController();
List<String> _firstCharacterList = [];
bool _showFirstCharacter = true;

List<Contact>? contacts;
TextEditingController _contactsController = TextEditingController();

class AddUserDialog extends StatefulWidget {
  final String? contactsNumber;
  final String? contactsName;
  const AddUserDialog({Key? key, this.contactsNumber, this.contactsName}) : super(key: key);

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {


  @override
  void initState() {
    
    _countryCodeInitialization();
    _nameController.clear();

    _contactsController.addListener((){
      controller.contactsText.value = _contactsController.text;
    });

    _verifyController.addListener((){
      controller.verifyController.value = _verifyController.text;
    });

    _numberController.addListener(() {
      controller.numberController.value = _numberController.text;
    });

    _nameController.addListener(() { 
      controller.nameController.value = _nameController.text;
    });

    if(widget.contactsNumber == null){_numberController.clear();}
    else{_numberController.text = widget.contactsNumber!;}
    
    if(widget.contactsName == null){_nameController.clear();}
    else{_nameController.text = widget.contactsName!;}


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      if(widget.contactsNumber == null|| widget.contactsName == null){
        controller.addState.value = 0;
        _verifyController.clear();
        _nameController.clear();
        _numberController.clear();
      }
      return GestureDetector(
        onTap: (){
          Navigator.of(context).pop();
        },
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(0),
          scrollable: false,
          content: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: SizedBox(
              height: SizeConfig.screenHeight,
              width: SizeConfig.screenWidth,
              child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IndexedStack(
                    index: controller.addState.value == 0 ? 0 : controller.addState.value == 1 ? 1 : 2,
                    children: [
                      _phoneState(context),
                      _nameState(context),
                      _verifyState(context)
                    ]),
                ],
              ),),
            ),
          ),
        ),
      );
      
  }

  Column _verifyState(BuildContext context) {
    return Column(
                      children: [
                        _buildVerify(),
                        GestureDetector(
                        onTap: () async {
                          if(controller.verifyController.value.length < 6){
                            null;
                          }
                          else{
                            DocumentSnapshot _snap = await FirebaseFirestore.instance.collection('verifycodes').doc(purchaserInfo!.originalAppUserId).get();
                            if(controller.verifyController.value == _snap.get('verify_code').toString()){
                                if(controller.isSubscribe.value){
                                  DocumentSnapshot _docRef = await FirebaseFirestore.instance.collection('Users').doc(purchaserInfo!.originalAppUserId).get();
                                  if(_docRef.get('contacts') > 0){
                                    ScaffoldMessenger.of(context).showSnackBar(SnackbarDialog().messageFailedOne);
                                    Navigator.of(context).pop();
                                  }else{
                                    Navigator.of(context).pop();
                                    _addUserToDb();
                                  }
                                }
                                else{
                                  Navigator.pushAndRemoveUntil<dynamic>(context,MaterialPageRoute<dynamic>(builder: (BuildContext context) => const PaymentPage()),(route) => false);
                                }
                                }else{
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(SnackbarDialog().messageFailedTwo);
                                }
                          }
                        },
                        child: _stateButton(controller.verifyController.value.length < 6)),
                      ],
                    );
  }

  Column _phoneState(BuildContext context) {
    return Column(
                      children: [
                        _buildAddPhone(context),
                        GestureDetector(
                        onTap:(){
                          if(controller.numberController.isNotEmpty){
                            controller.addState.value = 1;
                          }
                        },
                        child: _stateButton(controller.numberController.isEmpty)),
                      ],
                    );
  }

  Column _nameState(BuildContext context) {
    return Column(
                      children: [
                        _buildAddName(),
                        GestureDetector(
                        onTap:() async {
                          if(IS_COUNTRY_USA){
                            if(controller.nameController.isEmpty){
                              null;
                            }else{
                              DocumentSnapshot _snap = await FirebaseFirestore.instance.collection('verifycodes').doc(purchaserInfo!.originalAppUserId).get();
                              if(_snap.data() != null){
                                await FirebaseFirestore.instance.collection('verifycodes').doc(purchaserInfo!.originalAppUserId).update({
                                  "phone_number": '(${controller.countryCode.value.replaceAll('+', '')})' + controller.numberController.value,
                                  "verify_code": Random().nextInt(899999) + 100000,
                                });
                              }else{
                                FirebaseFirestore.instance.collection('verifycodes').doc(purchaserInfo!.originalAppUserId).set({
                                  "phone_number": controller.countryCode.value.replaceAll('+', '') + controller.numberController.value,
                                  "verify_code": Random().nextInt(899999) + 100000
                                });
                              }
                              
                              controller.addState.value = 2;
                              }
                          }
                          else{
                            if(controller.nameController.isEmpty){
                              null;
                            }else{
                              
                              if(controller.isSubscribe.value){
                                DocumentSnapshot _docRef = await FirebaseFirestore.instance.collection('Users').doc(purchaserInfo!.originalAppUserId).get();
                                if(_docRef.get('contacts') > 0){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackbarDialog().messageFailedOne);
                                  Navigator.of(context).pop();
                                }else{
                                  Navigator.of(context).pop();
                                  _addUserToDb();
                                }
                              }
                              else{
                                Navigator.pushAndRemoveUntil<dynamic>(context,MaterialPageRoute<dynamic>(builder: (BuildContext context) => const PaymentPage()),(route) => false);
                              }
                            }
                          }
                        },
                        child: _stateButton(controller.nameController.isEmpty)),
                      ],
                    );
  }

  Widget _buildVerify(){
    return GestureDetector(
      onTap:(){
        null;
      },
      child: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.red.withOpacity(0.8),Colors.blue.withOpacity(0.8)],begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(2),
        width: double.infinity,
        height: 80,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color.fromARGB(255, 30, 30, 30)),
          child: Row(
            children: [
              const FittedBox(child: Text('Code: ', style: TextStyle(color: Colors.white, fontSize: 18))),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextField(
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    controller: _verifyController,
                    style: const TextStyle(color: Colors.white, fontSize: 20, letterSpacing: 25),
                    decoration: const InputDecoration(
                      counterText: '',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 100, 100, 100))
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0 ),
                      isDense: true,
                    ),
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




  Widget _buildAddName() {
    return GestureDetector(
      onTap:(){
        null;
      },
      child: Container(
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.red.withOpacity(0.8),Colors.blue.withOpacity(0.8)],begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(2),
        width: double.infinity,
        height: 80,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color.fromARGB(255, 30, 30, 30)),
          child: Row(
            children: [
              FittedBox(child: Text(parsedJson['name'], style: const TextStyle(color: Colors.white, fontSize: 18))),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextField(
                    maxLength: 20,
                    controller: _nameController,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                    decoration: const InputDecoration(
                      counterText: '',
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color.fromARGB(255, 100, 100, 100))
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0 ),
                      isDense: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddPhone(BuildContext context) {
    return GestureDetector(
      onTap:(){
        null;
      },
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.red.withOpacity(0.8),Colors.blue.withOpacity(0.8)],begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(2),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color.fromARGB(255, 30, 30, 30)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  child: CountryCodePicker(
                    padding: const EdgeInsets.all(0),
                    flagWidth: double.infinity,
                    showFlagMain: true,
                    onChanged: onCountryChange,
                    initialSelection: WidgetsBinding.instance!.window.locale.countryCode,
                    favorite: [WidgetsBinding.instance!.window.locale.countryCode!],
                    alignLeft: false,
                    hideMainText: true,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => Text(controller.countryCode.value, style: const TextStyle(color: Colors.white, fontSize: 18))),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextField(
                          maxLength: 15,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                          controller: _numberController,
                          style: const TextStyle(color: Colors.white,fontSize: 18),
                          decoration: const InputDecoration(
                            counterText: '',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Color.fromARGB(255, 100, 100, 100))
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: GestureDetector(
                    onTap: () async {
                      await getPhoneData();
                      Navigator.of(context).pop();
                      _contactsController.clear();
                      _contactModal(context);
                    },
                    child: const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.black87,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Image(image: AssetImage('assets/images/ic_addperson.png',),color: Colors.grey, fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _stateButton(_) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: 60,
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20), 
        decoration: BoxDecoration(color: ProjectColors().themeColor.withOpacity(1), border: Border.all(color: _ ? Colors.grey : Colors.white, width: 2), borderRadius: BorderRadius.circular(12)),
        child: Center(child: Text(controller.addState.value == 0 ? parsedJson['continue1'] : controller.addState.value == 1 ? parsedJson['starttrack'] : 'VERIFY', style: TextStyle(color: _ ? Colors.grey : Colors.white, fontSize: 20),)),
      ),
    );
  }

  void _addUserToDb (){
      UserService(
      uid: controller.countryCode.value.toString().toString().replaceAll('+', '') + (_numberController.text.substring(0,1) == '0' ? _numberController.text.substring(1,_numberController.text.length) : _numberController.text))
      .createUserData(
          _nameController.text, 
          purchaserInfo!.originalAppUserId,
          null,
          null,
          controller.countryCode.value.toString().replaceAll('+', '') + (_numberController.text.substring(0,1) == '0' ? _numberController.text.substring(1,_numberController.text.length) : _numberController.text),
          controller.notificationToken.value,
          Timestamp.fromDate(DateTime.now()),
      );
      _nameController.clear();
      _numberController.clear();
    }


  Future<void> _contactModal(BuildContext context) async {
      _firstCharacterList = [];
      int i= 0;
      return showModalBottomSheet<void>(
            isScrollControlled:true,
            backgroundColor: ProjectColors().scaffoldBackgroundColor,
            context: context,builder: (BuildContext context){
            return Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight!/1.1,
              decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),),
              child:  (contacts == null) 
              ? const Center(child: CircularProgressIndicator())
              : Obx(() => Column(
                children: [
                  Container(
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.screenHeight!/12,
                    padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!*3 <= 20 ? SizeConfig.blockSizeHorizontal!*3 : 20),
                    decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(parsedJson['group'], style: TextStyle(color: Colors.blue, fontSize: SizeConfig().fontSize(20, 18),),),
                        Text(parsedJson['contacts'], style: TextStyle(color: Colors.white, fontSize: SizeConfig().fontSize(25,23),fontWeight: FontWeight.bold),),
                        GestureDetector(onTap: (){
                          Navigator.of(context).pop();
                        },child: Text(parsedJson['dialogcancel'], style: TextStyle(color: Colors.blue, fontSize: SizeConfig().fontSize(20, 18),),)),
                      ],
                    ),
                  ),
                  Container(
                    height: SizeConfig.screenHeight!/20,
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!*3 <= 20 ? SizeConfig.blockSizeHorizontal!*3 : 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white.withOpacity(0.05)),
                    child: TextField(
                      controller: _contactsController,
                      style: TextStyle(color: Colors.white, fontSize: SizeConfig().fontSize(20, 18),),
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal! <= 10 ? SizeConfig.blockSizeHorizontal! : 10),
                          child: CircleAvatar(backgroundColor: Colors.transparent,radius: 10,child: SvgPicture.asset('assets/icons/searchIcon.svg', color: controller.contactsText.value.isEmpty  ? Colors.grey : Colors.white)),
                        ),
                        prefixIconConstraints: const BoxConstraints(maxHeight: 15),
                        hintText: parsedJson['search'],
                        hintStyle: TextStyle(color: Colors.grey, fontSize: SizeConfig().fontSize(20, 18),),
                        contentPadding: const EdgeInsets.only(bottom:0),
                        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent,),borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.transparent), borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                  Container(
                    padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical!*3),
                    width: SizeConfig.screenWidth!,
                    height: SizeConfig.screenHeight!/1.1 - (SizeConfig.screenHeight!/20 + SizeConfig.screenHeight!/12),
                    child: ListView.builder(
                    itemCount: contacts!.length,
                    itemBuilder: (BuildContext context,int index){
                      if(i%contacts!.length == 0){
                        print(i%contacts!.length);
                        print('$i + ' ' + $contacts');
                        
                      }
                      String fullName = (contacts![index].name.first.isNotEmpty) ? (contacts![index].name.first + ' ' + (contacts![index].name.last.isNotEmpty ? contacts![index].name.last : '')) : '' ;
                      String number = (contacts![index].phones.length <= 15 && contacts![index].phones.isNotEmpty) ? contacts![index].phones.first.number.replaceAll(' ', '').replaceAll('-', '').replaceAll('(', '').replaceAll(')', '').replaceAll('*', '') : '';
                      if(contacts![index].name.first.isNotEmpty){
                        if(_firstCharacterList.contains(contacts![index].name.first.substring(0,1).toUpperCase())){
                          _showFirstCharacter = false;
                        }else{_firstCharacterList.add(contacts![index].name.first.substring(0,1).toUpperCase());
                          _showFirstCharacter = true;
                        }
                      }
                      if ((controller.contactsText.value.toLowerCase()  == contacts![index].name.first.substring(0,(controller.contactsText.value.length <= contacts![index].name.first.length ? controller.contactsText.value.length : contacts![index].name.first.length)).toLowerCase())) {
                        return Column(
                          children: [
                            _firstCharacterList.isNotEmpty && _contactsController.text.isEmpty && _showFirstCharacter ?
                            _buildFirstCharacter() : const SizedBox(),
                            fullName.isNotEmpty && number.isNotEmpty ? 
                            _buildContactUser(context, number, fullName) : const SizedBox(),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ),
                ],
              ),),
            );
          });
  }

  GestureDetector _buildContactUser(BuildContext context, String number, String fullName) {
    return GestureDetector(
                            onTap:(){
                            Navigator.of(context).pop();
                            showDialog(
                            context: context,
                            builder: (BuildContext context) {
                            return AddUserDialog(contactsNumber: number, contactsName: fullName,);
                            });
                            },
                            child: Container(
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1)),color: Colors.transparent,),
                            height: SizeConfig.screenHeight!/20,
                            width: SizeConfig.screenWidth,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Align(alignment: Alignment.centerLeft,child: Text(fullName, style: TextStyle(fontSize: SizeConfig().fontSize(17, 15),color: Colors.white),)),
                            ),
                          );
  }

  Container _buildFirstCharacter() {
    return Container(
                            decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1)),color: Colors.transparent,),
                            height: SizeConfig.screenHeight!/25,
                            width: SizeConfig.screenWidth,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Align(alignment: Alignment.centerLeft,child: Text(_firstCharacterList.last, style: TextStyle(fontSize: SizeConfig().fontSize(17, 15),color: Colors.grey),)),
                            );
  }

  Future<void> getPhoneData() async {
    if(await FlutterContacts.requestPermission()){
      contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: false);
    }
  }

  Future<void> _countryCodeInitialization() async {
      await CountryCodes.init();
      final CountryDetails _details = CountryCodes.detailsForLocale();
      controller.countryCode.value = _details.dialCode!;
    }
}