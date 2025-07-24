import 'package:flutter/material.dart';
import '../const/monsters.dart'; // monsters.dart 임포트

class TileWidget extends StatelessWidget {
  final int value;

  const TileWidget({super.key, required this.value});

  @override
  Widget build(BuildContext context) {
    final imagePath = monsterImagePaths[value];

    return Container(
      decoration: BoxDecoration(
        color: getTileColor(value), // 몬스터 테마 색상 적용
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: imagePath != null
            ? Image.asset(
                imagePath,
                fit: BoxFit.cover, // 이미지가 타일에 꽉 차도록 설정
              )
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  value == 0 ? '' : monsterNames[value] ?? '', // 숫자 대신 몬스터 이름 표시
                  style: TextStyle(
                    fontSize: 28, // 기본 폰트 크기 조정 (더 크게)
                    fontWeight: FontWeight.bold,
                    color: getTextColor(value), // 몬스터 테마 텍스트 색상 적용
                  ),
                ),
              ),
      ),
    );
  }
}
