// Copyright 2020 the Dart project authors.
//
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file or at
// https://developers.google.com/open-source/licenses/bsd

import 'package:flutter/material.dart';
import 'package:neel_a/widgets/tree_view/tree_node.dart';


/// Copies nodes to unmodifiable list, assigning missing keys and checking for duplicates.
List<TreeNode> copyTreeNodes(List<TreeNode>? nodes) {
  return _copyNodesRecursively(nodes, KeyProvider())!;
}

List<TreeNode>? _copyNodesRecursively(
    List<TreeNode>? nodes, KeyProvider keyProvider) {
  if (nodes == null) {
    return null;
  }
  return List.unmodifiable(nodes.map((n) {
    return TreeNode(
      key: keyProvider.key(n.key),
      content: n.content,
      children: _copyNodesRecursively(n.children, keyProvider),
    );
  }));
}


class _TreeNodeKey extends ValueKey {
  _TreeNodeKey(dynamic value) : super(value);
}

/// Provides unique keys and verifies duplicates.
class KeyProvider {
  int _nextIndex = 0;
  final Set<Key> _keys = <Key>{};

  /// If [originalKey] is null, generates new key, otherwise verifies the key
  /// was not met before.
  Key key(Key? originalKey) {
    if (originalKey == null) {
      return _TreeNodeKey(_nextIndex++);
    }
    if (_keys.contains(originalKey)) {
      throw ArgumentError('There should not be nodes with the same keys. '
          'Duplicate value found: $originalKey.');
    }
    _keys.add(originalKey);
    return originalKey;
  }
}

