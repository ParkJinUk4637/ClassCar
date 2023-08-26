import 'package:flutter/material.dart';
import 'package:my_classcar/layouts/main_page/main_page/main_page.dart';
import 'package:my_classcar/layouts/main_page/my_page/my_page.dart';
import 'package:my_classcar/layouts/main_page/my_rental/my_rental.dart';

import '../../component/const/name_const.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  final String projectName = NameConst.projectName.name;
  final List<Widget> _widgetOptions = <Widget>[
    const MainPage(),
    const MyRental(),
    const Text('DM'),
    const MyPage(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //appBar: customAppBar(projectName),
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
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
      selectedItemColor: Colors.blue,
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
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'DM',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'My Page',
        ),
      ],
    );
  }
}
