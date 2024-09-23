import 'package:jora_customer/Settings/until/PColors.dart';
import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PText_styles.dart';

class CustomElavatedTextButton extends StatelessWidget {
  const CustomElavatedTextButton({
    super.key,
    this.onPressed,
    required this.text,
    this.width,
    this.height,
    this.padverticle,
    this.padhorizondal,
    this.fontSize,
    this.bgcolor,
  });

  final void Function()? onPressed;
  final String text;
  final double? width;
  final double? height;
  final double? fontSize;
  final double? padverticle;
  final double? padhorizondal;
  final Color? bgcolor;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgcolor ?? PColors.seed,
        foregroundColor: PColors.white,
        padding: EdgeInsets.symmetric(
            vertical: padverticle ?? 8, horizontal: padhorizondal ?? 16),
        fixedSize: Size(width ?? size.width - 40, height ?? 56),
        maximumSize: Size(width ?? size.width - 40, height ?? 56),
        minimumSize: Size(width ?? size.width - 40, height ?? 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(48),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: PTextStyles.titleMedium.copyWith(
          fontSize: fontSize ?? 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
