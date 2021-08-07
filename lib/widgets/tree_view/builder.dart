// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';
import 'package:neel_a/widgets/tree_view/tree_controller.dart';
import 'package:neel_a/widgets/tree_view/tree_node.dart';

import 'node_widget.dart';

/// Builds set of [nodes] respecting [state], [indent] and [iconSize].
Widget buildNodes(Iterable<TreeNode> nodes, double? indent,
    TreeController state, double? iconSize,Function(Key?) onSelect) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (var node in nodes)
        NodeWidget(
          onSelect: (key)=>onSelect(key),
          treeNode: node,
          indent: indent,
          state: state,
          iconSize: iconSize,
        )
    ],
  );
}
