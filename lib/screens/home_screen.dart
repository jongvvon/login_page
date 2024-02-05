import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: CustomPaint(
        painter: BackgroundPainter(),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            SizedBox(height: 80),
            TopBar(),
            SizedBox(height: 20),
            QuoteSection(),
            SizedBox(height: 30),
            ScheduleCards(),
            SizedBox(height: 30),
            ShadowContainer(height: 40.0),
            SizedBox(height: 25),
            ShadowContainer(height: 150.0),
            SizedBox(height: 25),
            ShadowContainer(height: 100.0),
            SizedBox(height: 25),
            ShadowContainer(height: 100.0),
          ]),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 이 부분 추가
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('MM월 dd일 EEEE').format(now);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          formattedDate,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
       
      ],
    );
  }
}

class QuoteSection extends StatelessWidget {
  const QuoteSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.format_quote_rounded,
          size: 120,
          color: Colors.white,
        ),
        QuoteStack(),
      ],
    );
  }
}

class QuoteStack extends StatelessWidget {
  const QuoteStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '오늘의 명언',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              'blah blah',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ScheduleCards extends StatelessWidget {
  const ScheduleCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          Card_Sche(),
          SizedBox(
            width: 10,
          ),
          Card_Sche(),
          SizedBox(
            width: 10,
          ),
          Card_Sche(),
        ],
      ),
    );
  }
}

class Card_Sche extends StatelessWidget {
  const Card_Sche({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green.shade900.withOpacity(0.8),
          borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 30,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.water_drop_rounded,
              color: Colors.white.withOpacity(0.6),
              size: 18,
            ),
            const ScheduleText(),
          ],
        ),
      ),
    );
  }
}

class ScheduleText extends StatelessWidget {
  const ScheduleText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('생리 예정일',
            style: TextStyle(
              color: Colors.white,
            )),
        Text(
          '3일 뒤 9.28(목)',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.lightGreen.shade900;
    paint.style = PaintingStyle.fill;

    var center = Offset(size.width / 4, size.height / 4);
    double radius = max(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ShadowContainer extends StatelessWidget {
  final double height; // 높이를 받을 변수

  const ShadowContainer({
    Key? key,
    required this.height, // 높이를 필수로 받게 설정
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height, // 파라미터로 받은 높이 적용
      width: double.infinity, // 파라미터로 받은 넓이 적용
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(160, 0, 0, 0).withOpacity(0.4),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
    );
  }
}
