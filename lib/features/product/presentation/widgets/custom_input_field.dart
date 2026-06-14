import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInputField {

  CustomInputField();
  
  static TextField createField({
    required TextEditingController controller,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    void Function(String)? onChanged,
    void Function()? onEditingComplete,
    String? labelText,
    bool? readOnly,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      readOnly: readOnly ?? false,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}