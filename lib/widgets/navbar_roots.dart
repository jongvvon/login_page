import 'package:flutter/material.dart';
import 'package:welcome/screens/home_screen.dart';

class NavBarRoots extends StatefulWidget {
  const NavBarRoots({super.key});

  @override
  State<NavBarRoots> createState() => _NavBarRootsState();
}

class _NavBarRootsState extends State<NavBarRoots> {
  int _selectedIndex = 0;
  final _screens = [
    HomeScreen(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  Widget build(BuildContext context) {
    // 현재 개발하고 있는 iOS 환경의 경우 홈 인디케이터의 영향으로 safeArea 가 설정되어 있음
    // 하단의 코드는 안드로이드 내부에서는 정상 동작하는 코드였지만 iOS 환경에서는 bottom 11px overflow 발생
    // 해당 문제를 해결하기 위해 SafeArea 동작을 제한하였음. 크로스 플랫폼 개발시에 신경써야할 문제인듯 싶다.
    // 크로스 플랫폼 개발시에 문제가 되는 사항이 아닐까 하는 의문이 듭니다....
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _screens[_selectedIndex],
        // ignore: sized_box_for_whitespace
        bottomNavigationBar: Container(
          height: 80,
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: const Color(0xFF556b2f),
            unselectedItemColor: Colors.black26,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: "home",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
