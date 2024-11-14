import 'package:flutter/material.dart';
import 'station_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('기차 예매'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              seatSelectBox(),
              const SizedBox(height: 20),
              seatSelectButton(),
            ],
          ),
        ));
  }
}

class seatSelectBox extends StatelessWidget {
  const seatSelectBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          miniSelectBox(
            title: '출발역',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => StationListPage(title: '출발역'),
                ),
              );
            },
          ),
          const SizedBox(
            height: 50,
            child: VerticalDivider(
              width: 50,
              thickness: 2,
              color: Colors.grey,
            ),
          ),
          miniSelectBox(
            title: '도착역',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StationListPage(title: '도착역')),
              );
            },
          ),
        ],
      ),
    );
  }
}

class miniSelectBox extends StatelessWidget {
  const miniSelectBox({
    super.key,
    required this.title,
    required this.onTap,
    this.station,
  });
  final String title;
  final Function() onTap;
  final String? station;
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        title,
        style: (TextStyle(
            color: Colors.grey, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      GestureDetector(
          onTap: onTap,
          child: Text(station ?? '선택', style: (TextStyle(fontSize: 40))))
    ]);
  }
}

class seatSelectButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.purple,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20))),
        child: const Text(
          '좌석 선택',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
