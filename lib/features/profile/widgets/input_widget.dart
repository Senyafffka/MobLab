import 'package:flutter/material.dart';
import 'package:my_resume/features/profile/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class InputWidget extends StatefulWidget {
  const InputWidget({super.key, required this.tag, this.title, this.maxHeight = 25});
  final String tag;
  final String? title;
  final double maxHeight;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> with TickerProviderStateMixin{
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late final ProfileViewModel viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = Provider.of<ProfileViewModel>(context, listen: false);
    viewModel.addListener((){
      _textController.text = viewModel.getField(widget.tag);
      if(viewModel.isIncorrectFields(widget.tag))_startAnimation();
    });
  }

  void _startAnimation() {
    _controller.forward().then((_){
      _controller.reverse();
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        viewModel.updateProfile(widget.tag, _textController.text);
      }
    });

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _colorAnimation = ColorTween(
      begin: Colors.white70,
      end: Colors.redAccent,
    ).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
    _textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: const BorderSide(
            color: Colors.grey,
            width: 1.0,
          )),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget? child) {
          return Container(
            color: _colorAnimation.value,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  (widget.title!=null)
                      ? Text(
                    widget.title!,
                    style: const TextStyle(fontFamily: 'Roboto', color: Colors.grey),
                  )
                      : const SizedBox(),
                  TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    style: const TextStyle(fontFamily: 'Roboto', color: Color.fromRGBO(76, 59, 77, 0.9)),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      constraints: BoxConstraints(maxHeight: widget.maxHeight),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

