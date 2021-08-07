import 'package:flutter/material.dart';

class TreeNode {
  final List<TreeNode>? children;
  final String content;
  final Key? key;

  TreeNode({this.key, this.children, String? content})
      : content = content ?? '';
}