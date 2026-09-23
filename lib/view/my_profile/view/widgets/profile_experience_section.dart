import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:jora_customer/model/experience_model.dart';

class ProfileExperienceSection extends StatelessWidget {
  final bool showContactActions;
  final String phoneNumber;
  final String whatsappNumber;
  final String whatsappLink;
  final String directCallLink;
  final String instagramUrl;
  final String linkedinUrl;
  final List<ExperienceModel>? experiences;

  const ProfileExperienceSection({
    super.key,
    this.showContactActions = true,
    this.phoneNumber = '+919999999999',
    this.whatsappNumber = '919999999999',
    this.whatsappLink = '',
    this.directCallLink = '',
    this.instagramUrl = 'https://www.instagram.com/your_username',
    this.linkedinUrl = 'https://www.linkedin.com/in/your-profile',
    this.experiences,
  });

  // ============================================================
  // ACTIONS
  // ============================================================

  Future<void> _call() async {
    final Uri url = Uri.parse(
      directCallLink.trim().isNotEmpty ? directCallLink : 'tel:$phoneNumber',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  Future<void> _whatsapp() async {
    final String number = whatsappNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final Uri url = Uri.parse(
      whatsappLink.trim().isNotEmpty ? whatsappLink : 'https://wa.me/$number',
    );

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Future<void> _instagram() async {
    final Uri url = Uri.parse(instagramUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Future<void> _linkedin() async {
    final Uri url = Uri.parse(linkedinUrl);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ======================================================
        // MY EXPERIENCE
        // ======================================================

        Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.fromLTRB(
            18,
            18,
            18,
            20,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFF4EDFF),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xFFE0CCFF),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.work_outline_rounded,
                    color: Color(0xFF8A4FFF),
                    size: 28,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'My Experience',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF25104D),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ...(experiences?.isNotEmpty == true
                  ? experiences!
                      .asMap()
                      .entries
                      .map(
                        (entry) => _ExperienceItem(
                          title: entry.value.title,
                          company: entry.value.company,
                          duration: entry.value.duration,
                          description: entry.value.description,
                          isCurrent: entry.value.isCurrent,
                          isLast: entry.key == experiences!.length - 1,
                        ),
                      )
                      .toList()
                  : const [
                      _ExperienceItem(
                        title: 'Lead Content Creator',
                        company: 'XYZ Agency, Mumbai',
                        duration: 'Mar 2022 - Present',
                        description:
                            'Managed videography and editing for major client campaigns.',
                        isCurrent: true,
                        isLast: false,
                      ),
                      _ExperienceItem(
                        title: 'Freelance Videographer',
                        company: 'Global Brands',
                        duration: 'Jan 2020 - Feb 2022',
                        description:
                            'Specialized in event coverage and social media video content.',
                        isCurrent: false,
                        isLast: true,
                      ),
                    ]),
            ],
          ),
        ),

        if (showContactActions) ...[
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 18,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFFF4EDFF),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: const Color(0xFFE0CCFF),
              ),
            ),
            child: Row(
              children: [
                _ContactButton(
                  icon: FontAwesomeIcons.phone,
                  label: 'Call',
                  onTap: _call,
                ),
                _ContactButton(
                  icon: FontAwesomeIcons.whatsapp,
                  label: 'WhatsApp',
                  onTap: _whatsapp,
                ),
                _ContactButton(
                  icon: FontAwesomeIcons.instagram,
                  label: 'Instagram',
                  onTap: _instagram,
                ),
                _ContactButton(
                  icon: FontAwesomeIcons.linkedinIn,
                  label: 'LinkedIn',
                  onTap: _linkedin,
                ),
              ],
            ),
          ),
        ],

        const SizedBox(height: 20),
      ],
    );
  }
}

// ============================================================
// EXPERIENCE ITEM
// ============================================================

class _ExperienceItem extends StatelessWidget {
  final String title;
  final String company;
  final String duration;
  final String description;
  final bool isCurrent;
  final bool isLast;

  const _ExperienceItem({
    required this.title,
    required this.company,
    required this.duration,
    required this.description,
    required this.isCurrent,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline
        SizedBox(
          width: 24,
          child: Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF8A4FFF),
                ),
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 105,
                  color: const Color(0xFFD1B8FF),
                ),
            ],
          ),
        ),

        const SizedBox(width: 10),

        // Details
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF29105A),
                        ),
                      ),
                    ),
                    if (isCurrent)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE4D2FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Current',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF8A4FFF),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  company,
                  style: const TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF69558A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  duration,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF806CA3),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.35,
                    color: Color(0xFF5C4C73),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ============================================================
// CONTACT BUTTON
// ============================================================

class _ContactButton extends StatelessWidget {
  final FaIconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 4,
          ),
          child: Column(
            children: [
              Container(
                width: 54,
                height: 54,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFE9DCFF),
                ),
                child: Center(
                  child: FaIcon(
                    icon,
                    color: const Color(0xFF8A4FFF),
                    size: 25,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6E4C99),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
