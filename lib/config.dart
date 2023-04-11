import 'package:flutter/material.dart';

class SysCfg {
  /// 작은, 중간, 큰 화면의 폭 임계값
  static const double narrowScreenWidth = 450;  /// narrow: 450~1000
  static const double mediumScreenWidth = 1000; /// medium: 1000~1500
  static const double largeScreenWidth = 1500;  /// large: 1500~

  /// Todo: 전환길이? 용도 확인
  static const double transitionLength = 500;
}

enum ColorSeed {
  baseColor('M3 Baseline', Color(0xff6750a4)),
  indigo('Indigo', Colors.indigo),
  blue('Blue', Colors.blue),
  teal('Teal', Colors.teal),
  green('Green', Colors.green),
  yellow('Yellow', Colors.yellow),
  orange('Orange', Colors.orange),
  deepOrange('Deep Orange', Colors.deepOrange),
  pink('Pink', Colors.pink);

  final String label;
  final Color color;
  const ColorSeed(this.label, this.color);
}

/// 화면번호 - 하단 텝 클릭시 사용(4개의 텝이 존재함)
enum ScreenSelected {
  component(0),
  color(1),
  typography(2),
  elevation(3);

  final int value;
  const ScreenSelected(this.value);
}