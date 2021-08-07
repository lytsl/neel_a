// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';
import 'package:neel_a/constants/decorations.dart';
import 'package:neel_a/widgets/tree_view/tree_controller.dart';
import 'package:neel_a/widgets/tree_view/tree_node.dart';

import 'builder.dart';

/// Widget that displays one [TreeNode] and its children.
class NodeWidget extends StatefulWidget {
  final TreeNode treeNode;
  final double? indent;
  final double? iconSize;
  final TreeController state;
  final Function(Key?) onSelect;

  static late bool isDarkMode;

  const NodeWidget({
    Key? key,
    required this.treeNode,
    this.indent,
    required this.state,
    this.iconSize,
    required this.onSelect,
  }) : super(key: key);

  @override
  _NodeWidgetState createState() => _NodeWidgetState();
}

class _NodeWidgetState extends State<NodeWidget> {
  bool get _isLeaf {
    return widget.treeNode.children == null ||
        widget.treeNode.children!.isEmpty;
  }

  bool get _isExpanded {
    return widget.state.isNodeExpanded(widget.treeNode.key!);
  }

  @override
  Widget build(BuildContext context) {
    final _primaryColor =
        NodeWidget.isDarkMode ? (primaryColorDark) : primaryColor;
    final _bgColor = NodeWidget.isDarkMode ? (bgColorDark) : bgColor;
    final _textColor = NodeWidget.isDarkMode ? (Colors.white) : Colors.black;

    var icon = _isLeaf
        ? null
        : _isExpanded
            ? Icons.expand_more
            : Icons.chevron_right;

    var onIconPressed = _isLeaf
        ? ()=>widget.onSelect(widget.treeNode.key!)
        : () {
      widget.state.toggleNodeExpanded(widget.treeNode.key!);
            widget.onSelect(widget.treeNode.key!);
           /* setState(
                () => widget.state.toggleNodeExpanded(widget.treeNode.key!));*/
          };

    final isSelected = (widget.treeNode.key == null)
        ? false
        : (widget.state.selectedNode == widget.treeNode.key!);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onIconPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: widget.iconSize ?? 24.0,
                  color: isSelected ? _primaryColor : _textColor,
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    widget.treeNode.content,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? _primaryColor : _textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (_isExpanded && !_isLeaf)
          Padding(
            padding: EdgeInsets.only(left: widget.indent!),
            child: buildNodes(widget.treeNode.children!, widget.indent,
                widget.state, widget.iconSize,widget.onSelect),
          )
      ],
    );
  }
}
