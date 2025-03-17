import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:image_editor/image_editor.dart' hide ImageSource;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_resume/features/profile/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

import 'profile_photo_widgets/profile_photo_widgets.dart';


class ProfilePhoto extends StatelessWidget {
  const ProfilePhoto({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, vm, _) {
        return GestureDetector(
          onTap: () {
            vm.openPhotoLoader();
          },
          child: (vm.img == null) ? const NotFoundPhotoWidget() :
          Image.memory(
              vm.img!,
            fit: BoxFit.scaleDown,
          ),
        );
      }
    );
  }
}

class PhotoLoaderWidget extends StatefulWidget {
  const PhotoLoaderWidget({super.key});

  @override
  State<PhotoLoaderWidget> createState() => _PhotoLoaderWidgetState();
}

class _PhotoLoaderWidgetState extends State<PhotoLoaderWidget> {
  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey();
  final ImageEditorController _editorController = ImageEditorController();
  final ImagePicker picker = ImagePicker();

  bool _hasPhoto(BuildContext context) {
    if (provider == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Загрузите фотографию!',
            style: TextStyle(color: Colors.white70),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.redAccent,
        ),
      );
      return false;
    }
    return true;
  }

  //ImageProvider provider1 = ExtendedFileImageProvider(file)
  ImageProvider? provider;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: (){
            Provider.of<ProfileViewModel>(context, listen: false).closePhotoLoader();
          },
          child: const ColoredBox(
              color: Color.fromRGBO(0, 0, 0, 0.7),
            child: SizedBox.expand(),
          ),
        ),
        Center(
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  (provider == null)
                      ? ProfilePhotoPickerWidget(
                          onClickCameraArea: () {
                            picker.pickImage(source: ImageSource.camera).then((file) {
                              if (file == null) return;
                              provider = ExtendedFileImageProvider(File(file.path),
                                  cacheRawData: true);
                              setState(() {});
                            });
                          },
                          onClickFolderArea: () {
                            picker.pickImage(source: ImageSource.gallery).then((file) {
                              if (file == null) return;
                              provider = ExtendedFileImageProvider(File(file.path),
                                  cacheRawData: true);
                              setState(() {});
                            });
                          },
                        )
                      : ExtendedImage(
                          image: provider!,
                          width: 200,
                          height: 260,
                          extendedImageEditorKey: editorKey,
                          mode: ExtendedImageMode.editor,
                          fit: BoxFit.contain,
                          initEditorConfigHandler: (_) => EditorConfig(
                            maxScale: 8.0,
                            cropRectPadding: const EdgeInsets.all(20.0),
                            hitTestSize: 20.0,
                            cropAspectRatio: 2 / 1,
                            controller: _editorController,
                          ),
                        ),
                  ProfilePhotoActions(
                    //photo actions--------------------------------------------------------------------------------------------------
                    onCrop: () async {
                      if (!_hasPhoto(context)) return;
                      await crop(_editorController);
                    },
                    onReverse: () {
                      if (!_hasPhoto(context)) return;
                      flip();
                    },
                    onRotateLeft: () {
                      if (!_hasPhoto(context)) return;
                      rotate(false);
                    },
                    onRotateRight: () {
                      if (!_hasPhoto(context)) return;
                      rotate(true);
                    },
                  ),
                  InstallPhotoButton(
                    onClick: () {
                      var vm =  Provider.of<ProfileViewModel>(context, listen: false);
                      if(provider!=null)vm.installPhoto(editorKey.currentState!.rawImageData);
                      vm.closePhotoLoader();
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //image editor func
  void flip() {
    editorKey.currentState?.flip();
  }

  void rotate(bool right) {
    editorKey.currentState?.rotate(
      degree: right ? 90 : -90,
    );
  }

  Future<void> crop(ImageEditorController imageEditorController) async {
    final EditActionDetails action = imageEditorController.editActionDetails!;

    final Uint8List img = imageEditorController.state!.rawImageData;

    final ImageEditorOption option = ImageEditorOption();

    if (action.hasRotateDegrees) {
      final int rotateDegrees = action.rotateDegrees.toInt();
      option.addOption(RotateOption(rotateDegrees));
    }
    if (action.flipY) {
      option.addOption(const FlipOption(horizontal: true, vertical: false));
    }

    if (action.needCrop) {
      Rect cropRect = imageEditorController.getCropRect()!;
      if (imageEditorController.state!.widget.extendedImageState.imageProvider
      is ExtendedResizeImage) {
        final ImmutableBuffer buffer = await ImmutableBuffer.fromUint8List(img);
        final ImageDescriptor descriptor =
        await ImageDescriptor.encoded(buffer);

        final double widthRatio =
            descriptor.width / imageEditorController.state!.image!.width;
        final double heightRatio =
            descriptor.height / imageEditorController.state!.image!.height;
        cropRect = Rect.fromLTRB(
          cropRect.left * widthRatio,
          cropRect.top * heightRatio,
          cropRect.right * widthRatio,
          cropRect.bottom * heightRatio,
        );
      }
      option.addOption(ClipOption.fromRect(cropRect));
    }
  }
}
