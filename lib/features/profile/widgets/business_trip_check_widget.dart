import 'package:flutter/material.dart';
import 'package:my_resume/features/profile/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class BusinessTripCheckWidget extends StatelessWidget {
  const BusinessTripCheckWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, vm, child) {
        return Checkbox(
            activeColor: const Color.fromRGBO(188, 231, 132, 1),
            checkColor: Colors.grey,
            side: WidgetStateBorderSide.resolveWith(
                  (Set<WidgetState> states) {
                return const BorderSide(color: Colors.grey, width: 2.0,);
              },
            ),
            value: vm.profileIsReady,
            onChanged: (_) => vm.changeReady(),
        );
      },
    );
  }
}
