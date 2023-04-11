import 'package:flutter/material.dart';

class NavigationTransition extends StatefulWidget {
  /// Todo: Continue....2 => navigationRail, navigationBar
  final GlobalKey<ScaffoldState> scaffoldKey;
  final AnimationController animationController;
  final CurvedAnimation railAnimation;
  final PreferredSizeWidget appBar;
  final Widget body;
  const NavigationTransition({
    super.key,
    required this.scaffoldKey,
    required this.animationController,
    required this.railAnimation,
    required this.appBar,
    required this.body,
  });

  @override
  State<NavigationTransition> createState() => _NavigationTransitionState();
}

class _NavigationTransitionState extends State<NavigationTransition> {
  late final AnimationController controller;
  late final CurvedAnimation railAnimation;
  late final ReverseAnimation barAnimation;

  /// Todo: 언제 사용하나?
  bool controllerInitialized = false;
  bool showDivider = false;

  @override
  void initState() {
    super.initState();

    controller = widget.animationController;
    railAnimation = widget.railAnimation;
    barAnimation = ReverseAnimation(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.5),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    /// Todo: Continue......4
    return Scaffold(
      key: widget.scaffoldKey,
      appBar: widget.appBar,
      body: widget.body,
    );
  }
}
