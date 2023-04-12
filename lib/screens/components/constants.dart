import 'package:flutter/material.dart';

const List<NavigationDestination> appBarDestinations = [
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.widgets_outlined),
    label: '컴포넌트',
    selectedIcon: Icon(Icons.widgets),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.format_paint_outlined),
    label: '색상',
    selectedIcon: Icon(Icons.format_paint),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.text_snippet_outlined),
    label: '글자 크기',
    selectedIcon: Icon(Icons.text_snippet),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.invert_colors_on_outlined),
    label: '높이',
    selectedIcon: Icon(Icons.opacity),
  ),
];

List<Widget> barWithBadgeDestinations = [
  /// 우편(1000건은 999+로 표시), 채팅, 회의는 유사
  /// 그룹은 점으로만 표시
  NavigationDestination(
    tooltip: '',
    icon: Badge.count(count: 1000, child: const Icon(Icons.mail_outline),),
    label: '우편',
    selectedIcon: Badge.count(count: 1000, child: const Icon(Icons.mail),),
  ),
  const NavigationDestination(
    tooltip: '',
    icon: Badge(label: Text('10'), child: Icon(Icons.chat_bubble_outline),),
    label: '채팅',
    selectedIcon: Badge(label: Text('10'), child: Icon(Icons.chat_bubble),),
  ),
  const NavigationDestination(
    tooltip: '',
    icon: Badge(child: Icon(Icons.group_outlined),),
    label: '그룹',
    selectedIcon: Badge(child: Icon(Icons.group),),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Badge.count(count: 3, child: const Icon(Icons.videocam_outlined),),
    label: '회의',
    selectedIcon: Badge.count(count: 3, child: const Icon(Icons.videocam),),
  ),
];

const List<Widget> exampleBarDestinations = [
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.explore_outlined),
    label: '탐색',
    selectedIcon: Icon(Icons.explore),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.pets_outlined),
    label: '동물',
    selectedIcon: Icon(Icons.pets),
  ),
  NavigationDestination(
    tooltip: '',
    icon: Icon(Icons.account_box_outlined),
    label: '계정',
    selectedIcon: Icon(Icons.account_box),
  )
];

final List<NavigationRailDestination> navRailDestinations = appBarDestinations
  .map(
    (destination) => NavigationRailDestination(
      icon: Tooltip(
        message: destination.label,
        child: destination.icon,
      ),
      selectedIcon: Tooltip(
        message: destination.label,
        child: destination.selectedIcon,
      ),
      label: Text(destination.label)
    ),
  ).toList();