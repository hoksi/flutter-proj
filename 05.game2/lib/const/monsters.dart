import 'package:flutter/material.dart';

// 몬스터 이름 매핑
const Map<int, String> monsterNames = {
  2: 'Slimie',
  4: 'Goblin',
  8: 'Ork',
  16: 'Troll',
  32: 'Ogre',
  64: 'Minotaur',
  128: 'Dragon Whelp',
  256: 'Wyvern',
  512: 'Hydra',
  1024: 'Ancient Dragon',
  2048: 'Elder God',
};

// 몬스터 이미지 경로 매핑
const Map<int, String> monsterImagePaths = {
  2: 'assets/images/Slimie.jpg',
  4: 'assets/images/Goblin.jpg',
  8: 'assets/images/Ork.jpg',
  16: 'assets/images/Troll.jpg',
  32: 'assets/images/Ogre.jpg',
  64: 'assets/images/Minotaur.jpg',
  128: 'assets/images/Dragon Whelp.jpg',
  256: 'assets/images/Wyvern.jpg',
  512: 'assets/images/Hydra.jpg',
  1024: 'assets/images/Ancient Dragon.jpg',
  // 2048 이미지는 없으므로 일단 비워둡니다.
};

// 몬스터 타일 색상 매핑 (colors.dart와 유사하게 정의)
// 이 색상들은 임시이며, 디자인에 따라 변경될 수 있습니다。
Color getTileColor(int value) {
  switch (value) {
    case 2:
      return Colors.grey[300]!; // Slime
    case 4:
      return Colors.orange[100]!; // Goblin
    case 8:
      return Colors.orange[300]!; // Orc
    case 16:
      return Colors.orange[500]!; // Troll
    case 32:
      return Colors.deepOrange[300]!; // Ogre
    case 64:
      return Colors.deepOrange[500]!; // Minotaur
    case 128:
      return Colors.yellow[300]!; // Dragon Whelp
    case 256:
      return Colors.yellow[500]!; // Wyvern
    case 512:
      return Colors.red[300]!; // Hydra
    case 1024:
      return Colors.red[500]!; // Ancient Dragon
    case 2048:
      return Colors.purple[700]!; // Elder God
    default:
      return Colors.grey[200]!; // Empty or unknown
  }
}

// 텍스트 색상 (밝은 배경에 어두운 텍스트, 어두운 배경에 밝은 텍스트)
Color getTextColor(int value) {
  if (value >= 8) { // 8 이상은 어두운 배경색이므로 밝은 텍스트
    return Colors.white;
  }
  return Colors.black; // 그 외는 밝은 배경색이므로 어두운 텍스트
}
