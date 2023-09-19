import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/my_page/my_page.dart';
import 'package:my_classcar/layouts/main_page/my_rental/my_rental.dart';

import '../../component/const/name_const.dart';
import 'main_page/main_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<StatefulWidget> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final String projectName = NameConst.projectName.name;
  final List<Widget> _widgetOptions = <Widget>[
    const MainPage(),
    // Text("h"),
    const MyRental(),
    // const Text('DM'),
    const MyPage(),
  ];
  late int _selectedIndex = widget.index;
  final PageController pageController = PageController();

  void _onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //appBar: customAppBar(projectName),
      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: _widgetOptions,
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black,
      selectedItemColor: Theme.of(context).focusColor,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '메인',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.car_rental),
          label: '대여 현황',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.message),
        //   label: 'DM',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'My Page',
        ),
      ],
    );
  }
}
