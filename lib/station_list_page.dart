import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final String title;
  final bool isDeparture;
  final String? excludedStation;

  const StationListPage({
    super.key,
    required this.title,
    required this.isDeparture,
    this.excludedStation,
  });

  @override
  Widget build(BuildContext context) {
    List<String> stations = [
      '수서',
      '동탄',
      '평택지제',
      '천안아산',
      '오송',
      '대전',
      '김천구미',
      '동대구',
      '경주',
      '울산',
      '부산'
    ];

    stations = stations.where((station) => station != excludedStation).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.separated(
        itemCount: stations.length + 1,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey[300],
          height: 0.5,
        ),
        itemBuilder: (context, index) {
          if (index == stations.length) {
            // 마지막 항목은 빈 컨테이너
            return Container();
          }
          return ListTile(
            title: Text(stations[index],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () {
              Navigator.pop(context, stations[index]);
            },
          );
        },
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
