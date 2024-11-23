import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/view/my_profile/view/widgets/single_gallery_widget.dart';

class GalleryUi extends StatelessWidget {
  GalleryUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: galleryList(),
    );
  }

  galleryList() {
    return GridView.builder(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: .8),
      itemCount: list.length,
      itemBuilder: (context, index) => SingleGalleryWidget(map: list[index]),
    );
  }

  List list = [
    {"image": PImages.gallery1},
    {"image": PImages.gallery2},
    {"image": PImages.gallery1},
    {"image": PImages.gallery2},
    {"image": PImages.gallery1},
    {"image": PImages.gallery2},
  ];
}
