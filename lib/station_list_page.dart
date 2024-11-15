import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final String title;
  final bool isDeparture;
  const StationListPage(
      {super.key, required this.title, this.isDeparture = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: const [
          StationList(station: '수서'),
          StationList(station: '동탄'),
          StationList(station: '평택지제'),
          StationList(station: '천안아산'),
          StationList(station: '오송'),
          StationList(station: '대전'),
          StationList(station: '김천구미'),
          StationList(station: '동대구'),
          StationList(station: '경주'),
          StationList(station: '울산'),
          StationList(station: '부산'),
        ],
      ),
    );
  }
}

class StationList extends StatelessWidget {
  const StationList({
    required this.station,
    super.key,
  });

  final String station;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, station);
      },
      child: Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 50,
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            station,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
