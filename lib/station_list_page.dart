import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final String title;
  const StationListPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 50, // 원하는 높이
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: const Color.fromARGB(255, 119, 116, 116), // 원하는 색상
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    '수서',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ))
          ],
        ));
  }
}
