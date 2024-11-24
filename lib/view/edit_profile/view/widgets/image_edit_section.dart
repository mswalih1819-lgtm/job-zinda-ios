import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/widgets/text_widget.dart';
import 'package:jora_customer/model/logged_in_user.dart';
import 'package:jora_customer/view/wrapper/view/widgets/wrapper_body.dart';
import 'package:jora_customer/view_model/file_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class ImageEditSection extends StatelessWidget {
  const ImageEditSection({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewModel = context.watch<ProfileViewModel>();
    return Row(
      children: [
        CircleAvatar(
          radius: 46,
          backgroundColor: PColors.white,
          child: CircleAvatar(
            radius: 44,
            backgroundImage: NetworkImage(LoggedInUser.profilePic??''),
          ),
        ),
        SizedBox(
          width: 20,
        ),
       TextButton(onPressed: ()async{XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
       
       
       if(image!=null){
String url =await context.read<FileUploadViewModel>().pickedImageUpload(image, 'DP')??'' ;




        profileViewModel.updateProfileImage(url: url);
       }
       }, child:  Row(
          children: [Icon(Icons.add , color: Colors.white,), textWidget(text: 'Upload image' , color: Colors.white)],
        ),)
      ],
    );
  }
}
