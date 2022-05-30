import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/product/color/image_color.dart';
import 'package:development/product/dialog/snackbar_dialog.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../controller/countrycode_controller.dart';
import '../../../functions/user.dart';
import '../../main.dart';
import '../responsive/responsive.dart';
import '../space/space.dart';


final TextEditingController _nameController = TextEditingController();
final TextEditingController _numberController = TextEditingController();
String firstCharacter = ''; 

List<Contact>? contacts;
String? message;
TextEditingController _contactsController = TextEditingController();
int _userTimes = 0;
//final _firestorePhoneNumber = <String>[]; 
//final _firestoreName = <String>[]; 

bool _isPhoneOk = false;
bool _isNameOk = false;

class AddUserDialog extends StatefulWidget {
  final contactsNumber;
  final contactsName;
  const AddUserDialog({Key? key, this.contactsNumber, this.contactsName}) : super(key: key);

  @override
  State<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<AddUserDialog> {


  @override
  void initState() {

    FirebaseFirestore.instance.collection('contacts').get().then((value){
                                for (var element in value.docs) {
                                  if(element.data()['notification_token'] == controller.notificationToken.value){
                                    //_firestorePhoneNumber.add(element.data()['document_id']);
                                    //_firestoreName.add(element.data()['name']);
                                    _userTimes++;
                                  }
                                }
                              });

    _contactsController.addListener((){
      controller.contactsText.value = _contactsController.text;
    });
    _nameController.clear();
    if(widget.contactsNumber == null){_numberController.clear();}
    else{_numberController.text = widget.contactsNumber;}
    if(widget.contactsName == null){_nameController.clear();}
    else{_nameController.text = widget.contactsName;}
    super.initState();
    _numberController.addListener(() {
      controller.numberController.value = _numberController.text;
      if(_numberController.text.length < 6){
          controller.isNumberOk.value = false;
      }else{
        controller.isNumberOk.value = true;
      }
    },);

    _nameController.addListener(() { 
      controller.nameController.value = _nameController.text;
      if(_nameController.text.isEmpty || _nameController.text.contains(RegExp(r'[0-9]'))){
          controller.isNameOk.value = false;
      }else{
        controller.isNameOk.value = true;
        }
    });
  }

  @override
  Widget build(BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(0),
        scrollable: true,
        content: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          width: Get.width,
          height: 250,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Stack(
            children: [
              Column(
                children: <Widget>[
                  const SizedBox(height: 30,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20) +
                        const EdgeInsets.only(bottom: 5),
                    child: Obx(() {
                      return TextField(
                      decoration: InputDecoration(
                        counterText: "",
                        suffixIconConstraints: const BoxConstraints(maxHeight: 15,maxWidth: 15),
                        suffixIcon: controller.nameController.value.isEmpty ? const SizedBox() : CircleAvatar(radius: 10, backgroundColor: controller.isNameOk.value ? Colors.green : Colors.red, child: Icon( controller.isNameOk.value ? Icons.check : Icons.close,color: Colors.white,size: 10),),
                        labelText: parsedJson['dialogname'],
                        prefixIcon: const Icon(Icons.person),
                      ),
                      keyboardType: TextInputType.name,
                      maxLength: 40,
                      controller: _nameController,
                    );
                    },),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: CountryCodePicker(
                            onChanged: onCountryChange,
                            initialSelection: WidgetsBinding.instance!.window.locale.countryCode,
                            favorite: [WidgetsBinding.instance!.window.locale.countryCode!],
                            showCountryOnly: false,
                            showOnlyCountryWhenClosed: false,
                            alignLeft: false,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Obx(() {
                            return TextField(
                            maxLength: 15,
                            decoration: InputDecoration(
                            counterText: "",
                            suffixIconConstraints: const BoxConstraints(maxHeight: 15,maxWidth: 15),
                            suffixIcon: controller.numberController.value.isEmpty ? const SizedBox() : CircleAvatar(radius: 10, backgroundColor: controller.isNumberOk.value ? Colors.green : Colors.red, child: Icon( controller.isNumberOk.value ? Icons.check : Icons.close,color: Colors.white,size: 10),),
                              labelText: parsedJson['dialogphone'],
                              prefixIcon: const Icon(Icons.phone),
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                            controller: _numberController,
                          );
                          },),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Space().expandedSpace,
                        Container(
                          constraints: const BoxConstraints(maxWidth: 300),
                          width: Get.width/3,
                          child: TextButton(
                            child: Text(parsedJson['dialogbuttontext'],style: const TextStyle(color: Colors.white),),
                            style: TextButton.styleFrom(backgroundColor: ProjectColors().themeColor),
                            onPressed: () async {
                              //print(_firestorePhoneNumber!.contains(_numberController.text));
                              Navigator.of(context).pop();
                              if(_nameController.text.isEmpty || _numberController.text.isEmpty){
                                ScaffoldMessenger.of(context).showSnackBar(SnackbarDialog().messageFailedOne);
                                return;
                              }
                              if(!_isNameOk){
                                ScaffoldMessenger.of(context).showSnackBar( SnackbarDialog().messageFailedTwo);
                                return;
                              }
                              else if(!_isPhoneOk){
                                ScaffoldMessenger.of(context).showSnackBar( SnackbarDialog().messageFailedThree);
                                return;
                              }
                              else if(_userTimes >= 1){
                                ScaffoldMessenger.of(context).showSnackBar( SnackbarDialog().messageFailedFour);
                                return;
                              }
                              // else if(_firestorePhoneNumber.contains(_numberController.text)){
                              //   return;
                              // }
                              else{
                              UserService(
                              uid: controller.countryCode.value.toString().toString().replaceAll('+', '') + _numberController.text)
                              .createUserData(
                              false, 
                              _nameController.text, 
                              1,
                              Timestamp.fromDate(DateTime.now()),
                              controller.countryCode.value.toString().replaceAll('+', '') + _numberController.text,
                              controller.notificationToken.value,
                              Timestamp.fromDate(DateTime.now()));
                              _nameController.clear();
                              _numberController.clear();
                              ScaffoldMessenger.of(context).showSnackBar(SnackbarDialog().messageSuccess);
                              }
                            },
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                          onTap: () async {
                          Navigator.of(context).pop();
                          _contactsController.clear();
                          _contactModal(context);
                          Future.delayed(Duration.zero,(){
                            setState(() {
                              
                            });
                          });
                          },
                          child: CircleAvatar(radius: SizeConfig.blockSizeVertical!*2,backgroundColor: Colors.transparent,child: Icon(Icons.contacts, color: ProjectColors().themeColor, size: SizeConfig.blockSizeVertical!*3))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap:(){
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: SizeConfig.blockSizeVertical!*3,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      
  }

  Future<void> _contactModal(BuildContext context) {
    getPhoneData();
      return showModalBottomSheet<void>(
            isScrollControlled:true,
            backgroundColor: ProjectColors().scaffoldBackgroundColor,
            context: context,builder: (BuildContext context){
            return Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight!/1.1,
              decoration: const BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),),
              child:  (contacts == null) ? const Center(child: CircularProgressIndicator()) : 
              Obx(() => Column(
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
                    height: SizeConfig.screenHeight!/25,
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
                    height: SizeConfig.screenHeight!/1.1 - (SizeConfig.screenHeight!/25 + SizeConfig.screenHeight!/12),
                    child: ListView.builder(
                    itemCount: contacts!.length,
                    itemBuilder: (BuildContext context,int index){
                      String fullName = (contacts![index].displayName.isNotEmpty) ? contacts![index].displayName : '---';
                      String number = (contacts![index].phones.length <= 15 ) ? contacts![index].phones.first.number.replaceAll(' ', '').replaceAll('-', '').replaceAll('(', '').replaceAll(')', '').replaceAll('*', '') : '';
                      firstCharacter = (contacts![index].name.first.substring(0,1).toUpperCase() !=  firstCharacter ? contacts![index].name.first.substring(0,1).toUpperCase() : '');
                      if ((controller.contactsText.value.toLowerCase()  == contacts![index].name.first.substring(0,(controller.contactsText.value.length <= contacts![index].name.first.length ? controller.contactsText.value.length : contacts![index].name.first.length)).toLowerCase())) {
                        return Column(
                          children: [
                            firstCharacter.isNotEmpty && _contactsController.text.isEmpty ?
                            Container(
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1)),color: Colors.transparent,),
                              height: SizeConfig.screenHeight!/25,
                              width: SizeConfig.screenWidth,
                              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!*5 <= 20 ? SizeConfig.blockSizeHorizontal!*5 : 20),
                              child: Align(alignment: Alignment.centerLeft,child: Text(firstCharacter, style: TextStyle(fontSize: SizeConfig().fontSize(17, 15),color: Colors.grey),)),
                              ) : const SizedBox(),
                            GestureDetector(
                              onTap:(){
                              Navigator.of(context).pop();
                              _isNameOk = true;
                              _isPhoneOk = true;
                              showDialog(
                              context: context,
                              builder: (BuildContext context) {
                              return AddUserDialog(contactsNumber: number, contactsName: fullName,);
                              });
                              },
                              child: Container(
                              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.1), width: 1)),color: Colors.transparent,),
                              height: SizeConfig.screenHeight!/25,
                              width: SizeConfig.screenWidth,
                              padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!*5 <= 20 ? SizeConfig.blockSizeHorizontal!*5 : 20),
                              child: Align(alignment: Alignment.centerLeft,child: Text(fullName, style: TextStyle(fontSize: SizeConfig().fontSize(17, 15),color: Colors.white),)),
                              ),
                            ),
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
  void getPhoneData() async {
    if(await FlutterContacts.requestPermission()){
    contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: false);
  }
  }
}


