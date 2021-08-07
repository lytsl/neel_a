import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neel_a/constants/colors.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.onChanged,
    required this.hint,
    required this.isDarkMode,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.isPasswordVisible,
    this.onVisibilityChanged,
    this.textEditingController,
    this.isEnabled = true,
    this.autoFocus = false,
  }) : super(key: key);

  final bool isDarkMode;
  final void Function(String) onChanged;
  final String hint;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final bool? isPasswordVisible;
  final bool isEnabled,autoFocus;
  final void Function()? onVisibilityChanged;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    final _greyColor = isDarkMode ? greyColorDark : greyColor;
    late final Color _textColor;

    if (!isEnabled)
      _textColor = _greyColor;
    else if (isDarkMode)
      _textColor = Colors.white;
    else
      _textColor = Colors.black;

    return TextField(
      onChanged: onChanged,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      controller: textEditingController,
      autofocus: autoFocus,
      style: TextStyle(
        fontSize: 14,
        color: _textColor,
      ),
      obscureText: !(isPasswordVisible ?? true),
      decoration: InputDecoration(
        enabled: isEnabled,
        labelText: this.hint,
        labelStyle: TextStyle(
          fontSize: 14,
          color: _greyColor,
        ),
        suffixIcon: (isPasswordVisible == null)
            ? null
            : GestureDetector(
                onTap: onVisibilityChanged,
                child: !(isPasswordVisible!)
                    ? Icon(
                        Icons.visibility_off_outlined,
                        color: _greyColor,
                        size: 16,
                      )
                    : Icon(
                        Icons.visibility_outlined,
                        color: _greyColor,
                        size: 16,
                      ),
              ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: _greyColor,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: _greyColor,
          ),
        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: _greyColor,
          ),
        ),
        isDense: true,
        suffixIconConstraints: BoxConstraints.tight(Size(16, 16)),
        contentPadding: EdgeInsets.zero,
      ),
    );
  }
}
