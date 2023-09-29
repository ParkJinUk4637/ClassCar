import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:get/get.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
  final _pageController = PageController(viewportFraction: 0.877);
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  late CarInfoModel car = widget.car;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day + 1, DateTime.now().hour, DateTime.now().minute);
  int totalPrice = 0;
  num currentPage = 0;

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
              pageView(car?.carImgURL),
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
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(textAlign: TextAlign.left, "${car.sharingPrice}원/일"),
                Text(textAlign: TextAlign.left, "합계요금 : $totalPrice"),
              ],
            ),
          ),

          // SizedBox(width: MediaQuery.of(context).size.width / 460 * 200),
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
          Expanded(
            flex: 1,
            child: TextButton(
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
                              payCredit(totalPrice);
                              setCarUnvisible();
                              Navigator.of(context).pop();
                            },
                            child: const Text("확인"),
                          )
                        ],
                      );
                    });
              },
              child: const Text("대여하기"),
            ),
          )
        ],
      ),
    );
  }

  Widget dateTimeListTile() {
    return ListTile(
      onTap: () async {
        final selectStart = await showDatePicker(
          context: context,
          initialDate: startDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1,
              DateTime.now().day - 1),
        );

        if (!mounted) return;
        final selectEnd = await showDatePicker(
          context: context,
          initialDate: DateTime(
              selectStart!.year, selectStart.month, selectStart.day + 1),
          firstDate: DateTime(
              selectStart.year, selectStart.month, selectStart.day + 1),
          lastDate: DateTime(DateTime.now().year, DateTime.now().month + 1,
              DateTime.now().day),
        );

        if (selectEnd != null && selectEnd.day != selectStart.day) {
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
                              backgroundColor: Theme.of(context).focusColor,
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
          Text('대여 : ${startDate.year}년 ${startDate.month}월 ${startDate.day}일 '
              '${startDate.weekday == 1 ? '월' : startDate.weekday == 2 ? '화' : startDate.weekday == 3 ? '수' : startDate.weekday == 4 ? '목' : startDate.weekday == 5 ? '금' : startDate.weekday == 6 ? '토' : '일'}요일 ${startDate.hour}시 ${startDate.minute}분'),
          Text('반납 : ${endDate.year}년 ${endDate.month}월 ${endDate.day}일 '
              '${endDate.weekday == 1 ? '월' : endDate.weekday == 2 ? '화' : endDate.weekday == 3 ? '수' : endDate.weekday == 4 ? '목' : endDate.weekday == 5 ? '금' : endDate.weekday == 6 ? '토' : '일'}요일 ${endDate.hour}시 ${endDate.minute}분')
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

          totalPrice = (car.sharingPrice! *
              int.parse(endDate.difference(startDate).inDays.toString()));
        });
      },
    );
  }

  Future<void> setCarUnvisible() async{
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('Car').doc(car.docID).update({'isExhibit':false});
  }

  Future<void> payCredit(int totalPrice) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await FirebaseFirestore.instance
        .collection('userINFO')
        .where('email', isEqualTo: user?.email)
        .get()
        .then((value) {
      final data = value.docs.first.data();
      final credit = data['credit'];

      if (credit < totalPrice) {
        print("크레딧 부족");
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("크레딧 부족"),
                content: Text("크레딧이 ${(credit - totalPrice)*-1}원 부족합니다"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("확인"),
                  )
                ],
              );
            });
      } else {
        print("요청 시작");
        FirebaseFirestore.instance
            .collection('userINFO')
            .doc(value.docs.first.id)
            .update({"credit": credit - totalPrice}).then((value) async {
          final Rent rent = Rent(
              carUid: car.docID,
              driverUid: widget.driverUid,
              rentalCost: totalPrice,
              // 작업필요
              rentalEndTime: Timestamp.fromDate(endDate),
              // 작업필요
              rentalStartTime: Timestamp.fromDate(startDate),
              // 작업필요
              requestDate: Timestamp.now(),
              situation: "수락대기",
              ownerUid: car.uuid);
          await db.collection('Rent').add(rent.toJson());
          if (!mounted) return;
          setState(() {
            Get.offAll(() => const MainLayout(index: 1,));
          });
        }, onError: (e) {
          print(e);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("크레딧 부족"),
                  content: Text("크레딧이 ${(credit - totalPrice)*-1}원 부족합니다"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("확인"),
                    )
                  ],
                );
              });
        });
      }
    });
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

  Widget pageView(List<dynamic>? imageUrls) {
    return Column(children: [
      SizedBox(
        height: 200,
        child: PageView.builder(
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: imageUrls?.length,
          onPageChanged: (page) {
            setState(() {
              currentPage = page;
            });
          },
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(right: 15),
              width: 350,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(
                  child: CachedNetworkImage(
                    errorWidget: (context, url, error) =>
                    const CircularProgressIndicator(),
                    imageUrl: "${imageUrls?[index]}",
                    placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                  )
                // Image.network(
                //   "${imageUrls?[index]}",
                //   fit: BoxFit.cover,
                // ),
              ),
            );
          },
        ),
      ),
      Container(
          padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
          child:SmoothPageIndicator(
            controller: _pageController,
            count: imageUrls!.length,
            onDotClicked: (index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            },
            effect: WormEffect(
                activeDotColor: Theme.of(context).focusColor,
                dotColor: const Color(0xFFD0D0D0),
                // Theme.of(context)
                //     .colorScheme
                //     .background,
                radius: 6,
                dotHeight: 10,
                dotWidth: 10),
          )),
      Container(
        padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 16.0),
        child: const Divider(
          color : Color(0xFFD0D0D0),
          height: 1,
          thickness: 1,
        ),
      ),
    ]);
  }

  @override
  void initState() {
    totalPrice = car.sharingPrice!;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
