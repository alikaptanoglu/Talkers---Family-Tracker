// ignore_for_file: use_full_hex_values_for_flutter_colors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:development/Screens/loginView/terms_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../main.dart';
import '../../product/responsive/responsive.dart';
import '../../product/space/space.dart';
import 'home_view.dart';

int value = 0;
PurchaserInfo _purchaserInfo = purchaserInfo!;

class PaymentPage extends StatefulWidget {
  const PaymentPage({ Key? key }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {

  @override
  void initState() {
    // Purchases.addPurchaserInfoUpdateListener((_purchaserInfo) { 
    //     if(_purchaserInfo.entitlements.active.containsKey('Premium')){
    //       Navigator.pushAndRemoveUntil<dynamic>(context,MaterialPageRoute<dynamic>(builder: (BuildContext context) => const HomePage()),(route) => false);
    //     }
    // });
    super.initState();
  }

  Future<void> _purchasePackage ({required Package package}) async {
    try{
      /// PURCHASE THE PACKAGE.
      await Purchases.purchasePackage(package);

      /// REBUILD PAGE
      setState(() {});
    } on PlatformException catch (e){
      /// FETCH THE ERROR CODE FROM THE EXCEPTION
      PurchasesErrorCode errorCode = PurchasesErrorHelper.getErrorCode(e);
      if(errorCode != PurchasesErrorCode.purchaseCancelledError){
        debugPrint(e.message);
      }
    }
  }

  bool _entitlementActive({required PurchaserInfo purchaserInfo}){
    return purchaserInfo.entitlements.active.containsKey('Premium');
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
      return Scaffold(
      body: Stack(
        children: [
          SafeArea(
            top:false,
            child: Container(
              height: SizeConfig.screenHeight!,
              width: SizeConfig.screenWidth!,
              decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/ic_denemeonboardbacktwo.png'),alignment: Alignment.topCenter),
              gradient: LinearGradient(colors: [Color.fromARGB(255, 21, 21, 29),  Color.fromARGB(255, 24, 20, 36), Color.fromARGB(255, 34, 24, 59),],begin: Alignment.center, end: Alignment.topCenter)),
              child: Container(
                height: SizeConfig.screenHeight!,
                width: SizeConfig.screenWidth!,
                decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(colors: [const Color.fromARGB(255, 21, 21, 29),const Color.fromARGB(255, 15, 15, 23),const Color.fromARGB(255, 5, 5, 13),Colors.black,Colors.black.withOpacity(0.6)], stops: const [0.30, 0.35, 0.4, 0.45, 0.6], begin: Alignment.bottomCenter, end: Alignment.topCenter)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(parsedJson['paymentHead'], style: GoogleFonts.roboto(fontSize: SizeConfig().fontSize(40, 35), color:Colors.white,fontWeight: FontWeight.w700,letterSpacing: 1), textAlign: TextAlign.center,),
                    Space().spaceHeight(SizeConfig.blockSizeVertical!*4),
                    _offers(),
                    Space().spaceHeight(SizeConfig.blockSizeVertical!*4),
                    _weeklyButton(),
                    Space().spaceHeight(SizeConfig.blockSizeVertical!*0.75),
                    _yearlyButton(),
                    Space().spaceHeight(SizeConfig.blockSizeVertical!*3),
                    _button(),
                    Space().spaceHeight(SizeConfig.blockSizeVertical!*3),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(child: _route(context,parsedJson['paylinktext1'], const PrivacyPolicyView())),
                          _divider(),
                          Expanded(child: _route(context,parsedJson['paylinktext2'], const TermsOfUseView())),
                          _divider(),
                          Expanded(child: _route(context,parsedJson['paylinktext3'], const AboutSubscriptions())),
                          _divider(),
                          Expanded(
                            child: GestureDetector(
                            onTap:() async {
                              restorePurchases();
                            },
                            child: Text(parsedJson['paylinktext4'], style: const TextStyle(color: Colors.white,fontSize: 10),textAlign: TextAlign.center,)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            top: 20,
            child: SafeArea(
            child: GestureDetector(
              onTap: (){
                Navigator.of(context).pushAndRemoveUntil<dynamic>(MaterialPageRoute<dynamic>(builder: (BuildContext context) => const HomePage()), ModalRoute.withName('/'));
              },
              child: const Icon(Icons.close, color: Colors.white, size: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _divider() => Container(margin: const EdgeInsets.symmetric(horizontal: 10),height: 10, width: 1, color: Colors.grey,);

  Widget _route(BuildContext context, String text, route) {
    return GestureDetector(
      onTap:(){
        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => route));
      },
    child: Text(text, style: const TextStyle(color: Colors.white,fontSize: 10),textAlign: TextAlign.center,));
  }

  Column _offers() {
    return Column(
                  children: [
                    Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                      height: 20,
                      width: 40,
                      child: Image(image: AssetImage('assets/images/ic_cancelanytime.png'),fit: BoxFit.cover,color: Color(0xffbff9a5c),)),
                      Space().spaceWidth(10),
                      Text(parsedJson['offer1'], style: TextStyle(color: Colors.white, fontSize: SizeConfig().fontSize(18,16), fontWeight: FontWeight.w500)),
                    ],
                    ),),
                    Space().spaceHeight(15),
                    _row('assets/icons/ic_freetrial.svg',parsedJson['offer2']),
                    Space().spaceHeight(15),
                    _row('assets/icons/ic_instantnotifications.svg',parsedJson['offer3']),
                  ],
                );
  }

  GestureDetector _button() {
    return GestureDetector(
                  onTap: () async {
                      if(value == 0 ) {
                        await _purchasePackage(package: packageWeekly!);
                          if(!_entitlementActive(purchaserInfo: _purchaserInfo)){
                            null;
                          }
                          else{
                            addWeeklySubscriptiontoDatabase();
                          }
                      }
                      if(value == 1) {
                        await _purchasePackage(package: packageAnnual!);
                          if(!_entitlementActive(purchaserInfo: _purchaserInfo)){
                            null;
                          }else{
                            addAnnualSubscriptiontoDatabase();
                          }
                      }
                  },
                  
                  child: Container(
                    width: SizeConfig.screenWidth!,
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    constraints: const BoxConstraints(maxWidth: 400, maxHeight: 80, minHeight: 50),
                    decoration: BoxDecoration(color: const Color(0xffbff9a5c), borderRadius: BorderRadius.circular(15)),
                    child: Center(child: FittedBox(
                      child: Text(value == 1 ? parsedJson['buttonannualtext'] : parsedJson['buttonweeklytext'], style:GoogleFonts.poppins(
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 1,
                      fontSize: SizeConfig().fontSize(18,16),)),
                    )),
                  ),
                );
  }

  Future<void> restorePurchases() async {
                                try {
                                  PurchaserInfo restoredInfo = await Purchases.restoreTransactions();
                                  // ... check restored purchaserInfo to see if entitlement is now active
                                    if(!restoredInfo.entitlements.all['Premium']!.isActive){
                                      FirebaseFirestore.instance.collection('Users').doc(restoredInfo.originalAppUserId).update({
                                        'subscribe': false,
                                        'expiration_date': FieldValue.delete(),
                                        'subscribe_type': FieldValue.delete(),
                                      });
                                    }
                                  } on PlatformException catch (e) {
                                    print(e);
                                  // Error restoring purchases
                                }
                              }
  
  Future<void> addAnnualSubscriptiontoDatabase() async {
                              controller.isSubscribe.value = true;
                              await FirebaseFirestore.instance.collection('Users').doc(_purchaserInfo.originalAppUserId).update({
                                'expiration_date': DateTime.parse(DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.now().add(const Duration(days: 365)))),
                                'subscribe': true,
                                'subscribe_type': 'annual'
                              });
                            // await FirebaseFirestore.instance.collection('Users').doc(_purchaserInfo.originalAppUserId).update({
                            //   'user_id': _purchaserInfo.originalAppUserId,
                            //   'expiration_date': DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.parse(_purchaserInfo.entitlements.all['Premium']!.expirationDate!)), 
                            //   'subscribe': _purchaserInfo.entitlements.all['Premium']!.isActive,
                            //   'subscribe_type': _purchaserInfo.entitlements.all['Premium']!.productIdentifier,
                            // });
                              Navigator.of(context).pushAndRemoveUntil<dynamic>(MaterialPageRoute<dynamic>(builder: (BuildContext context) => const HomePage()), ModalRoute.withName('/'));
                            }

  Future<void> addWeeklySubscriptiontoDatabase() async{
                              controller.isSubscribe.value = true;
                              // await FirebaseFirestore.instance.collection('Users').doc(_purchaserInfo.originalAppUserId).update({
                            //   'user_id': _purchaserInfo.originalAppUserId,
                            //   'expiration_date': DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.parse(_purchaserInfo.entitlements.all['Premium']!.expirationDate!)), 
                            //   'subscribe': _purchaserInfo.entitlements.all['Premium']!.isActive,
                            //   'subscribe_type': _purchaserInfo.entitlements.all['Premium']!.productIdentifier,
                            // });
                              await FirebaseFirestore.instance.collection('Users').doc(_purchaserInfo.originalAppUserId).update({
                                'expiration_date': DateTime.parse(DateFormat('yyyy-MM-dd kk:mm:ss').format(DateTime.now().add(const Duration(days: 7)))),
                                'subscribe': true,
                                'subscribe_type': 'weekly'
                              });
                              Navigator.of(context).pushAndRemoveUntil<dynamic>(MaterialPageRoute<dynamic>(builder: (BuildContext context) => const HomePage()), ModalRoute.withName('/'));
                            }

  GestureDetector _yearlyButton() {
    return GestureDetector(
                onTap: (){
                  setState(() {
                    value = 1;
                  });
                },
                child: Container(
                  width: SizeConfig.screenWidth!,
                  height: 60,
                  constraints: const BoxConstraints(maxWidth: 400, maxHeight: 80, minHeight: 50),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: value == 1 ? const Color(0xffbff9a5c): const Color(0xffbff9a5c) .withAlpha(50), width: 2),
                  gradient:LinearGradient(colors: [const Color(0xffbff9a5c).withOpacity(0.0),value == 1 ?const Color(0xffbff9a5c).withOpacity(0.4) :Colors.transparent], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: value == 1 ? const Color(0xffbff9a5c) : const Color(0xffbff9a5c).withAlpha(50), width: 2),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: CircleAvatar(
                                radius: 7,
                                backgroundColor: value == 1 ? const Color(0xffbff9a5c) : Colors.transparent,
                              ),
                            ),
                          ),
                          Space().spaceWidth(20),
                          Text(packageAnnual!.product.priceString + ' ' + parsedJson['annual'], style: TextStyle(color: Colors.white, fontSize: SizeConfig().fontSize(18,16))),
                        ],
                      ),
                      Container(
                        width: 70,
                        height: 25,
                        decoration: BoxDecoration(
                          color: const Color(0xffbff9a5c),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(child: Text(
                          parsedJson['save'],style: TextStyle(fontSize: SizeConfig().fontSize(11,10), color: Colors.white),
                        )),
                      ),
                    ],
                  ),
                ));
  }

