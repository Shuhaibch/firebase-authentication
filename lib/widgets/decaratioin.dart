import 'package:flutter/material.dart';

InputDecoration loginInputDecation(
  String label,
) {
  return InputDecoration(
    helperText: label,
    
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      
      borderSide: const BorderSide(
        strokeAlign: .5,
        width: 5,
        style: BorderStyle.solid,
      ),
    ),
  );
}
