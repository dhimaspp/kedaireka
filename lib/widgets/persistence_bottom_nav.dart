import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:kedaireka/screen/home/account/account_setting.dart';
import 'package:kedaireka/screen/home/desease_analyze/takePicture.dart';
import 'package:kedaireka/screen/home/instruksi_screen.dart';
import 'package:kedaireka/theme/constant.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class PersistenceBottomNavBar extends StatefulWidget {
  const PersistenceBottomNavBar({Key? key}) : super(key: key);

  @override
  _PersistenceBottomNavBarState createState() =>
      _PersistenceBottomNavBarState();
}

class _PersistenceBottomNavBarState extends State<PersistenceBottomNavBar> {
  // PersistentTabController? _controller;
  final autoSizeGroup = AutoSizeGroup();
  int? _selectedBar;

  @override
  void initState() {
    super.initState();
    _selectedBar = 0;
    // _controller = PersistentTabController(initialIndex: 0);
  }

  final List<Widget> _buildScreens = <Widget>[
    const InstruksiScreen(),
    // const TakePictureScreen(),
    const AccountSetting()
  ];

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.info,
          color: Colors.grey,
        ),
        label: "Instruksi",

        activeIcon: Icon(
          Icons.info,
          color: kMaincolor,
        ),
        // inactiveColorPrimary: Colors.grey,
      ),
      // BottomNavigationBarItem(
      //   icon: const Icon(
      //     Icons.camera_alt_outlined,
      //     color: Colors.white,
      //   ),
      //   title: ("Analisa"),
      //   activeColorPrimary: kMaincolor,
      //   inactiveColorPrimary: Colors.grey,
      // ),
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.person,
          color: Colors.grey,
        ),
        label: "Akun",
        activeIcon: Icon(
          Icons.person,
          color: kMaincolor,
        ),
        // activeColorPrimary: kMaincolor,
        // inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedBar = index;
    });
  }

  final iconList = <IconData>[
    Icons.info,
    Icons.person,
  ];
  final nameBarList = <String>['Intruksi', 'Akun'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.camera_alt_outlined,
            color: Colors.white,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        index: _selectedBar,
        children: _buildScreens,
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? kMaincolor : Colors.grey;
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconList[index],
                size: 24,
                color: color,
              ),
              const SizedBox(height: 4),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: AutoSizeText(
                    nameBarList[index],
                    maxLines: 1,
                    style: TextStyle(color: color),
                    group: autoSizeGroup,
                  ))
            ],
          );
        },
        backgroundColor: Colors.white,
        elevation: 18,
        splashColor: kFillColor,
        splashSpeedInMilliseconds: 300,
        activeIndex: _selectedBar!,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        onTap: _onItemTapped,
      ),
    );
  }
}
