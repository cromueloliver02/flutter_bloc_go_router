import 'package:flutter/material.dart';

class DropdownButtonFormField<T> extends StatelessWidget {
  final FocusNode? focusNode;
  final String? hintText;
  final T? value;
  final String? labelText;
  final List<DropdownMenuItem<T>>? items;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;
  final Function(T?)? onSaved;

  const DropdownButtonFormField({
    super.key,
    required this.hintText,
    required this.value,
    required this.items,
    this.focusNode,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField<T>(
          hintText: hintText,
          labelText: labelText,
          focusNode: focusNode,
          value: value,
          items: items,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          validator: validator,
          onChanged: onChanged,
          onSaved: onSaved,
        ),
      ),
    );
  }
}
