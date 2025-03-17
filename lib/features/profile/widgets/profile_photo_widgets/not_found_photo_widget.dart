import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_resume/custom_icons.dart';

class NotFoundPhotoWidget extends StatelessWidget {
  const NotFoundPhotoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(93, 211, 158, 1),
              Color.fromRGBO(188, 231, 132, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/image/user.svg',
                color: const Color.fromRGBO(76, 59, 77, 1),
              ),
              const Text(
                'Добавить фото',
                style: TextStyle(
                    fontFamily: 'Roboto',
                    color: Color.fromRGBO(76, 59, 77, 1)),
              ),
              const Icon(
                CustomIcons.plus_1,
                color: Color.fromRGBO(76, 59, 77, 1),
                size: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
