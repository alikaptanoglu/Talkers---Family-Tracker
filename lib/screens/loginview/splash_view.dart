import 'package:development/product/constant/image_enum.dart';
import 'package:flutter/material.dart';
import 'home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

    @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 500),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: ImageEnums.appIcon.assetImage,
            ),
            const SizedBox(height: 10,),
            const Text('Wseen',style: TextStyle(fontSize: 30,color: Color.fromARGB(255, 0, 0, 0),fontWeight: FontWeight.w300),),
          ],
        ),
      )
    );
  }
}