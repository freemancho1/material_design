import 'package:flutter/material.dart';

class SysCfg {
  /// 작은, 중간, 큰 화면의 폭 임계값
  static const double narrowScreenWidth = 450;  /// narrow: 450~800
  static const double mediumScreenWidth = 800;  /// medium: 800~1200
  static const double largeScreenWidth = 1200;  /// large: 1200~

  /// Duration(millisecond: 이 값 * 2함)
  static const double transitionLength = 500;

  /// 분리자
  static const SizedBox rowDivider = SizedBox(width: 20,);
  static const SizedBox colDivider = SizedBox(height: 10,);

  /// Spacing
  static const double tinySpacing = 3.0;
  static const double smallSpacing = 10.0;

  /// 기타
  static const double cardWidth = 115;
  static const double widthConstraint = 450;
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