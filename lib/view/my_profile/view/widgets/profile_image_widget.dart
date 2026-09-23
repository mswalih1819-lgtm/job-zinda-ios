import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:jora_customer/widgets/safe_cached_network_image.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PImages.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/model/profile_model.dart';
import 'package:jora_customer/view/wrapper/view_model/view_model.dart';
import 'package:jora_customer/view_model/profile_analytics_view_model.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

// import '../../../../view_model/file_view_model.dart';

class ProfileImageWidget extends StatelessWidget {
  final String? icon;
  final ProfileModel? profileModel;
  const ProfileImageWidget({super.key, this.icon, required this.profileModel});

  @override
  Widget build(BuildContext context) {
    context.watch<ProfileViewModel>();
    return buildCoverImage(context);
  }

  Widget buildCoverImage(BuildContext context) {
    final imageUrl = profileModel?.profileImageUrl;
    final hasValidImageUrl = imageUrl != null &&
        imageUrl.isNotEmpty &&
        (imageUrl.startsWith('http://') || imageUrl.startsWith('https://'));

    return SizedBox(
      width: 96,
      height: 96,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: CircleAvatar(
              radius: 38,
              backgroundColor: PColors.white,
              child: CircleAvatar(
                radius: 34,
                backgroundImage: hasValidImageUrl
                    ? safeImageProvider(imageUrl,
                        placeholderAsset: PImages.profile)
                    : AssetImage(PImages.profile) as ImageProvider,
                onBackgroundImageError: (exception, stackTrace) {
                  debugPrint(
                      "NetworkImage error loading profile avatar: $exception");
                  debugPrint(
                      "Attempted profile avatar URL: ${profileModel?.profileImageUrl}");
                },
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 0,
            child: Selector<WrapperViewModel, String>(
              selector: (p0, p1) => p1.viewStatus,
              builder: (context, value, child) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null)
                    GestureDetector(
                      onTap: () async {
                        await context
                            .read<ProfileAnalyticsViewModel>()
                            .fetchProfileAnalytics(filter: '7days');
                        context.pushNamed(PPages.profileAnalyticsPageUi);
                      },
                      child: SvgPicture.asset(icon!, height: 30),
                    ),
                  if (icon != null) const SizedBox(width: 10),
                  if (WrapperViewStatus.profile == value)
                    GestureDetector(
                      onTap: () {
                        context.pushNamed(PPages.helpSupportUi);
                      },
                      child: SvgPicture.asset(PSvgs.help, height: 30),
                    ),
                  if (WrapperViewStatus.profile == value)
                    const SizedBox(width: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
