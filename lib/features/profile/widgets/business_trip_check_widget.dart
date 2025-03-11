import 'package:flutter/material.dart';

class BusinessTripCheckWidget extends StatefulWidget {
  const BusinessTripCheckWidget({super.key});

  @override
  State<BusinessTripCheckWidget> createState() => _BusinessTripCheckWidgetState();
}

class _BusinessTripCheckWidgetState extends State<BusinessTripCheckWidget> {
  bool ready = true;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor:  const Color.fromRGBO(188, 231, 132, 1),
        checkColor:Colors.grey,
        side: WidgetStateBorderSide.resolveWith(
              (Set<WidgetState> states) {
            return const BorderSide(color: Colors.grey, width: 2.0,);
          },
        ),
        value: ready,
        onChanged: (answer){
          setState(() {
            ready = answer ?? false;
          });
        }
    );
  }
}