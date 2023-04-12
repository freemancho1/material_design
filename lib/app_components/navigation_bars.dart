import 'package:flutter/material.dart';
import 'package:material_design/screens/components/constants.dart';
import 'package:material_design/screens/components/decorations.dart';

class NavigationBars extends StatefulWidget {
  final void Function(int)? onSelectItem;
  final int selectedIndex;
  final bool isExampleBar;
  final bool isBadgeExample;
  const NavigationBars({
    super.key,
    this.onSelectItem,
    required this.selectedIndex,
    required this.isExampleBar,
    this.isBadgeExample = false,
  });

  @override
  State<NavigationBars> createState() => _NavigationBarsState();
}

class _NavigationBarsState extends State<NavigationBars> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex;
  }

  /// 위젯 자체가 변경될 때 호출
  /// didChangeDependencies은 위젯의 상태가 변경될 때 호출
  @override
  void didUpdateWidget(covariant NavigationBars oldWidget) {
    super.didUpdateWidget(oldWidget);
    /// Todo: 이결 별도로 해줘야 하나?
    /// setState() 같은걸로 하면 안되나?
    if (widget.selectedIndex != oldWidget.selectedIndex) {
      selectedIndex = widget.selectedIndex;
    }
  }

  @override
  Widget build(BuildContext context) {

    /// App NavigationBar가 첫번째 포커스를 받아야 함.
    Widget navigationBar = Focus(
      autofocus: !(widget.isExampleBar || widget.isBadgeExample),
      child: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() => selectedIndex = index);
          if (!widget.isExampleBar && widget.onSelectItem != null) {
            widget.onSelectItem!(index);
          }
        },
        destinations: widget.isExampleBar && widget.isBadgeExample
          ? barWithBadgeDestinations
          : widget.isExampleBar
            ? exampleBarDestinations
            : appBarDestinations,
      ),
    );

    if (widget.isExampleBar && widget.isBadgeExample) {
      navigationBar = ComponentDeocoration(
        label: '배지',
        tooltipMessage: '배지 사용(카운터 포함)',
        child: navigationBar,
      );
    } else if (widget.isExampleBar) {
      navigationBar = ComponentDeocoration(
        label: '네비게이션 바',
        tooltipMessage: '네비게이션 바 사용',
        child: navigationBar,
      );
    }

    return navigationBar;
  }
}
