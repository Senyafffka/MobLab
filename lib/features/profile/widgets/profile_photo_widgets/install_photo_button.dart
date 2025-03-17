import 'package:flutter/material.dart';

class InstallPhotoButton extends StatelessWidget {
  const InstallPhotoButton({super.key, required this.onClick});
  final void Function() onClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: const Color.fromRGBO(52, 138, 167, 1),
            //rgba(52, 138, 167, 1)
            padding: const EdgeInsets.all(16.0),
          ),
          onPressed: onClick,
          child: const Text(
            'Установить фото',
            style: TextStyle(fontSize: 20, color: Colors.white),
          )),
    );
  }
}
