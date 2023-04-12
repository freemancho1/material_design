import 'package:flutter/material.dart';
import 'package:material_design/config.dart';

class ComponentDeocoration extends StatefulWidget {
  final String label;
  final Widget child;
  final String tooltipMessage;
  const ComponentDeocoration({
    super.key,
    required this.label,
    required this.child,
    this.tooltipMessage = '',
  });

  @override
  State<ComponentDeocoration> createState() => _ComponentDeocorationState();
}

class _ComponentDeocorationState extends State<ComponentDeocoration> {
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: SysCfg.smallSpacing),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Tooltip(
                  message: widget.tooltipMessage,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Icon(Icons.info_outline, size: 16,),
                  ),
                ),
              ],
            ),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(
                width: SysCfg.widthConstraint
              ),
              child: Focus(
                focusNode: focusNode,
                canRequestFocus: true,
                child: GestureDetector(
                  onTapDown: (_) => focusNode.requestFocus(),
                  behavior: HitTestBehavior.opaque,
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 20
                      ),
                      child: Center(child: widget.child,),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
