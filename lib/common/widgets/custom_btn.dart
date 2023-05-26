import 'package:flutter/material.dart';
import 'package:sqlcrud/common/utils/constants.dart';
import 'package:sqlcrud/common/widgets/app_style.dart';
import 'package:sqlcrud/common/widgets/reusable_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.text, this.color,
  });

  final void Function()? onTap;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: AppConst.kRed,
        width: AppConst.kWidth,
        height: AppConst.kHieght * 0.065,
        child: Center(
          child: ReusableText(
              text: text,
              style: appstyle(16, color ?? AppConst.kLight, FontWeight.w600)),
        ),
      ),
    );
  }
}
