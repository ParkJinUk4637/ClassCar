import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';
import '../../../../models/car_info_model.dart';
import '../../../../models/rent.dart';
import '../../main_layout.dart';

class DetailCarPage extends StatefulWidget {
  const DetailCarPage({Key? key, required this.car, required this.driverUid})
      : super(key: key);

  final CarInfoModel car;
  final String driverUid;

  @override
  State<StatefulWidget> createState() => _DetailCarPage();
}

class _DetailCarPage extends State<DetailCarPage> {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late CarInfoModel car = widget.car;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day + 1, DateTime.now().hour, DateTime.now().minute);
  int totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: backAppBar(car.carModel, context),
      body: ListView(
        controller: null,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Image.network("${car.carImgURL?[0]}"),
                ),
              ),
              _dateRangePick(),
              _info()
            ],
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
        color: Color(0xffc9c9c9),
      ))),
      padding: const EdgeInsets.all(12.0),
      height: 80,
      //margin: const EdgeInsets.symmetric(vertical: 24,horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(textAlign: TextAlign.left, "${car.sharingPrice}원/일"),
              Text(textAlign: TextAlign.left, "합계요금 : $totalPrice"),
            ],
          ),
          SizedBox(width: MediaQuery.of(context).size.width / 440 * 200),
          // TextButton(
          //   style: TextButton.styleFrom(
          //     padding: const EdgeInsets.all(12.0),
          //     foregroundColor: Colors.white,
          //     backgroundColor: const Color(0xff1200b3),
          //     textStyle: const TextStyle(fontSize: 16),
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => CarRentPage(car: car),
          //       ),
          //     );
          //   },
          //   child: const Text("대여하기"),
          // )
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(12.0),
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).focusColor,
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => SecondRoute()),
              // );

              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("대여"),
                      content: const Text("대여 하시겠습니까?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("취소"),
                        ),
                        TextButton(
                          onPressed: () async {
                            final Rent rent = Rent(
                                carUid: car.docID,
                                driverUid: widget.driverUid,
                                rentalCost: 100000,
                                // 작업필요
                                rentalEndTime: Timestamp.now(),
                                // 작업필요
                                rentalStartTime: Timestamp.now(),
                                // 작업필요
                                requestDate: Timestamp.now(),
                                situation: "수락대기",
                                ownerUid: car.uuid);
                            await db.collection('Rent').add(rent.toJson());
                            if (!mounted) return;
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const MainLayout(
                                  index: 0,
                                ),
                              ),
                            );
                          },
                          child: const Text("확인"),
                        )
                      ],
                    );
                  });
            },
            child: const Text("대여하기"),
          ),
        ],
      ),
    );
  }

  Widget dateTimeListTile(){
    return ListTile(
      onTap: () async {
        final selectStart = await showDatePicker(
          context: context,
          initialDate: startDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year,
              DateTime.now().month + 1, DateTime.now().day),
        );

        if (!mounted) return;
        final selectEnd = await showDatePicker(
          context: context,
          initialDate : selectStart!,
          firstDate: selectStart,
          lastDate: DateTime(DateTime.now().year,
              DateTime.now().month + 1, DateTime.now().day),
        );

        if (selectEnd!=null &&
            endDate.day != selectStart.day) {
          setState(() {
            startDate = selectStart;
            endDate = selectEnd;
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      "대여 시작 시간 선택",
                      textAlign: TextAlign.center,
                    ),
                    content: hourMinute12HCustomStyle(),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(12.0),
                              foregroundColor: Colors.white,
                              backgroundColor:
                              Theme.of(context).focusColor,
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("완료"),
                          )
                        ],
                      )
                    ],
                  );
                });
          });
        }
      },
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              '대여 : ${startDate.year}년 ${startDate.month}월 ${startDate.day}일 '
                  '${startDate.weekday == 1 ? '월'
                  : startDate.weekday == 2 ? '화'
                  : startDate.weekday==3? '수'
                  : startDate.weekday==4? '목'
                  : startDate.weekday==5? '금'
                  : startDate.weekday==6? '토' : '일'}요일 ${startDate.hour}시 ${startDate.minute}분'),
          Text(
              '반납 : ${endDate.year}년 ${endDate.month}월 ${endDate.day}일 '
                  '${endDate.weekday == 1 ? '월'
                  : endDate.weekday == 2 ? '화'
                  : endDate.weekday==3? '수'
                  : endDate.weekday==4? '목'
                  : endDate.weekday==5? '금'
                  : endDate.weekday==6? '토' : '일'}요일 ${endDate.hour}시 ${endDate.minute}분')
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
    );
  }

  Widget _dateRangePick() {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          child: dateTimeListTile(),
        ),
      ],
    ));
  }

  Widget hourMinute12HCustomStyle() {
    return TimePickerSpinner(
      is24HourMode: true,
      normalTextStyle:
          TextStyle(fontSize: 24, color: Theme.of(context).focusColor),
      highlightedTextStyle:
          TextStyle(fontSize: 24, color: Theme.of(context).focusColor),
      spacing: 50,
      itemHeight: 80,
      isForce2Digits: true,
      minutesInterval: 15,
      onTimeChange: (time) {
        setState(() {
          startDate = DateTime(startDate.year, startDate.month, startDate.day,
              time.hour, time.minute);
          endDate = DateTime(
              endDate.year, endDate.month, endDate.day, time.hour, time.minute);

          totalPrice = (car.sharingPrice! * (endDate.day - startDate.day));
        });
      },
    );
  }

  Widget _info() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            car.carModel,
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
          Text(car.carLocation),
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
    );
  }

  @override
  void initState(){
    totalPrice = car.sharingPrice!;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
