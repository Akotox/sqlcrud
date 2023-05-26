import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:sqlcrud/common/utils/constants.dart';
import 'package:sqlcrud/common/widgets/bottom_titles.dart';


class XpansionTile extends StatelessWidget {
  const XpansionTile({
    super.key,
    required this.children, required this.text,
  });

  final List<Widget> children;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppConst.kBackgroundDark,
        borderRadius:  BorderRadius.all(Radius.circular(12)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title:  BottomTitles(text: text),
          tilePadding: EdgeInsets.zero,
          onExpansionChanged: (bool expanded) {},
          controlAffinity: ListTileControlAffinity.trailing,
          trailing: Padding(
            padding: EdgeInsets.only(right: 12.0.w),
            child: const Icon(AntDesign.circledown),
          ),
          children: children,
        ),
      ),
    );
  }
}
