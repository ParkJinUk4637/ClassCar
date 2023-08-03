import 'package:flutter/material.dart';

import '../../../../models/car.dart';

class DetailCarPage extends StatefulWidget {
  const DetailCarPage({Key? key, required this.car}) : super(key: key);

  final Car car;

  @override
  State<StatefulWidget> createState() => _DetailCarPage();
}

class _DetailCarPage extends State<DetailCarPage> {
  late Car car = widget.car;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: ListView(
        controller: null,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "https://taegon.kim/wp-content/uploads/2018/05/image-5.png",
                width: 500,
                fit: BoxFit.fitHeight,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${car.carModel}",
                      textAlign: TextAlign.start,
                    ),
                    Text(
                      "${car.score} (${car.sharedCount}회 대여)",
                    ),
                    const SizedBox(height: 16.0),
                    const Text("대여 날짜"),
                    const Text("날짜 설정"),
                    const SizedBox(height: 16.0),
                    const Text("대여&반납 위치"),
                    Text("${car.carLocation}"),
                    const SizedBox(height: 16.0),
                    const Text("환불 정책"),
                    const Text("환불 정책 내용"),
                    const SizedBox(
                      height: 16.0,
                    ),
                    const Text("차량 추가 정보"),
                    Text("좌석 : ${car.seats}인석"),
                    Text("기름 종류 : ${car.oilType}"),
                    Text("연식 : ${car.years}"),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
