
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';
import '../../../../models/rent.dart';

class DetailRentalPage extends StatefulWidget{
  const DetailRentalPage({Key? key, required this.rent}) : super(key:key);

  final Rent rent;

  @override
  State<StatefulWidget> createState() => _DetailRentalPage();
}

class _DetailRentalPage extends State<DetailRentalPage>{
  late Rent rent = widget.rent;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: closeAppBar("상세 내역", context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            rent.toListTile()
          ],
        )
      )
    );
  }
}