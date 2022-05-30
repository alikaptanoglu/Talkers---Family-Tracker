import 'package:development/product/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../main.dart';
import '../loginView/deneme/color.dart';
import '../loginView/payment_view.dart';


_storeOnBoardInfo() async {
  int isViewed = 1;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setInt('onBoard', isViewed);
}


Column buildOnboard(ImageProvider<Object> image, String header, String text,int index){
    return Column(
    children: [
    Container(
      decoration: BoxDecoration(
      gradient: ProjectColors().gradient()),
      child: Container(
        height: Get.height - Get.height/3,
        width: Get.width,
        decoration: BoxDecoration(image: DecorationImage(image: image, colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.8), BlendMode.dstIn),fit: SizeConfig.screenWidth! >= 600 ? BoxFit.none : BoxFit.cover)),
        ),
    ),
    Container(
    height: Get.height/3,width: Get.width,color: ProjectColors().homeColor(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
      Container(margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!*5),child: Text(header, style: GoogleFonts.sourceSansPro(fontSize: SizeConfig().fontSize(32,30), color: Colors.white, fontWeight: FontWeight.w900,decoration: TextDecoration.none,))),
      Container(margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!*5),child: Text(text, style: GoogleFonts.sourceSansPro(fontSize: SizeConfig().fontSize(20,18), color:Colors.white, fontWeight: FontWeight.w300,decoration: TextDecoration.none,),textAlign: TextAlign.center)),
      AnimatedSmoothIndicator(
      activeIndex: index, 
      count: route.length,
      effect: ExpandingDotsEffect(
        spacing: SizeConfig.blockSizeVertical!,
        activeDotColor: Color(0xffbff9a5c) ,
        dotColor: Colors.white.withOpacity(0.2),
        dotWidth: SizeConfig.blockSizeVertical!,
        dotHeight: SizeConfig.blockSizeVertical!),
    ),
      GestureDetector(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal!*5),
          width: Get.width,
          constraints: const BoxConstraints(maxWidth: 400, maxHeight: 80, minHeight: 50),
          height: SizeConfig.screenHeight!/15,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Color(0xffbff9a5c) ,),
          child: Center(
            child: Text(
              parsedJson['continue'],
              style: GoogleFonts.poppins(
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              letterSpacing: 1,
              fontSize: SizeConfig().fontSize(18,16),),))),onTap:() async {
              index == 2 ? await _storeOnBoardInfo() : null;
              Get.to(route[index]);
      }),
    ]),),
  ],);
  }

  List route = [
    const OnboardPageTwo(),
    const OnboardPageThree(),
    const PaymentPage(),
  ];
  

class OnboardPageOne extends StatefulWidget {
  const OnboardPageOne({ Key? key }) : super(key: key);

  @override
  State<OnboardPageOne> createState() => _OnboardPageOneState();
}

class _OnboardPageOneState extends State<OnboardPageOne> {

  

  @override
  Widget build(BuildContext context) {
  void set() async {
  Future.delayed(Duration.zero, (){
    setState(() {
  
      });
    });
  }
    set();
    SizeConfig().init(context);
    return parsedJson == null
    ? const Scaffold(body: Center(child: CircularProgressIndicator()))
    : buildOnboard(const AssetImage('assets/images/ic_denemeonboardbackthree.png'), parsedJson['title1'],parsedJson['text1'], 0);
  }
}

class OnboardPageTwo extends StatelessWidget {
  const OnboardPageTwo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return buildOnboard(const AssetImage('assets/images/ic_denemeonboardbackone.png'), parsedJson['title2'],parsedJson['text2'], 1);
  }
}

class OnboardPageThree extends StatelessWidget {
  const OnboardPageThree({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return buildOnboard(const AssetImage('assets/images/ic_denemeonboardbacktwo.png'), parsedJson['title3'], parsedJson['text3'], 2);
  }
}


