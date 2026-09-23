import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PSvgs.dart';
import 'package:jora_customer/view/my_profile/view/widgets/my_profile_button.dart';
import 'package:jora_customer/view/my_profile/view/widgets/profile_head_ui.dart';
import 'package:jora_customer/Settings/until/PPages.dart';
import 'package:go_router/go_router.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:jora_customer/view_model/subscription_view_model.dart';
import 'package:provider/provider.dart';

import 'widgets/self_gallery_section.dart';
import 'widgets/profile_experience_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch profile and plans data when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ProfileViewModel>().fetchProfile();
        context.read<SubscriptionViewmodel>().fetchPlans();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ProfileViewModel profileViewModel = context.watch<ProfileViewModel>();

    // Show a loader while the profile is still being fetched
    if (profileViewModel.profileModel == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // This screen should only be shown for premium/freelancer users
    // Normal users are handled by the route definition in main.dart
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(
              Icons.more_vert,
              color: Color(0xFF8A4FFF),
            ),
            onSelected: (value) {
              if (value == 'upgrade') {
                context.push(PPages.planListUi);
              } else if (value == 'courses') {
                context.push(PPages.coursePurchaseUi);
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'upgrade',
                child: Text('Upgrade',
                    style: TextStyle(
                      color: Color(0xFF8A4FFF),
                    )),
              ),
              const PopupMenuItem<String>(
                value: 'courses',
                child: Text('Courses',
                    style: TextStyle(
                      color: Color(0xFF8A4FFF),
                    )),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              ProfileHeadUi(
                icon: PSvgs.myProfileAnalytics,
                profileModel: profileViewModel.profileModel,
              ),

              const SizedBox(height: 8),

              const MyProfileButtonUi(),

              const SizedBox(height: 20),

              // My Experience section
              ProfileExperienceSection(
                phoneNumber: profileViewModel.profileModel?.contactNumber ??
                    profileViewModel.profileModel?.mobileNumber ??
                    '',
                whatsappNumber: profileViewModel.profileModel?.whatsappNumber ??
                    profileViewModel.profileModel?.mobileNumber ??
                    '',
                whatsappLink: profileViewModel.profileModel?.whatsappLink ?? '',
                directCallLink:
                    profileViewModel.profileModel?.directCallLink ?? '',
                instagramUrl:
                    profileViewModel.profileModel?.instagramLink ?? '',
                linkedinUrl: profileViewModel.profileModel?.linkedinLink ?? '',
                experiences: profileViewModel.profileModel?.experiences,
              ),

              const SizedBox(height: 10),

              // Existing Gallery
              const SelfGallerySection(),
            ],
          ),
        ),
      ),
    );
  }
}
