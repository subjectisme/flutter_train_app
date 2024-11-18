import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeatPage extends StatefulWidget {
  final String departureStation;
  final String arrivalStation;

  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  String? selectedSeat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('좌석 선택')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    widget.departureStation,
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 30.0,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    widget.arrivalStation,
                    style: TextStyle(
                      color: Colors.purple,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 24,
                width: 24,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.purple,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              const Text('선택됨'),
              const SizedBox(width: 20),
              SizedBox(
                  height: 24,
                  width: 24,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey,
                    ),
                  )),
              const SizedBox(width: 4),
              const Text('선택안됨')
            ]),
            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSeatColumn('A'),
                        SizedBox(width: 8),
                        _buildSeatColumn('B'),
                        _buildNumberColumn(),
                        _buildSeatColumn('C'),
                        SizedBox(width: 8),
                        _buildSeatColumn('D'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            //예매하기 버튼
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: ElevatedButton(
                  onPressed: selectedSeat != null
                      ? () {
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                CupertinoAlertDialog(
                              title: Text('예매 하시겠습니까?'),
                              content: Text('좌석 : $selectedSeat'),
                              actions: <Widget>[
                                CupertinoDialogAction(
                                  child: Text('취소'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Dialog 제거
                                  },
                                ),
                                CupertinoDialogAction(
                                  child: Text('확인'),
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Dialog 제거
                                    Navigator.of(context).popUntil((route) =>
                                        route.isFirst); // HomePage로 이동
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 45),
                    backgroundColor: Colors.purple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    '예매 하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSeatColumn(String label) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: Text(
            label,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        for (int i = 1; i <= 20; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  String seatId = '$i - $label';
                  if (selectedSeat == seatId) {
                    selectedSeat = null;
                  } else {
                    selectedSeat = seatId;
                  }
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: selectedSeat == '$i - $label'
                      ? Colors.purple
                      : Colors.grey[300]!,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildNumberColumn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          SizedBox(height: 50), // 알파벳 라벨과 높이 맞추기
          for (int i = 1; i <= 20; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                width: 30,
                height: 50,
                alignment: Alignment.center,
                child: Text('$i', style: TextStyle(fontSize: 12)),
              ),
            ),
        ],
      ),
    );
  }
}
