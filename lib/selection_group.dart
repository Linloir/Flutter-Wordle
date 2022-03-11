/*
 * @Author       : Linloir
 * @Date         : 2022-03-09 22:33:34
 * @LastEditTime : 2022-03-10 13:48:48
 * @Description  : 
 */

import 'package:flutter/material.dart';
import './group_shared.dart';

class SelectionGroupProvider extends StatefulWidget {
  const SelectionGroupProvider({
    Key? key,
    required this.selections,
    required this.onChanged,
    this.defaultSelection = 0,
  }) : super(key: key);

  final Widget selections;
  final int defaultSelection;
  final void Function(int) onChanged;

  @override
  State<SelectionGroupProvider> createState() => _SelectionGroupProviderState();
}

class _SelectionGroupProviderState extends State<SelectionGroupProvider> {
  int selected = 0;

  @override
  void initState() {
    super.initState();
    selected = widget.defaultSelection;
  }

  @override
  Widget build(BuildContext context) {
    return GroupSharedData(
      child: NotificationListener<SelectNotification>(
        child: widget.selections,
        onNotification: (noti) {
          setState(() {
            selected = noti.selection;
            widget.onChanged(selected);
          });
          return true;
        },
      ),
      selected: selected,
    );
  }
}