import 'package:flutter/material.dart';
import 'package:sqlcrud/common/utils/constants.dart';
import 'package:sqlcrud/common/widgets/app_style.dart';
import 'package:sqlcrud/common/widgets/reusable_text.dart';
import 'package:sqlcrud/common/widgets/width_spacer.dart';


class BottomTitles extends StatefulWidget {
  const BottomTitles({super.key, this.clr, required this.text});
  final Color? clr;
  final String text;

  @override
  State<BottomTitles> createState() => _BottomTitlesState();
}

class _BottomTitlesState extends State<BottomTitles> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppConst.kWidth,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: 5,
              decoration: BoxDecoration(
                  color: widget.clr ?? AppConst.kLightGrey,
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
            ),
            const WidthSpacer(width: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReusableText(
                  text: widget.text,
                  style: appstyle(24, AppConst.kLight, FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
