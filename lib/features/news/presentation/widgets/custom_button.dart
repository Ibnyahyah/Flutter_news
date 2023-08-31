import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.text, this.onPressed, this.outlined = false, super.key});

  final String text;
  final bool outlined;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: outlined ? Colors.white : Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: outlined
                ? const BorderSide(color: Colors.amber, width: 2)
                : BorderSide.none,
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: Text(
          text,
          style: TextStyle(color: outlined ? Colors.amber : Colors.white),
        ),
      ),
    );
  }
}
