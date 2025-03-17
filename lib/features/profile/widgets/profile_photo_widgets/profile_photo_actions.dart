import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePhotoActions extends StatelessWidget {
  const ProfilePhotoActions({super.key, required this.onReverse, required this.onRotateLeft, required this.onRotateRight, required this.onCrop});
  final void Function() onReverse;
  final void Function() onRotateLeft;
  final void Function() onRotateRight;
  final void Function() onCrop;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: onReverse,
            child: SvgPicture.asset('assets/image/maximize-3.svg'),
          ),
          TextButton(
            onPressed: onRotateLeft,
            child: SvgPicture.asset('assets/image/rotate-left.svg'),
          ),
          TextButton(
            onPressed: onRotateRight,
            child: SvgPicture.asset('assets/image/rotate-right.svg'),
          ),
          TextButton(
            onPressed: onCrop,
            child: SvgPicture.asset('assets/image/scissor.svg'),
          ),
        ],
      ),
    );
  }
}
