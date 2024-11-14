import 'package:flutter/material.dart';

class StationListPage extends StatelessWidget {
  final String title;
  const StationListPage({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
    );
  }
}
