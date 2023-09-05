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

  Widget titleText(String text) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }

  Widget miniTitleText(String text) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget contentsText(String text) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }

  Widget rentInfo() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleText(
                "${rent.car?['carModel'] ?? '차 모델'} | ${rent.car?['carNumber'] ?? '차 번호'}"),
            contentsText(""),
            miniTitleText("결제 방식"),
            contentsText("크레딧 결제"),
            contentsText(""),
            miniTitleText("대여/반납 위치"),
            contentsText("${rent.car?['carLocation'] ?? '대여/반납 위치'}"),
            contentsText(""),
            miniTitleText("기름 종류"),
            contentsText("${rent.car?['oilType'] ?? '기름 종류'}"),
            contentsText(""),
            miniTitleText("연비"),
            contentsText("${rent.car?['carGasMil'] ?? '연비'}"),
            contentsText(""),
            miniTitleText("차 종류"),
            contentsText("${rent.car?['carType'] ?? "차 종류"}"),
            contentsText(""),
            miniTitleText("내부 옵션"),
            contentsText((rent.car?['insideOption']['가죽시트'] ? "가죽시트 " : "") +
                (rent.car?['insideOption']['블랙박스'] ? "블랙박스 " : "") +
                (rent.car?['insideOption']['열선시트'] ? "열선시트 " : "") +
                (rent.car?['insideOption']['통풍시트'] ? "통풍시트 " : "")),
            contentsText(""),
            miniTitleText("메이커"),
            contentsText("${rent.car?['maker'] ?? "메이커"}"),
            contentsText(""),
            miniTitleText("안전 장치"),
            contentsText(""
                "${rent.car?['safeOption']['긴급제동시스템'] ? "긴급제동 시스템 " : ""}"
                "${rent.car?['safeOption']['에어백'] ? "에어백 " : ""}"
                "${rent.car?['safeOption']['후방감지센서'] ? "후방감지센서 " : ""}"
                "${rent.car?['safeOption']['후방카메라'] ? "후방카메라 " : ""}"),
            contentsText(""),
            miniTitleText("좌석"),
            contentsText((rent.car?['seats'] != null
                ? "${rent.car?['seats']}인승"
                : "인승")),
            contentsText(""),
            miniTitleText("총 대여 가격"),
            contentsText(
                (rent.totalPrice != null ? "${rent.totalPrice}원" : "총 대여 가격")),
            contentsText(""),
            miniTitleText("기타 옵션"),
            contentsText(""
                "${rent.car?['usabilityOption']['AV시스템'] ? "AV시스템 " : ""}"
                "${rent.car?['usabilityOption']['USB단자'] ? "USB단자 " : ""}"
                "${rent.car?['usabilityOption']['네비게이션'] ? "네비게이션 " : ""}"
                "${rent.car?['usabilityOption']['블루투스'] ? "블루투스" : ""}"
                "${rent.car?['usabilityOption']['하이패스'] ? "하이패스 " : ""}"),
            contentsText(""),
            miniTitleText("연식"),
            contentsText("${rent.car?['years'] ?? "연식"} "),
            contentsText(""),
            miniTitleText("설명"),
            contentsText("${rent.car?['description'] ?? "설"}")
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
