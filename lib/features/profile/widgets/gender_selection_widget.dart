import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_resume/const/enums/gender_enum.dart';
import 'package:my_resume/features/profile/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class GenderSelectionWidget extends StatefulWidget {
  const GenderSelectionWidget({super.key});

  @override
  State<GenderSelectionWidget> createState() => _GenderSelectionWidgetState();
}

class _GenderSelectionWidgetState extends State<GenderSelectionWidget> {
  List<Widget> genders = [];
  bool isMan = true;

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ProfileViewModel>(context, listen: false);

    return GestureDetector(
      onTap: () {
        setState(() {
          viewModel.changeGender();
        });
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: const BorderSide(
              color: Colors.grey,
              width: 1.0,
            )),
        child: Consumer<ProfileViewModel>(
          builder: (BuildContext context, ProfileViewModel vm, Widget? child) {
            List<Widget> children = [
              WomanWidget(isSelected: vm.profileGender == GenderEnum.woman),
              ManWidget(isSelected: vm.profileGender == GenderEnum.man,)
            ];
            return Stack(
              children: vm.profileGender == GenderEnum.man ? children : children.reversed.toList(),
            );
          },
        ),
      ),
    );
  }
}

class WomanWidget extends StatelessWidget {
  const WomanWidget({super.key, required this.isSelected});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: GenderWidget(isMan: false, isSelected: isSelected),
      ),
    );;
  }
}

class ManWidget extends StatelessWidget {
  const ManWidget({super.key, required this.isSelected});
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: FractionallySizedBox(
        widthFactor: 0.6,
        child: GenderWidget(isMan: true, isSelected: isSelected),
      ),
    );
  }
}

class GenderWidget extends StatelessWidget {
  const GenderWidget(
      {super.key, required this.isMan, required this.isSelected});

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
            bottomLeft: !isMan ? const Radius.circular(4.0) : Radius.zero,
            topRight: isMan ? const Radius.circular(4.0) : Radius.zero,
            bottomRight: isMan ? const Radius.circular(4.0) : Radius.zero,
          ),
        ),
        child: SizedBox.expand(
            child: Center(
                child: SvgPicture.asset(
                  'assets/image/${isMan ? 'man' : 'woman'}.svg',
                  width: 20,
                ))));
  }
}
