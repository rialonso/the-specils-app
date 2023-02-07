import 'package:flutter/material.dart';
import 'package:the_specials_app/shared/styles/colors.dart';

class ButtonPrimary extends StatelessWidget {
  final VoidCallback onPressed;
  final String texto;

  const ButtonPrimary({Key? key, required this.onPressed, required this.texto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
          backgroundColor: DefaultColors.purpleBrand,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
      ),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
}

class ButtonSecondary extends StatelessWidget {
  final VoidCallback onPressed;
  final String texto;

  const ButtonSecondary(
      {Key? key, required this.onPressed, required this.texto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
          backgroundColor: Colors.white,
          side: const BorderSide(width: 1.0, color: DefaultColors.blueBrand),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0)
        ),
      ),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 18, color: DefaultColors.blueBrand),
      ),
    );
  }
}
