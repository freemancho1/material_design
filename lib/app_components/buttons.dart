import 'package:flutter/material.dart';
import 'package:material_design/config.dart';

class BrightnessToggleButton extends StatelessWidget {
  final void Function() handleBrightnessToggle;
  final bool showTooltipBelow;
  const BrightnessToggleButton({
    super.key,
    required this.handleBrightnessToggle,
    this.showTooltipBelow = true,
  });

  @override
  Widget build(BuildContext context) {
    final isBright = Theme.of(context).brightness == Brightness.light;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: '${isBright ? "어두운" : "밝은"} 테마로 전환합니다.',
      child: IconButton(
        icon: isBright
          ? const Icon(Icons.dark_mode_outlined)
          : const Icon(Icons.light_mode_outlined),
        onPressed: handleBrightnessToggle,
      ),
    );
  }
}

class MaterialVersionToggleButton extends StatelessWidget {
  final void Function() handleMaterialVersionToggle;
  final bool showTooltipBelow;
  const MaterialVersionToggleButton({
    super.key,
    required this.handleMaterialVersionToggle,
    this.showTooltipBelow = true,
  });

  @override
  Widget build(BuildContext context) {
    final useMaterial3 = Theme.of(context).useMaterial3;
    return Tooltip(
      preferBelow: showTooltipBelow,
      message: 'Material ${useMaterial3 ? "2로" : "3으로"} 전환합니다.',
      child: IconButton(
        icon: useMaterial3
          ? const Icon(Icons.filter_2)
          : const Icon(Icons.filter_3),
        onPressed: handleMaterialVersionToggle,
      ),
    );
  }
}

class ColorSelectButton extends StatelessWidget {
  final void Function(int) handleColorSelect;
  final ColorSeed colorSelected;
  const ColorSelectButton({
    super.key,
    required this.handleColorSelect,
    required this.colorSelected,
  });

  @override
  Widget build(BuildContext context) {
    final useMaterial3 = Theme.of(context).useMaterial3;
    final isBright = Theme.of(context).brightness == Brightness.light;
    final double screenWidth = MediaQuery.of(context).size.width;
    return PopupMenuButton(
      /// 팝업 전체의 아이콘(색상은 현재 테마의 onSurfaceVariant 이용)
      icon: Icon(
        Icons.palette_outlined,
        // color: Colors.white,
        color: !useMaterial3 && isBright &&
            screenWidth < SysCfg.mediumScreenWidth
          ? Colors.white
          : Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      tooltip: '테마 색상을 선택하세요.',
      /// shape에 올 수 있는 유형
      /// - ContinuousRectangleBorder - 일반적인 직사각형
      /// - RoundedRectangleBorder - 모서리 곡선 직사각형
      /// - CircleBorder - 원형
      /// - StadiumBorder - 반원(위 모서리만 곡선 직사각형)
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      itemBuilder: (BuildContext context) {
        return List.generate(
          ColorSeed.values.length,
          (index) {
            /// 현재 루프의 컬러
            ColorSeed currentColor = ColorSeed.values[index];
            return PopupMenuItem(
              /// 해당 팝업메뉴가 클릭됬을 때 인식할 값
              value: index,
              /// 다른 말로는 현재 색상이 테마 색상과 같으면 클릭이 안됨(disabled)
              enabled: currentColor != colorSelected,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Icon(
                      currentColor == colorSelected
                        ? Icons.color_lens
                        : Icons.color_lens_outlined,
                      color: currentColor.color,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(currentColor.label),
                  ),
                ],
              ),
            );
          }
        );
      },
      /// 이렇게 하면 PopupMenuItem의 선택된 value값을 인수로 가진 아래 함수가 실행됨.
      onSelected: handleColorSelect,
    );
  }
}


