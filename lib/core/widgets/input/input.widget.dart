import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  final controller;
  final String labelText;
  final bool obscureText;
  final FocusNode focusNode;
  final Widget prefixIcon;
  final bool rounded;
  final TextInputType keyboardType;
  final bool enabled;
  final List<TextInputFormatter> inputFormatters;
  final Function(String value) onSubmitted;
  final Function(String value) onChanged;

  Input({
    this.controller,
    this.labelText,
    this.obscureText = false,
    this.onSubmitted,
    this.onChanged,
    this.prefixIcon,
    this.focusNode,
    this.keyboardType,
    this.rounded = false,
    this.enabled = true,
    this.inputFormatters = const [],
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return TextField(
      obscureText: this.obscureText,
      controller: this.controller,
      onSubmitted: this.onSubmitted,
      focusNode: this.focusNode,
      onChanged: this.onChanged,
      keyboardType: this.keyboardType,
      inputFormatters: this.inputFormatters,
      enabled: this.enabled,
      style: this.enabled
          ? null
          : TextStyle(
              color: Colors.grey[500],
            ),
      decoration: InputDecoration(
        labelText: this.labelText,
        prefixIcon: this.prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: this.rounded
              ? BorderRadius.circular(80)
              : BorderRadius.circular(4),
        ),
        fillColor: Colors.grey[200],
        filled: !this.enabled,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
          borderRadius: this.rounded
              ? BorderRadius.circular(80)
              : BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: theme.primaryColor,
            width: 1,
          ),
          borderRadius: this.rounded
              ? BorderRadius.circular(80)
              : BorderRadius.circular(4),
        ),
      ),
    );
  }
}
