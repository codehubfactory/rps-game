import 'package:flutter/material.dart';

Widget scoreCard(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10.0),
    child: Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: color),
      child: Center(
        child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 24)),
      ),
    ),
  );
}
