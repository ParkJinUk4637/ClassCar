import 'package:flutter/material.dart';
import 'package:my_classcar/const/name_const.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final String projectName = NameConst.projectName.name;
  final List _widgetOptions = [
    Text('메인 페이지'),
    Text('대여 현황'),
    Text('DM'),
    Text('My Page')
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Main Layout",
        home: Scaffold(
          appBar: _appBar(),
          body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
          bottomNavigationBar: _bottomNavigationBar(),
        ));
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      elevation: 1,
      leading: const IconButton(icon: Icon(Icons.ac_unit), onPressed: null),
      actions: const [
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: null,
        )
      ],
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
      title: Text(projectName),
    );
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
