import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../product/color/image_color.dart';

DateTimeRange dateRange = DateTimeRange(
      start: controller.startDate.value,
      end: controller.endDate.value);

Future pickDateRange() async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: Get.context!,
      initialDateRange: dateRange,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now(),
      cancelText: 'close',
      confirmText: 'confirm',
      builder: (BuildContext context,Widget? child) {
        return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                    primary: Colors.greenAccent,
                    onPrimary: ProjectColors().themeColor,
                    surface: ProjectColors().themeColor,
                    onSurface: Colors.white,
                    ),
                dialogBackgroundColor: ProjectColors().scaffoldBackgroundColor,
              ),
              child: child!,
            );
      },
    );
    if (newDateRange == null) {
      return;
    } else{
    controller.startDate.value = newDateRange.start;
    controller.endDate.value = newDateRange.end;
    }
  }