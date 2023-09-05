import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/app_bar.dart';
import '../../../../models/rent.dart';

class DetailRentalPage extends StatefulWidget {
  const DetailRentalPage({Key? key, required this.rent}) : super(key: key);

  final Rent rent;

  @override
  State<StatefulWidget> createState() => _DetailRentalPage();
}

class _DetailRentalPage extends State<DetailRentalPage> {
  final _pageController = PageController(viewportFraction: 0.877);
  int currentPage = 0;
  late Rent rent = widget.rent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: backAppBar("대여 상세 내역", context),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: ListView(
              children: [
                pageView(rent.car?['carImgURL']),
                Container(
                  height: 10,
                  // color: const Color.fromARGB(255,242,242,242)
                ),
                // const Divider(
                //   height: 1,
                //   thickness: 1,
                // ),
                rentInfo(),
                // carInfo(),
              ],
            )));
  }

  Widget textContainer(String text) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Text(text),
    );
  }

  Widget rentInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textContainer(
                "(완전큰볼드)${rent.car?['carModel'] ?? '차 모델'} | ${rent
                    .car?['carNumber'] ?? '차 번호'}"),
            textContainer(""),
            textContainer("(조금크게)결제 방식"),
            textContainer("크레딧 결제"),
            textContainer(""),
            textContainer("(조금크게)대여/반납 위치"),
            textContainer("${rent.car?['carLocation'] ?? '대여/반납 위치'}"),
            textContainer(""),
            textContainer("(조금크게)기름 종류"),
            textContainer("${rent.car?['oilType'] ?? '기름 종류'}"),
            textContainer(""),
            textContainer("(조금크게)연비"),
            textContainer("${rent.car?['carGasMil'] ?? '연비'}"),
            textContainer(""),
            textContainer("(조금크게)차 종류"),
            textContainer("${rent.car?['carType'] ?? "차 종류"}"),
            textContainer(""),
            textContainer("(조금크게)내부 옵션"),
            textContainer((rent.car?['insideOption']['가죽시트'] ? "가죽시트 " : "")
                + (rent.car?['insideOption']['블랙박스'] ? "블랙박스 " : "")
                + (rent.car?['insideOption']['열선시트'] ? "열선시트 " : "")
                + (rent.car?['insideOption']['통풍시트'] ? "통풍시트 " : "")),
            textContainer(""),
            textContainer("(조금 크게)메이커"),
            textContainer("${rent.car?['maker'] ?? "메이커"}"),
            textContainer(""),
            textContainer("(조금 크게)안전 장치"),
            textContainer(""
                "${rent.car?['safeOption']['긴급제동시스템'] ? "긴급제동 시스템 " : ""}"
                "${rent.car?['safeOption']['에어백'] ? "에어백 " : ""}"
                "${rent.car?['safeOption']['후방감지센서'] ? "후방감지센서 " : ""}"
                "${rent.car?['safeOption']['후방카메라'] ? "후방카메라 " : ""}"),
            textContainer(""),
            textContainer("(조금 크게)좌석"),
            textContainer((rent.car?['seats'] != null? "${rent.car?['seats']}인승" : "인승")),
            textContainer(""),
            textContainer("(조금 크게)총 대여 가격"),
            textContainer((rent.totalPrice != null? "${rent.totalPrice}원" : "총 대여 가격")),
            textContainer(""),
            textContainer("(조금크게)기타 옵션"),
            textContainer(""
                "${rent.car?['usabilityOption']['AV시스템'] ? "AV시스템 " : ""}"
                "${rent.car?['usabilityOption']['USB단자'] ? "USB단자 " : ""}"
                "${rent.car?['usabilityOption']['네비게이션'] ? "네비게이션 " : ""}"
                "${rent.car?['usabilityOption']['블루투스'] ? "블루투스" : ""}"
                "${rent.car?['usabilityOption']['하이패스'] ? "하이패스 " : ""}"),
            textContainer(""),
            textContainer("(조금크게)연식"),
            textContainer("${rent.car?['years'] ?? "연식"} "),
            textContainer(""),
            textContainer("(조금크게)설명"),
            textContainer("${rent.car?['description'] ?? "설"}")
          ]),
    );
  }

  // Widget carInfo(){
  //   return Container(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         textContainer("(볼드제목)차량 정보"),
  //         textContainer("(내용)${rent.car?['carNumber'] ?? '차 번호'}"
  //             "| ${rent.car?['carModel'] ?? '차 모델'}"),
  //       ],
  //     )
  //   );
  // }

  Widget pageView(List<dynamic> imageUrls) {
    return SizedBox(
        height: 200,
        child: PageView.builder(
          physics: const BouncingScrollPhysics(),
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          itemCount: imageUrls.length,
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
                child: Image.network(
                  "${imageUrls[index]}",
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ));
  }

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page as int;
        print(currentPage);
      });
    });
    super.initState();
  }

  // 해당 클래스 사라질 때
  @override
  void dispose() {
    super.dispose();
  }
}
