
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/assets_path/images_path.dart';
import '../shared_widgets/custom_sized_box.dart';

class MessageItemWidget extends StatelessWidget {
  final bool isMyMessage;
  final String message;
  const MessageItemWidget({super.key, required this.isMyMessage, required this.message});

  @override
  Widget build(BuildContext context) {
    return isMyMessage
        ? Align(
            alignment: AlignmentDirectional.centerStart,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 32.h,
                  width: 32.w,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    ImagesPath.dummyPersonImage,
                    fit: BoxFit.cover,
                  ),
                ),
                const CustomSizedBox(
                  width: 13,
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width *
                          0.7, // Adjust the max width as needed
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: AppColors.primaryColor),
                    child: Text(
                      message,
                      style: CustomThemes.whiteColoTextTheme(context).copyWith(
                        fontSize: 16.sp,
                        height: 1.7.h,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        : Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width *
                          0.7, // Adjust the max width as needed
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: AppColors.greyColorFA,
                    ),
                    child: Text(
                      message,
                      style:
                          CustomThemes.primaryColorTextTheme(context).copyWith(
                        fontSize: 16.sp,
                        height: 1.7.h,
                      ),
                    ),
                  ),
                ),
                const CustomSizedBox(
                  width: 13,
                ),
                Container(
                  height: 32.h,
                  width: 32.w,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    ImagesPath.dummyPersonImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
  }
}
