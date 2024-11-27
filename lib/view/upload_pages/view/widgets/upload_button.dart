import 'dart:developer';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/custom_icon_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view_model/file_view_model.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class UploadButtonUi extends StatefulWidget {
  const UploadButtonUi({super.key});

  @override
  State<UploadButtonUi> createState() => _UploadButtonUiState();
}

class _UploadButtonUiState extends State<UploadButtonUi> {
  final ImagePicker _picker = ImagePicker();


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10, left: 12, right: 12),
      child: CustomIconElevatedButton(
          bgcolor: PColors.black2.withOpacity(0.9),
          textColor: PColors.whiteOff.withOpacity(0.6),
          text: 'Upload media',
          borderRadius: 1,
          onPressed: () {
            showBottomSheet(
              shape: const BeveledRectangleBorder(),
              backgroundColor: PColors.seed2,
              context: context,
              builder: (context) => sheet(),
            );
          },
          icon: Image.asset(
            PImages.photo,
            color: PColors.whiteOff.withOpacity(0.9),
          )),
    );
  }

  Widget sheet() {
    return SizedBox(
      width: 360,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: PColors.white,
                    )),
              ],
            ),
            ListTile(
              onTap: () {
                getImage(ImageSource.camera);
              },
              leading: Icon(Icons.camera, color: PColors.white),
              title: textWidget(text: 'Camera', color: PColors.white),
            ),
            ListTile(
              onTap: () {
                getImage(ImageSource.gallery);
              },
              leading: Icon(Icons.photo, color: PColors.white),
              title: textWidget(text: 'Gallery', color: PColors.white),
            ),
                  ListTile(
              onTap: () {Navigator.pop(context);
               _pickVideo(context);
              },
              leading: Icon(Icons.videocam_rounded, color: PColors.white),
              title: textWidget(text: 'Video', color: PColors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage(ImageSource source) async {  Navigator.pop(context);
    final XFile? image = await _picker.pickImage(source: source);
  
    if (image != null) {
      String? url = await context
          .read<FileUploadViewModel>()
          .pickedImageUpload(image, 'Post');
           PostViewModel postProvider = context.read<PostViewModel>();
    postProvider.selectedMediaType='image';
     postProvider.selectedUrl = url;
    }
  }
  void _pickVideo(BuildContext context) async {
  FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
    type: FileType.video,
  );

  // final XFile? video = await _picker.pickVideo(source: ImageSource.gallery);

  //    if (video != null) {
  //     String? url = await context
  //         .read<FileUploadViewModel>()
  //         .pickedImageUpload(video, 'Post');
  //          PostViewModel postProvider = context.read<PostViewModel>();
  //   postProvider.selectedMediaType='video';
  //    postProvider.selectedUrl = url;
  //    log(postProvider.selectedUrl.toString());
  //   }

  if (pickedFile != null && pickedFile.files.isNotEmpty) {
    final Uint8List fileBytes = pickedFile.files.first.bytes ?? Uint8List(0);
    FileUploadViewModel provider = context.read<FileUploadViewModel>();
    PostViewModel postProvider = context.read<PostViewModel>();
    postProvider.selectedMediaType='video';
  postProvider.selectedUrl  = await provider.pickedVideoUpload(
        fileBytes, pickedFile.files.first.name);
  } else {
    debugPrint('No file was picked');
  }
}
}
