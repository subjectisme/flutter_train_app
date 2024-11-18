import 'package:flutter/material.dart';
import 'package:flutter_train_app/seat_page.dart';
import 'station_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? departureStation;
  String? arrivalStation;

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
            seatSelectBox(
              departureStation: departureStation,
              arrivalStation: arrivalStation,
              onDepartureTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StationListPage(title: '출발역', isDeparture: true),
                  ),
                );
                if (result != null) {
                  setState(() {
                    departureStation = result;
                  });
                }
              },
              onArrivalTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        StationListPage(title: '도착역', isDeparture: false),
                  ),
                );
                if (result != null) {
                  setState(() {
                    arrivalStation = result;
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            seatSelectButton(),
          ],
        ),
      ),
    );
  }
}

class seatSelectBox extends StatelessWidget {
  final String? departureStation;
  final String? arrivalStation;
  final Function() onDepartureTap;
  final Function() onArrivalTap;

  const seatSelectBox({
    super.key,
    this.departureStation,
    this.arrivalStation,
    required this.onDepartureTap,
    required this.onArrivalTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: miniSelectBox(
              title: '출발역',
              station: departureStation,
              onTap: onDepartureTap,
            ),
          ),
          const Flexible(
            flex: 1,
            child: SizedBox(
              height: 50,
              child: VerticalDivider(
                width: 50,
                thickness: 2,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: miniSelectBox(
              title: '도착역',
              station: arrivalStation,
              onTap: onArrivalTap,
            ),
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            station ?? '선택',
            style: const TextStyle(fontSize: 40),
          ),
        ),
      ],
    );
  }
}

class seatSelectButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => (SeatPage())),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.purple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
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
