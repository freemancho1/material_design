import 'package:flutter/material.dart';
import 'package:material_design/app_components/animations.dart';

class RailTransition extends StatefulWidget {
  final Animation<double> animation;
  final Widget child;
  final Color backgroundColor;
  const RailTransition({
    super.key,
    required this.animation,
    required this.backgroundColor,
    required this.child,
  });

  @override
  State<RailTransition> createState() => _RailTransitionState();
}

class _RailTransitionState extends State<RailTransition> {
  late Animation<Offset> offsetAnimation;
  late Animation<double> widthAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final bool ltr = Directionality.of(context) == TextDirection.ltr;

    widthAnimation = Tween<double>(begin: 0, end: 1)
      .animate(SizeAnimation(widget.animation));
    offsetAnimation = Tween<Offset>(
      begin: Offset(ltr ? -1 : 1, 0), end: Offset.zero
    ).animate(OffsetAnimation(widget.animation));
  }

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: DecoratedBox(
        // decoration: const BoxDecoration(color: Colors.deepOrange),
        /// 이 배경색으로 박스가 나왔다가 child에 의해 왼쪽에서 오른쪽으로 살아짐
        decoration: BoxDecoration(color: widget.backgroundColor),
        child: Align(
          /// 자식 위젯을 상단왼쪽에 배치하고
          alignment: Alignment.topLeft,
          widthFactor: widthAnimation.value,
          /// 자식 위젯을 부모 위젯 내에서 이동(이동 값은 translation에 지정됨)
          child: FractionalTranslation(
            translation: offsetAnimation.value,
            // translation: const Offset(0,0), /// 애니메이션 없이 바로 표시/숨김됨
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
