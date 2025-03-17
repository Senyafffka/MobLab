
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfilePhotoPickerWidget extends StatelessWidget {
  const ProfilePhotoPickerWidget({super.key, required this.onClickCameraArea, required this.onClickFolderArea});
  final void Function() onClickCameraArea;
  final void Function() onClickFolderArea;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 260,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(93, 211, 158, 1),
            Color.fromRGBO(188, 231, 132, 1),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: GestureDetector(
        onTapDown: (d) {

          double x = d.localPosition.dx, y = d.localPosition.dy;
          double lineY = (-13 / 10) * x + 200;
          if (lineY < y) {
            onClickCameraArea();
          } else {
            onClickFolderArea();
          }
        },
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0.8, 1),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/image/camera.svg'),
                  const Text(
                    'Сделать фото',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            Align(
              alignment: const Alignment(-0.8, -1),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset('assets/image/folder.svg'),
                  const Text(
                    'Загрузить \n с устройства',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
            CustomPaint(
              size: const Size(200, 260),
              painter: LinePainter(),
            )
          ],
        ),
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;
    final startPoint = Offset(size.width, 0);

    final endPoint = Offset(0, size.height);

    canvas.drawLine(startPoint, endPoint, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
