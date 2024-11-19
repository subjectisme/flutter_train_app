// 임포트

import 'package:flutter/material.dart';
import 'package:flutter_train_app/seat_page.dart';
import 'station_list_page.dart';

//MyApp 실행
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

// 상태관리 위젯
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String? departureStation; // 출발역 저장 변수 선언
  String? arrivalStation; // 도착역 저장 변수 선언

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('기차 예매'),
      ),
      body: Padding(
        // 패딩 20 그리고 중앙 정렬 Column
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //  출발역 선택 버튼
            SeatSelectBox(
              departureStation: departureStation, // 출발역
              arrivalStation: arrivalStation, // 도착역 전달
              onDepartureTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StationListPage(
                      title: '출발역', // 역리스트 페이지 앱바 타이틀 전달
                      isDeparture: true, // 출발역 선택 모드
                      excludedStation: arrivalStation, // 선택한 도착역이 있다면 리스트에서 제외
                    ),
                  ),
                );
                if (result != null) {
                  // 출발역을 선택한경우
                  setState(() {
                    departureStation = result; // 화면 반영
                  });
                }
              },
              // 도착역 선택 버튼
              onArrivalTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StationListPage(
                      title: '도착역',
                      isDeparture: false, // 도착역 선택 모드
                      excludedStation:
                          departureStation, // 선택된 출발역이 있다면 리스트에서 제외
                    ),
                  ),
                );
                if (result != null) {
                  // 사용자가 도착역을 선택했다면
                  setState(() {
                    arrivalStation = result; // 화면 반영
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            SeatSelectButton(
              // 좌선 선택 버튼
              // 선택한 출발역 및 도착역 값 전달
              departureStation: departureStation,
              arrivalStation: arrivalStation,
            ),
          ],
        ),
      ),
    );
  }
}

// 출발역 및 도착역 표시 및 선택 버튼 제공
class SeatSelectBox extends StatelessWidget {
  final String? departureStation; // 선택된 출발역 저장 (초기값 null)
  final String? arrivalStation; // 선택된 도착역 저장 (초기값 null)
  final Function() onDepartureTap; // 출발역 선택 버튼 누를 시 실행 함수 (반환값 없음)
  final Function() onArrivalTap; // 도착역 선택 버튼 누를 시 실행 함수 (반환값 없음)
  //생성자
  const SeatSelectBox({
    super.key,
    this.departureStation,
    this.arrivalStation,
    // required : 아래 둘중 하나는 반드시 제공되야함
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
          const SizedBox(width: 13), // 4글자 역 선택시 왼쪽 여백 생성
          Expanded(
            flex: 2,
            child: MiniSelectBox(
              title: '출발역',
              station: departureStation, // 선택된 출발역 이름 전달
              onTap: onDepartureTap, // 출발역 선택 버튼 누를 시 실행할 함수 전달
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
            child: MiniSelectBox(
              title: '도착역',
              station: arrivalStation, // 선택된 도착역 이름 전달
              onTap: onArrivalTap, // 도착역 선택 버튼 누를 시 실행할 함수 전달
            ),
          ),
        ],
      ),
    );
  }
}

class MiniSelectBox extends StatelessWidget {
  // 생성자
  const MiniSelectBox({
    super.key,
    required this.title, // 선택박스의 제목 ( 출발역 또는 도착역) 받음. 필수값
    required this.onTap, // 선택박스 클릭 시 실행 함수. 필수 값
    this.station, // 선택한 역이 있다면 이름 받음. null 가능
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
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8), // 제목과 역 이름 사이의 간격
        GestureDetector(
          // 터치 이벤트 감지 위젯
          onTap: onTap, // 선택 박스 클릭 시 onTap 함수 실행
          child: Container(
            width: double.infinity,
            child: Text(
              station ?? '선택', // 선택된 역이름을 표시하며, null 이면 '선택' 표시
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 40),
            ),
          ),
        ),
      ],
    );
  }
}

// 좌선 선택 버튼
class SeatSelectButton extends StatelessWidget {
  final String? departureStation; // 선택된 출발역 이름 저장 (null 가능)
  final String? arrivalStation; // 선택된 도착역 이름 저장 (null 가능)
  //생성자
  const SeatSelectButton({
    Key? key,
    required this.departureStation, // 출발역 값 (필수값)
    required this.arrivalStation, // 도착역 값 (필수값)
  }) : super(key: key); // 부모클래스(StatelessWidget)의 생성자에 키 전달

  @override
  Widget build(BuildContext context) {
    // 버튼의 활성화 여부 판단 논리식
    // 출발역과 도착역이 모두 비어있지 않은 문자열이고 null이 아닐때 활성화(true)
    bool isEnabled = departureStation != null &&
        arrivalStation != null &&
        departureStation!.isNotEmpty &&
        arrivalStation!.isNotEmpty;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        // 버튼 클릭 시 실행될 동작 정의
        onPressed: isEnabled // 조건 : isEnabled == true
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeatPage(
                      // 페이지 이동
                      departureStation:
                          departureStation!, // 출발역 값 전달, '!' 은 null 이 아님을 보장
                      arrivalStation:
                          arrivalStation!, // 도착역 값 전달, '!' 은 null 이 아님을 보장
                    ),
                  ),
                );
              }
            : null, // null이면 버튼이 비활성화
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 45),
          backgroundColor: isEnabled
              ? Colors.purple
              : Colors.grey, //isEnabled 의 값이 true 면 보라색 , false 면 회색
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
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
