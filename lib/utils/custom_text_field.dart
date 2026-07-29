import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.height,
    this.hintText,
    this.maxLines,
    this.prefixIcon,
    required this.controller,
    required this.textInputAction,
    required this.textInputType,
    this.focusNode,
    this.titleToSubtitle,
    this.labelText,
  });

  final double? height;
  final String? hintText;
  final int? maxLines;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final FocusNode? focusNode;
  final FocusNode? titleToSubtitle;
  final String? labelText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return "Please set a title";
          } else {
            return null;
          }
        },
        onFieldSubmitted: (value) {
          FocusScope.of(context).requestFocus(titleToSubtitle);
        },
        focusNode: focusNode,
        textInputAction: textInputAction,
        controller: controller,
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        cursorHeight: 20,
        maxLines: maxLines,
        keyboardType: textInputType,
        style: TextStyle(
          color: Theme.of(context).textSelectionTheme.cursorColor,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          prefixIcon: Icon(
            prefixIcon,
            color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
            size: 25,
          ),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.6)),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withValues(alpha: 0.6)),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
