import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';

import '../../../../../models/car.dart';

class CarRentPage extends StatefulWidget {
  const CarRentPage({Key? key, required this.car}) : super(key: key);

  final Car car;

  @override
  State<StatefulWidget> createState() => _CarRentPage();
}

class _CarRentPage extends State<CarRentPage> {
  late Car car = widget.car;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: closeAppBar("${car.carModel} 대여", context),
        body: ListView(
          controller: null,
          children: [
            TextButton(
                onPressed: () {
                  selectDateRangePicker(context);
                },
                child: Text("날짜 선택"))
          ],
        ));
  }

  Future selectDateRangePicker(BuildContext context) async {
    DateTimeRange? pickedRange = await showDateRangePicker(
        context: context,
        initialDateRange:
            DateTimeRange(start: DateTime.now(), end: DateTime.now()),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 2),
        helpText: 'Select Date Range',
        cancelText: 'CANCEL',
        confirmText: 'OK',
        saveText: 'SAVE',
        errorFormatText: 'Invalid format.',
        errorInvalidText: 'Out of range.',
        errorInvalidRangeText: 'Invalid range.',
        fieldStartHintText: 'Start Date',
        fieldEndLabelText: 'End Date');
    if (pickedRange != null) {
      print('picked range ${pickedRange.start} ${pickedRange.end} ${pickedRange.duration.inDays}');
    }
  }
}
