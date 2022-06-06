import 'package:development/Screens/loginView/home_view.dart';
import 'package:development/models/datewidget.dart';
import 'package:development/models/drawer.dart';
import 'package:development/product/responsive/responsive.dart';
import 'package:development/streambuilders/streambuilder_logdetailsbuilder.dart';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../streambuilders/streambuilder_logbuilder.dart';
import '../../streambuilders/streambuilder_userinfo.dart';


class ShowLogView extends StatefulWidget {
  final String documentId;

  const ShowLogView({Key? key, required this.documentId,}) : super(key: key);

  @override
  State<ShowLogView> createState() => _ShowLogViewState();
}

class _ShowLogViewState extends State<ShowLogView> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
    controller.documentId.value = widget.documentId;
    });
  }
  

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: _decoration(),
      child: Scaffold(
        endDrawer: _drawer(context),
        appBar: _appBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TrackedPersonInfo(documentID: widget.documentId),
                    const DateWidget(),
                    const LogDetailsBuilder(),
                    const LogBuilder(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.chevron_left_outlined, size: 30),
        onPressed: (){
          Navigator.pushAndRemoveUntil<dynamic>(context,MaterialPageRoute<dynamic>(builder: (BuildContext context) => const HomePage(),),(route) => false);
          },
      ),
      title: Text(parsedJson['logpagetitle'], style: TextStyle(fontSize: SizeConfig().fontSize(28,26)),),
    );
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
      child: drawer(context),
    );
  }

  BoxDecoration _decoration() {
    return const BoxDecoration(color: Colors.white);
  }
}