import 'package:development/main.dart';
import 'package:development/product/responsive/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'datarangepicker.dart';

class DateWidget extends StatelessWidget {
  const DateWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => _dateWidget(),);
  }
}

GestureDetector _dateWidget() {
    return GestureDetector(
      onTap: () {
        pickDateRange();
      },
      child: Container(
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.white),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.symmetric(horizontal: 20) + const EdgeInsets.only(top: 20),
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(DateFormat.MMMd().format(controller.startDate.value),
                      style: TextStyle(
                          color: Colors.black, fontSize: SizeConfig().fontSize(16, 14))),
                  Text(' - ', style: TextStyle(fontSize: SizeConfig().fontSize(16, 14))),
                  Text(DateFormat.MMMd().format(controller.endDate.value),
                    style:
                        TextStyle(color: Colors.black, fontSize: SizeConfig().fontSize(16, 14)),
                  )
                ],
              ),
              const Icon(
                Icons.calendar_today,
                size: 25,
                color: Colors.grey,
              ),
            ],
          )),
    );
  }