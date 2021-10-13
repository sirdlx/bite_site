import 'package:flutter/material.dart';

class LBTextField extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onChanged;
  final String? initialValue;
  final void Function(String?)? onSaved;
  const LBTextField({
    Key? key,
    this.labelText,
    this.controller,
    required this.onChanged,
    this.textInputAction,
    this.keyboardType,
    this.initialValue,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      initialValue: initialValue,
      onSaved: onSaved,
      validator: (input) {
        return input == null || input.isEmpty || !input.contains('@')
            ? 'Please enter a valid email'
            : null;
      },
      controller: controller,
      // cursorRadius: Radius.circular(16.0),
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onChanged: onChanged,
    );
  }
}
