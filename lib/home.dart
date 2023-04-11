import 'package:flutter/material.dart';
import 'package:material_design/app_components/buttons.dart';
import 'package:material_design/app_components/navigation_transition.dart';
import 'package:material_design/config.dart';

class Home extends StatefulWidget {
  final bool useLightMode;
  final bool useMaterial3;
  final ColorSeed colorSelected;
  final void Function() handleBrightnessToggle;
  final void Function() handleMaterialVersionToggle;
  final void Function(int) handleColorSelect;
  const Home({
    super.key,
    required this.useLightMode,
    required this.useMaterial3,
    required this.colorSelected,
    required this.handleBrightnessToggle,
    required this.handleMaterialVersionToggle,
    required this.handleColorSelect,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late final AnimationController controller;
  late final CurvedAnimation railAnimation;

  bool controllerInitialized = false;
  bool showMediumSizeLayout = false;
  bool showLargeSizeLayout = false;

  /// 현재 화면 인덱스(바디 아래서 탭 클릭시 처리됨)
  int screenIndex = ScreenSelected.component.value;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      /// SingleTickerProviderStateMixin을 이용해 TickerProvider를 만들 수 있음
      vsync: this, value: 0,          /// TickerProvider를 이 위젯으로 함
      duration: Duration(milliseconds: SysCfg.transitionLength.toInt()*2),
    );
    railAnimation = CurvedAnimation(
      parent: controller,             /// 애니메이션을 제어할 컨트롤러 지정
      curve: const Interval(0.5, 1),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// setState: StatefulWidget에서 사용하며, "위젯의 의존성을 변경"하며,
  /// 변경된 내용으로 화면을 업데이트함
  /// didChangeDependencies: Stateful or Stateless에서 사용하며,
  /// 위젯의 의존성이 변경(최초 생성시에도)되면 관련 작업을 수행, 화면을 업데이트하지 않음.

  /// build전에 실행되면 위젯이 의존하는 객체나 상태가 변경되면 호출됨.
  /// 아래 코드에서는 MediaQuery의 size변화를 모니터링해서 변경시 작업을 수행함.
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final double screenWidth = MediaQuery.of(context).size.width;
    final AnimationStatus status = controller.status;

    if (screenWidth > SysCfg.mediumScreenWidth) {
      if (screenWidth > SysCfg.largeScreenWidth) {
        showMediumSizeLayout = false;
        showLargeSizeLayout = true;
      } else {
        showMediumSizeLayout = true;
        showLargeSizeLayout = false;
      }
      if (status != AnimationStatus.forward &&
          status != AnimationStatus.completed) {
        controller.forward();
      }
    } else {
      showMediumSizeLayout = false;
      showLargeSizeLayout = false;
      if (status != AnimationStatus.reverse &&
          status != AnimationStatus.dismissed) {
        controller.reverse();
      }
    }

    if (!controllerInitialized) {
      controllerInitialized = true;
      /// Todo: 이유는?
      controller.value = screenWidth > SysCfg.mediumScreenWidth ? 1 : 0;
    }
  }

  void handleScreenChange(int screenSelected) {
    setState(() => screenIndex = screenSelected);
  }

  PreferredSizeWidget createAppBar() => AppBar(
    title: Text('Material ${widget.useMaterial3 ? 3 : 2}'),
    /// 작은 화면 사이즈에서만 액션바에 설정버튼이 표시됨
    /// 중간 및 큰 화면 사이즈에서는 설정버튼이 왼쪽 하단에 표시됨.
    actions: !showMediumSizeLayout && !showLargeSizeLayout
      ? [
          BrightnessToggleButton(
            handleBrightnessToggle: widget.handleBrightnessToggle,),
          MaterialVersionToggleButton(
            handleMaterialVersionToggle: widget.handleMaterialVersionToggle),
          ColorSelectButton(
            handleColorSelect: widget.handleColorSelect,
            colorSelected: widget.colorSelected),
        ]
      : [Container()],
  );

  /// Todo: ....3
  Widget createScreenFor() {
    return Center(
      child: Text(
        'Material Body',
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    /// Todo: Continue.....1
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return NavigationTransition(
          scaffoldKey: scaffoldKey,
          animationController: controller,
          railAnimation: railAnimation,
          appBar: createAppBar(),
          body: createScreenFor(),
        );
      }
    );
  }
}
