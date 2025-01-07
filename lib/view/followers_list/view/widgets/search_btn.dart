import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class FollowerSearchButtonUi extends StatefulWidget {
  String? profileId;
  FollowerSearchButtonUi({super.key, required this.profileId});

  @override
  State<FollowerSearchButtonUi> createState() => _FollowerSearchButtonUiState();
}

class _FollowerSearchButtonUiState extends State<FollowerSearchButtonUi> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, value, child) => CustomTextFeild(
        controller: _searchController,
        sufixfn: () {
          setState(() {
            _searchController.clear();
          });
          ProfileViewModel profileViewModel = context.read<ProfileViewModel>();
          profileViewModel.searchKeyword = '';
          profileViewModel.currentPage = 0;
          profileViewModel.followersController.refresh();
        },
        suffixIcon: const Icon(Icons.close),
        borderColor: PColors.seed2,
        onChanged: (val) {
          ProfileViewModel profileViewModel = context.read<ProfileViewModel>();
          profileViewModel.searchKeyword = val ?? '';
          profileViewModel.currentPage = 0;
          profileViewModel.followersController.refresh();
        },
        borderRadius: 0,
        hintText: "Search here...",
        filColor: PColors.seed,
      ),
    );
  }
}