  GestureDetector _weeklyButton() {
    return GestureDetector(
                onTap: (){
                  setState(() {
                    value = 0;
                  });
                },
                child: Container(
                  width: SizeConfig.screenWidth!,
                  height: 60,
                  constraints: const BoxConstraints(maxWidth: 400, maxHeight: 80, minHeight: 50),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: value == 0 ?  const Color(0xffbff9a5c) : const Color(0xffbff9a5c).withAlpha(50), width: 2),
                  gradient:LinearGradient(colors: [ const Color(0xffbff9a5c).withOpacity(0.0),value == 0 ? const Color(0xffbff9a5c).withOpacity(0.4) :Colors.transparent], begin: Alignment.centerLeft, end: Alignment.centerRight),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: value == 0 ?  const Color(0xffbff9a5c) :  const Color(0xffbff9a5c).withAlpha(50), width: 2),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: CircleAvatar(
                                radius: 7,
                                backgroundColor: value == 0 ?  const Color(0xffbff9a5c) : Colors.transparent,
                              ),
                            ),
                          ),
                          Space().spaceWidth(20),
                          Text(packageWeekly!.product.priceString + ' ' + parsedJson['weekly'], style: TextStyle(color: Colors.white, fontSize: SizeConfig().fontSize(18,16))),
                        ],
                      ),
                    ],
                  ),
                ));
  }

  Padding _row(icon, text) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Space().spaceWidth(10),
                      CircleAvatar(backgroundColor: Colors.transparent,radius: 10,child: SvgPicture.asset(icon, color: const Color(0xffbff9a5c),)),
                      Space().spaceWidth(22),
                      Text(text, style: TextStyle(color: Colors.white, fontSize: SizeConfig().fontSize(18,16), fontWeight: FontWeight.w500)),
                    ],
                  ),
    );
  }
}



