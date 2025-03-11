import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GenderSelectionWidget extends StatefulWidget {
  const GenderSelectionWidget({super.key});

  @override
  State<GenderSelectionWidget> createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  List<Widget> genders = [

  ];
  bool isMan = true;


  @override
  Widget build(BuildContext context) {
    Widget man = Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: GenderWidget(isMan: true, isSelected: isMan),
      ),
    );

    Widget woman = Align(
      alignment: Alignment.centerRight,
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: GenderWidget(isMan: false, isSelected: !isMan),
      ),
    );

    genders = isMan? [woman, man] :  [man, woman];

    return GestureDetector(
      onTap: (){
        setState(() {
          isMan = !isMan;
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: const BorderSide(
              color: Colors.grey,
              width: 1.0,
            )
        ),
        child: Stack(
          children: genders,
        ),
      ),
    );
  }
}

class GenderWidget extends StatelessWidget {
  const GenderWidget({super.key, required this.isMan, required this.isSelected});
  final bool isMan;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.greenAccent : Colors.white,
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          ),
          borderRadius: BorderRadius.only(
            topLeft: !isMan ? const Radius.circular(4.0) : Radius.zero,
            bottomLeft:!isMan ? const Radius.circular(4.0) : Radius.zero,
            topRight: isMan ? const Radius.circular(4.0) : Radius.zero,
            bottomRight:  isMan ? const Radius.circular(4.0) : Radius.zero,
          ),
        ),
        child: SizedBox.expand(
            child: Center(child: SvgPicture.asset('assets/image/${isMan?'man':'woman'}.svg', width: 20,))
        )
    );
  }
}