import 'package:flutter/material.dart';

import '../../../core/app_theme/app_colors.dart';
import 'custom_sized_box.dart';

class CustomTextButton extends StatelessWidget {
  final String? title;
  final void Function()? onPressed;
  final double? height;
  final double? width;
  final TextStyle? style;
  final Widget? child;
  const CustomTextButton({
    super.key,
    this.title,
    this.onPressed,
    this.style, this.child, this.height, this.width,
  });

  @override
  Widget build(BuildContext context) {
    return CustomSizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          foregroundColor: AppColors.primaryColor,
        ),
        child: child??Text(
          title??"",
          style: style,
        ),
      ),
    );
  }
}
