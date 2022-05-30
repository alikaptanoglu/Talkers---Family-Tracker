import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../main.dart';
import '../../product/responsive/responsive.dart';
import '../../product/space/space.dart';
import 'home_view.dart';

int value = 0;

class PaymentPage extends StatefulWidget {
  const PaymentPage({ Key? key }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    void set() async {
  Future.delayed(Duration.zero, (){
    setState(() {
  
      });
    });
  }
    set();
    return parsedJson == null
    ? const Center(child: CircularProgressIndicator(),)
    : Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
                  Text(parsedJson['paymentHead'], style: GoogleFonts.roboto(fontSize: SizeConfig().fontSize(45, 40), color:Colors.white,fontWeight: FontWeight.w700,letterSpacing: 1), textAlign: TextAlign.center,),
                  Space().spaceHeight(SizeConfig.blockSizeVertical!*4),
                  _offers(),
                  Space().spaceHeight(SizeConfig.blockSizeVertical!*4),
                  _weeklyButton(),
                  Space().spaceHeight(SizeConfig.blockSizeVertical!*0.75),
                  _yearlyButton(),
                  Space().spaceHeight(SizeConfig.blockSizeVertical!*3),
                  _button(),
                  Space().spaceHeight(SizeConfig.blockSizeVertical!*3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _offers() {
    return Column(
                  children: [
                    _row('assets/icons/ic_cancel.svg',parsedJson['offer1']),
                    Space().spaceHeight(SizeConfig.blockSizeVertical!*1.5),
                    _row('assets/icons/ic_freetrial.svg',parsedJson['offer2']),
                    Space().spaceHeight(SizeConfig.blockSizeVertical!*1.5),
                    _row('assets/icons/ic_instantnotifications.svg',parsedJson['offer3']),
                  ],
                );
  }

  GestureDetector _button() {
    return GestureDetector(
                  onTap: (){
                    Get.to(const HomePage());
                  },
                  child: Container(
                    width: SizeConfig.screenWidth!,
                    height: SizeConfig.screenHeight!/15,
                    margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!*5),
                    constraints: const BoxConstraints(maxWidth: 400, maxHeight: 80, minHeight: 50),
                    decoration: BoxDecoration(color: Color(0xffbff9a5c), borderRadius: BorderRadius.circular(15)),
                    child: Center(child: Text(value == 1 ? parsedJson['buttonannualtext'] : parsedJson['buttonweeklytext'], style:GoogleFonts.poppins(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 1,
                    fontSize: SizeConfig().fontSize(18,16),))),
                  ),
                );
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
                  height: SizeConfig.screenHeight!/15,
                  constraints: const BoxConstraints(maxWidth: 400, maxHeight: 80, minHeight: 50),
                  margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!*5),
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!*5 >= 25 ? 25 : SizeConfig.blockSizeHorizontal!*5),
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
                          Text(parsedJson['annual'], style: TextStyle(color: Colors.white, fontSize: SizeConfig().fontSize(18,16))),
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
                          'Save 90%',style: TextStyle(fontSize: SizeConfig().fontSize(13,12), color: Colors.white),
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
                  height: SizeConfig.screenHeight!/15,
                  constraints: const BoxConstraints(maxWidth: 400, maxHeight: 80, minHeight: 50),
                  margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!*5),
                  padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!*5 >= 25 ? 25 : SizeConfig.blockSizeHorizontal!*5),
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: value == 0 ?  Color(0xffbff9a5c) : Color(0xffbff9a5c).withAlpha(50), width: 2),
                  gradient:LinearGradient(colors: [ Color(0xffbff9a5c).withOpacity(0.0),value == 0 ? Color(0xffbff9a5c).withOpacity(0.4) :Colors.transparent], begin: Alignment.centerLeft, end: Alignment.centerRight),
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
                              border: Border.all(color: value == 0 ?  Color(0xffbff9a5c) :  Color(0xffbff9a5c).withAlpha(50), width: 2),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: CircleAvatar(
                                radius: 7,
                                backgroundColor: value == 0 ?  Color(0xffbff9a5c) : Colors.transparent,
                              ),
                            ),
                          ),
                          Space().spaceWidth(20),
                          Text(parsedJson['weekly'], style: TextStyle(color: Colors.white, fontSize: SizeConfig().fontSize(18,16))),
                        ],
                      ),
                    ],
                  ),
                ));
  }

  Padding _row(icon, text) {
    return Padding(
      padding: EdgeInsets.only(left: SizeConfig.screenWidth!/2- 160 >= SizeConfig.blockSizeHorizontal!*5 ? SizeConfig.screenWidth!/2- 160 : SizeConfig.blockSizeHorizontal!*5),
      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(backgroundColor: Colors.transparent,radius: SizeConfig.blockSizeVertical!*1.5,child: SvgPicture.asset(icon, color: Color(0xffbff9a5c),)),
                      Space().spaceWidth(SizeConfig.screenWidth!/40 >= 15 ? 15 : SizeConfig.screenWidth!/40),
                      Text(text, style: TextStyle(color: Colors.white, fontSize: SizeConfig().fontSize(18,16), fontWeight: FontWeight.w500)),
                    ],
                  ),
    );
  }
}
