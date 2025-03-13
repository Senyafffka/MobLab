import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:my_resume/features/profile/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class InputWidget extends StatelessWidget {
  InputWidget({super.key, this.title, this.maxHeight = 25, required this.tag}) {
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        viewModel.updateProfile(tag, _textController.text);
      }
    });
  }

  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  late final ProfileViewModel viewModel;

  final String tag;
  final String? title;
  final double maxHeight;

  @override
  Widget build(BuildContext context) {
    viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    return Consumer<ProfileViewModel>(
      builder: (BuildContext context, viewmodel, Widget? child) {

        _textController.text = viewmodel.getField(tag);
        bool isNotSaved = viewmodel.isIncorrectFields(tag);

        Logger().i('[tag-isNotSaved] $tag - $isNotSaved');

        return Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: const BorderSide(
                color: Colors.grey,
                width: 1.0,
              )),
          child: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (title!=null)
                    ? Text(
                  title!,
                  style: const TextStyle(fontFamily: 'Roboto', color: Colors.grey),
                )
                    : const SizedBox(),
                TextField(
                  controller: _textController,
                  focusNode: _focusNode,
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
      },
    );
  }
}

