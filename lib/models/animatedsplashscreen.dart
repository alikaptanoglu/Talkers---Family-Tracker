import 'package:development/product/color/image_color.dart';
import 'package:development/product/responsive/responsive.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key,}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool onSplashScreen = false;
  bool textOpacity = false;
  bool imageOpacity = false;
  bool shadowOpacity = false;

  @override
  void initState() {

    super.initState();
    Future.delayed(Duration.zero,() async {
      setState(() {
        onSplashScreen = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 1500),() async {
      setState(() {
        textOpacity = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 1000),() async {
      setState(() {
        imageOpacity = true;
      });
    });
    Future.delayed(const Duration(milliseconds: 1500),() async {
      setState(() {
        shadowOpacity = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SizedBox(
        height: SizeConfig.screenHeight!,
        width: SizeConfig.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                AnimatedContainer(
                  width:  onSplashScreen ? 200 : 60,
                  height:  onSplashScreen ? 200 : 60,
                  duration: const Duration(milliseconds: 500),
                  decoration: BoxDecoration(border: Border.all(color: onSplashScreen ?Colors.orange.withOpacity(0.3) : Colors.orange, width: 1),shape: BoxShape.circle,color: ProjectColors().scaffoldBackgroundColor, boxShadow: [
                        BoxShadow(
                          color: shadowOpacity ? Colors.orange.withOpacity(0.8) : Colors.transparent,
                          offset: const Offset(
                            0.0,
                            0.0,
                          ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                        ), 
                      ],),
                ),
              AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              right: onSplashScreen ? 0 : -50,
              top: 0,
              child: AnimatedOpacity(
              opacity: imageOpacity ? 1 : 0,
              duration: const Duration(milliseconds: 1500),
              child: const Image(image: AssetImage('assets/images/ic_hometransparent.png'),width: 200,height: 200, ) 
              ))
              ],
            ),
            const SizedBox(height: 20,),
            AnimatedOpacity(opacity: textOpacity ? 1 : 0, duration: const Duration(milliseconds: 500), child: const Text('Talkers', style: TextStyle(color: Colors.white, fontSize: 50, fontWeight: FontWeight.bold)),) 
          ],
        ),
      ),
    );
  }
}