import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_resume/custom_icons.dart';

class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showAlertDialog(context);
      },
      child: Card(
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
      ),
    );
  }
}

void _showAlertDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
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
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/image/maximize-3.svg'),
                  SvgPicture.asset('assets/image/rotate-left.svg'),
                  SvgPicture.asset('assets/image/rotate-right.svg'),
                  SvgPicture.asset('assets/image/scissor.svg'),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(52, 138, 167, 1),
                    //rgba(52, 138, 167, 1)
                    padding: const EdgeInsets.all(16.0),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Установить фото',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            )
          ],
        ),
      );
    },
  );
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
