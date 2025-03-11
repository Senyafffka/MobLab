import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({
    super.key, required this.title, this.showTitle = true, this.maxHeight = 25
  });

  final String title;
  final bool showTitle;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          )
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (showTitle) ? Text(title, style: const TextStyle(fontFamily: 'Roboto', color: Colors.grey),) : const SizedBox(),
            TextField(
              style: const TextStyle(fontFamily: 'Roboto', color: Color.fromRGBO(76, 59, 77, 0.9)),
              decoration: InputDecoration(
                border: InputBorder.none,
                constraints: BoxConstraints(maxHeight: maxHeight),
              ),
            )
          ],
        ),
      ),
    );
  }
}