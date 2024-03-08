import 'package:flutter/material.dart';
import 'package:r_p_s_game/core/base/state.dart';

class CustomButton extends StatefulWidget {
  final String? text;
  final Function onPressed;
  bool isPressed;
  CustomButton({super.key, this.text, required this.onPressed, this.isPressed = true});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends BaseState<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () => widget.onPressed(),
        style: ElevatedButton.styleFrom(
          side: const BorderSide(width: 1),
          backgroundColor: widget.isPressed ? colors.darkBlue : colors.lightBlue2,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0) + const EdgeInsets.all(10),
          child: Text(
            widget.text ?? '',
            style: TextStyle(color: colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
        ));
  }
}
