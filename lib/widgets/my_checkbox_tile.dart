import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';

class MyCheckBox extends StatelessWidget {
  const MyCheckBox({
    Key? key,
    required this.isDarkMode,
    required this.value,
    required this.onChanged,
    required this.label,
  }) : super(key: key);

  final bool isDarkMode, value;
  final String label;
  final Function() onChanged;

  @override
  Widget build(BuildContext context) {
    final _primaryColor = isDarkMode ? (primaryColorDark) : primaryColor;
    return Row(
      children: [
        SizedBox(
          width: 24,
        height: 24,
          child: Transform.scale(
            scale: 0.8,
            child: Checkbox(
              activeColor: _primaryColor,
              value: value,
              onChanged: (v) => onChanged(),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ),
        //SizedBox(width: 4),
        GestureDetector(
          onTap: onChanged,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 12),
            child: Text(
              label,
              style: TextStyle(fontSize: 12.0),
            ),
          ),
        )
      ],
    );
  }
}
