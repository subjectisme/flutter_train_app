import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 좌석 선택 페이지 , 좌석 선택 상태(selectedSeat)가 변경될 수 있으므로 상태변경 위젯 사용
class SeatPage extends StatefulWidget {
  final String departureStation; // 출발역 전달 받음
  final String arrivalStation; // 도착역 전달 받음

  // 생성자
  const SeatPage({
    super.key,
    required this.departureStation,
    required this.arrivalStation,
  });

  @override
  // 상태 관리 로직 분리
  State<SeatPage> createState() => _SeatPageState();
}

class _SeatPageState extends State<SeatPage> {
  String? selectedSeat; // 선택된 좌석 저장하는 변수 (초기값 null 설정)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('좌석 선택')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 출발역,도착역,화살 아이콘을 Row 로 배치 (flex 사용하여 2:1:2 설정)
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

            // 좌석 상태 예시를 Row 로 배치
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

            // 좌석 리스트
            // 각 A,B,C,D 로 시장하는 column을 Row 로 배치
            // 스크롤 가능
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSeatColumn('A'),
                        const SizedBox(width: 4),
                        _buildSeatColumn('B'),
                        _buildNumberColumn(), // 좌석 번호 표시 열
                        _buildSeatColumn('C'),
                        const SizedBox(width: 4),
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
                  onPressed: selectedSeat != null // 좌석이 선택되었을때만 버튼 활성화
                      ? () {
                          // 버튼 클릭 시 예매 확인 대화상자 노출
                          showCupertinoDialog(
                            context: context,
                            builder: (BuildContext context) => // 대화상자 UI 반환 함수
                                CupertinoAlertDialog(
                              title: const Text('예매 하시겠습니까?'),
                              content:
                                  Text('좌석 : $selectedSeat'), // 선택한 좌석 정보 표시
                              actions: <Widget>[
                                // 대화상자 내 각 버튼 정의
                                CupertinoDialogAction(
                                  // 취소 버튼 정의
                                  onPressed: () {
                                    Navigator.of(context).pop(); // 클릭 시 대화상자 닫기
                                  },
                                  isDestructiveAction: true, // 취소 작업임을 알려주는 코드
                                  child: const Text('취소'),
                                ),
                                CupertinoDialogAction(
                                  // 확인 버튼 정의
                                  child: const Text('확인',
                                      style: TextStyle(color: Colors.blue)),
                                  onPressed: () {
                                    // 확인 버튼 클릭 시
                                    Navigator.of(context).pop(); // 대화 상자 닫고
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
                    minimumSize: const Size(double.infinity, 45),
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

  // 좌석 Column 생성하며, 알파벳 라벨 및 좌석 버튼 20 개 생성 위젯
  Widget _buildSeatColumn(String label) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          width: 50,
          child: Text(
            label, // 알파벳 라벨 지정
            style: const TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
        for (int i = 1; i <= 20; i++) // 20 개 버튼 생성
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0), // 각 좌석 하단 간격
            child: GestureDetector(
              // 좌석 버튼 클릭 이벤트 처리
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
                // 좌석 버튼 UI
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: selectedSeat ==
                          '$i - $label' // selectedSeat가 현재 좌석이면 보라색, 아니면 회색
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

  // 좌석 번호 column 생성 위젯
  Widget _buildNumberColumn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          const SizedBox(height: 50), // 상단에 빈 공간을 추가하여 알파벳 라벨과 높이 맞춤
          for (int i = 1; i <= 20; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                width: 50,
                height: 50,
                alignment: Alignment.center,
                child: Text('$i', style: const TextStyle(fontSize: 18)),
              ),
            ),
        ],
      ),
    );
  }
}
