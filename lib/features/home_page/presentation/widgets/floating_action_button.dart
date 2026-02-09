import 'package:flutter/material.dart';

class FloatingActionButtonCustom extends StatelessWidget {
  final Widget widget;
  final VoidCallback function;
  final String tooltip;
  final Icon icon;

  const FloatingActionButtonCustom({
    super.key,
    required this.widget,
    required this.function,
    required this.tooltip,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: widget,
      onPressed: function,
      tooltip: tooltip,
      icon: icon,
    );
  }
}
