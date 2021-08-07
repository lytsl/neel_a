// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';
import 'package:neel_a/widgets/tree_view/copy_tree_nodes.dart';
import 'package:neel_a/widgets/tree_view/tree_controller.dart';
import 'package:neel_a/widgets/tree_view/tree_node.dart';

import 'builder.dart';

/// Tree view with collapsible and expandable nodes.
class TreeView extends StatefulWidget {
  /// List of root level tree nodes.
  final List<TreeNode> nodes;

  /// Horizontal indent between levels.
  final double? indent;

  /// Size of the expand/collapse icon.
  final double? iconSize;

  /// Tree controller to manage the tree state.
  final TreeController? treeController;

  TreeView(
      {Key? key,
        required List<TreeNode> nodes,
        this.indent = 40,
        this.iconSize,
        this.treeController,
      })
      : nodes = copyTreeNodes(nodes),
        super(key: key);

  @override
  _TreeViewState createState() => _TreeViewState();
}

class _TreeViewState extends State<TreeView> {
  TreeController? _controller;

  void onSelect(Key? key){
    if(key==null)
      return;
    print(key);
    setState(() {
      _controller!.selectedNode = key;
    });
  }

  @override
  void initState() {
    _controller = widget.treeController ?? TreeController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildNodes(
        widget.nodes, widget.indent, _controller!, widget.iconSize,onSelect,);
  }
}
