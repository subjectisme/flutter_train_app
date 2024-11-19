import 'package:flutter/material.dart';

// 선택 가능한 역 목록 페이지
class StationListPage extends StatelessWidget {
  final String title; // 화면 상단 제목 텍스트
  final bool isDeparture; // 출발역인지 여부 판단 bool 변수. 조건에 따라 UI 또는 동작 분기 처리
  final String? excludedStation; // 선택 목록에서 제외할 역 (선택된 출발역 및 도착역 중복 방지)
  // 생성자
  const StationListPage({
    super.key,
    required this.title,
    required this.isDeparture,
    this.excludedStation,
  });

  @override
  Widget build(BuildContext context) {
    // 역 목록 정의 리스트
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
    // excludedStation 으로 지정된 역은 where 메소드를 통해 제외(!= 조건 만족 항목만 새로운 리스트 생성)
    stations = stations.where((station) => station != excludedStation).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(title), // 전달받은 title로 앱바 제목 설정
      ),
      body: ListView.separated(
        // 역 목록 표시
        itemCount: stations.length + 1, // 마지막 구분선을 위해 +1 추가
        separatorBuilder: (context, index) => Divider(
          // 구분선
          color: Colors.grey[300],
          height: 0.5,
        ),
        itemBuilder: (context, index) {
          if (index == stations.length) {
            // 마지막 항목은 빈 컨테이너를 반환하여 리스트 끝에 여백 추가
            return Container();
          }
          return ListTile(
            title: Text(stations[index],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () {
              // 항목 클릭후 현재 화면 닫고 선택된 된 역 이름을 이전 화면으로 반환
              Navigator.pop(context, stations[index]);
            },
          );
        },
      ),
    );
  }
}
