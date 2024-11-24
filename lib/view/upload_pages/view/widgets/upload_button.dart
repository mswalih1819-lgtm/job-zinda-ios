import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/custom_icon_elevated_button.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/view/upload_pages/view/widgets/add_post_screen.dart';
import 'package:jora_customer/view_model/file_view_model.dart';
import 'package:jora_customer/view_model/post_view_model.dart';
import 'package:provider/provider.dart';

class UploadButtonUi extends StatefulWidget {
  UploadButtonUi({super.key});

  @override
  State<UploadButtonUi> createState() => _UploadButtonUiState();
}

class _UploadButtonUiState extends State<UploadButtonUi> {
  final ImagePicker _picker = ImagePicker();

  XFile? _image;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10,left: 12,right: 12),
      child: CustomIconElevatedButton(
          bgcolor:PColors.black2.withOpacity(0.9),
          textColor: PColors.whiteOff.withOpacity(0.6),
          text: "Upload media",
          borderRadius: 1,
          onPressed: () {
            showBottomSheet(
              shape: BeveledRectangleBorder(),
              backgroundColor: PColors.seed2,
              context: context,
              builder: (context) => sheet(),
            );
          },
          icon: Image.asset(
            PImages.photo,
         color:    PColors.whiteOff.withOpacity(0.9),
          )),
    );
  }

  Widget sheet() {
    return Container(
      width: 360,
      height: 200,
      
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
                    child: Icon(Icons.close,color: PColors.white,)),
              ],
            ),
            ListTile(
              onTap: () {
                getImage(ImageSource.camera);
              },
              leading: Icon(Icons.camera, color: PColors.white),
              title: textWidget(text: "Camera", color: PColors.white),
            ),
            ListTile(
              onTap: () {
                getImage(ImageSource.gallery);
              },
              leading: Icon(Icons.photo, color: PColors.white),
              title: textWidget(text: 'Gallery', color: PColors.white),
            ),
          ],
        ),
      ),
    );
  }

  Future getImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    Navigator.pop(context);
if(image!=null){
String?url= await  context.read<FileUploadViewModel>().pickedImageUpload(image, 'Post');
  context.read<PostViewModel>().selectedUrl  =url;
}
  
  }
}
