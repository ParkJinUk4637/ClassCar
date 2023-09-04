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
        appBar: closeAppBar("상세 내역", context),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                pageView(rent.car?['carImgURL']),
                const SizedBox(
                  height: 10,
                ),
                rent.toListTile(),

              ],
            )));
  }

  Widget pageView(List<dynamic> imageUrls){
    return Container(
      height : 200,
      child: PageView.builder(
        physics: const BouncingScrollPhysics(),
        controller: _pageController,
        scrollDirection: Axis.horizontal,
        itemCount: imageUrls.length,
        onPageChanged: (page){
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
              child: Image.network("${imageUrls[index]}",
                fit: BoxFit.cover,
              ),
            ),
          );
        },

      )
    );
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
