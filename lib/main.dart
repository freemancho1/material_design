import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:material_design/home.dart';

import 'config.dart';

void main() => runApp(const MaterialDesignApp());

class MaterialDesignApp extends StatefulWidget {
  const MaterialDesignApp({Key? key}) : super(key: key);

  @override
  State<MaterialDesignApp> createState() => _MaterialDesignAppState();
}

class _MaterialDesignAppState extends State<MaterialDesignApp> {
  bool useMaterial3 = true;
  ThemeMode themeMode = ThemeMode.system;
  ColorSeed colorSelected = ColorSeed.baseColor;

  /// 현재 themeMode가 LightMode를 사용하면 true, DarkMode를 사용하면 false 리턴
  bool get useLightMode {
    final Brightness systemBrightness =
        SchedulerBinding.instance.window.platformBrightness;
    switch (themeMode) {
      case ThemeMode.system:
        return systemBrightness == Brightness.light;
      case ThemeMode.light:
        return true;
      case ThemeMode.dark:
        return false;
    }
  }

  /// 아래 3개의 함수는 위 3개의 값(useMaterial3, themeMode, colorSelected)을
  /// 자식 위젯들에서 변경할 수 있도록 하기 위해 만든 함수로 AppBar 등에서 사용
  void handleBrightnessToggle() {
    setState(() => themeMode = useLightMode ? ThemeMode.dark : ThemeMode.light);
  }

  void handleMaterialVersionToggle() {
    setState(() => useMaterial3 = !useMaterial3);
  }

  void handleColorSelect(int colorIndex) {
    setState(() => colorSelected = ColorSeed.values[colorIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material Design',
      themeMode: themeMode,                   /// State에서 변경값 모니터링
      /// themeMode에 따라 theme와 dartTheme를 선택해 사용
      theme: ThemeData(
        colorSchemeSeed: colorSelected.color, /// State에서 변경값 모니터링
        useMaterial3: useMaterial3,           /// State에서 변경값 모니터링
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: colorSelected.color,
        useMaterial3: useMaterial3,
        brightness: Brightness.dark,
      ),
      home: Home(
        useLightMode: useLightMode,
        useMaterial3: useMaterial3,
        colorSelected: colorSelected,
        handleBrightnessToggle: handleBrightnessToggle,
        handleMaterialVersionToggle: handleMaterialVersionToggle,
        handleColorSelect: handleColorSelect,
      ),
    );
  }
}
