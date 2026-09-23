import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/widgets/custom_text_feild.dart';
import 'package:jora_customer/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfileExperienceEditor extends StatelessWidget {
  const ProfileExperienceEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, profileViewModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Experience',
              style: TextStyle(
                color: Color(0xFF8A4FFF),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 10),
            _field(
              controller: profileViewModel.experienceTitleController,
              label: 'Job title',
              hint: 'Lead Content Creator',
            ),
            const SizedBox(height: 10),
            _field(
              controller: profileViewModel.experienceCompanyController,
              label: 'Company',
              hint: 'Company name',
            ),
            const SizedBox(height: 10),
            _field(
              controller: profileViewModel.experienceDurationController,
              label: 'Duration',
              hint: 'Mar 2022 - Present',
            ),
            const SizedBox(height: 10),
            _field(
              controller: profileViewModel.experienceDescriptionController,
              label: 'Description',
              hint: 'Describe your experience',
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: profileViewModel.addExperience,
                icon: const Icon(Icons.add),
                label: const Text('Add experience'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF8A4FFF),
                  side: const BorderSide(color: Color(0xFF8A4FFF)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            ...profileViewModel.experiences.asMap().entries.map(
                  (entry) => Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    color: PColors.white,
                    child: ListTile(
                      title: Text(entry.value.title),
                      subtitle: Text(
                        '${entry.value.company} • ${entry.value.duration}',
                      ),
                      trailing: IconButton(
                        tooltip: 'Remove experience',
                        icon: const Icon(Icons.delete_outline),
                        color: const Color(0xFF8A4FFF),
                        onPressed: () =>
                            profileViewModel.removeExperience(entry.key),
                      ),
                    ),
                  ),
                ),
          ],
        );
      },
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return CustomTextFeild(
      controller: controller,
      borderColor: const Color(0xFF8A4FFF),
      borderRadius: 0,
      filColor: PColors.white,
      textHead: label,
      textColor: const Color(0xFF8A4FFF),
      hintText: hint,
    );
  }
}
