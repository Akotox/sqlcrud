import 'package:flutter/material.dart';
import 'package:sqlcrud/common/utils/constants.dart';
import 'package:sqlcrud/common/widgets/app_style.dart';
import 'package:sqlcrud/common/widgets/height_spacer.dart';
import 'package:sqlcrud/common/widgets/reusable_text.dart';
import 'package:sqlcrud/common/widgets/width_spacer.dart';

class TodoTile extends StatelessWidget {
  const TodoTile(
      {super.key,
      required this.child,
      this.title,
      this.description,
      this.update,
      this.delete, this.color});
  final Widget child;
  final String? title;
  final String? description;
  final void Function()? update;
  final void Function()? delete;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            width: AppConst.kWidth,
            decoration: const BoxDecoration(
                color: AppConst.kGreyDark,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 5,
                      decoration:  BoxDecoration(
                          color: color ?? AppConst.kRed,
                          borderRadius: const BorderRadius.all(Radius.circular(12))),
                    ),
                    const WidthSpacer(width: 15),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableText(
                              text: title ?? 'Get Medication',
                              style: appstyle(
                                  18, AppConst.kLight, FontWeight.bold)),
                          const HeightSpacer(size: 3),
                          ReusableText(
                              text: description ?? "Visit the hospital",
                              style: appstyle(
                                  12, AppConst.kLight, FontWeight.normal)),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  child: child,
                )
              ],
            ),
          ),
          Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: AppConst.kWidth * 0.3,
                height: 20,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)),
                  color: AppConst.kBackgroundDark,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                        onTap: update,
                        child: ReusableText(
                            text: "Edit",
                            style: appstyle(
                                12, AppConst.kLight, FontWeight.normal))),
                    GestureDetector(
                        onTap: delete,
                        child: ReusableText(
                            text: "Delete",
                            style: appstyle(
                                12, AppConst.kLight, FontWeight.normal)))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
