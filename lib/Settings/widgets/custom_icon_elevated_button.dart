import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:jora_customer/Settings/until/PText_styles.dart';

class CustomIconElevatedButton extends StatelessWidget {
  const CustomIconElevatedButton({
    super.key,
    this.onPressed,
    required this.text,
    required this.svgIcon,
    this.width,
  });

  final void Function()? onPressed;
  final String text;
  final String svgIcon;
  final double? width;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: PColors.seed,
        foregroundColor: PColors.white,
        fixedSize: Size(width ?? size.width - 32, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
      ),
      onPressed: onPressed,
      icon: SvgPicture.asset(svgIcon),
      label: Text(
        text,
        textAlign: TextAlign.center,
        style: PTextStyles.titleMedium,
      ),
    );
  }
}
