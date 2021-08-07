import 'package:flutter/material.dart';

class HomeMenuDialog extends StatelessWidget {
  const HomeMenuDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(),
    );
  }
}
