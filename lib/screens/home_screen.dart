import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:welcome/screens/sign_in_screen.dart';
import 'package:welcome/widgets/navbar_roots.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NavBarRoots()),
                  );
                },
                icon: const Icon(Icons.backspace),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
