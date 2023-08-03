import 'package:flutter/material.dart';

import '../../../../models/car.dart';

class DetailCarPage extends StatefulWidget{
  const DetailCarPage({Key? key, required this.car}): super(key: key);

  final Car car;
  @override
  State<StatefulWidget> createState() => _DetailCarPage();
}

class _DetailCarPage extends State<DetailCarPage>{
  late Car car = widget.car;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("${car.description}"),
          ],
        ) ,
      )
    );
  }

}