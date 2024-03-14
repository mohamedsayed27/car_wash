
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/assets_path/images_path.dart';
import '../shared_widgets/custom_sized_box.dart';

class MessageItemWidget extends StatelessWidget {
  final bool isMyMessage;

  const MessageItemWidget({super.key, required this.isMyMessage});

  @override
  Widget build(BuildContext context) {
    return isMyMessage
        ? Row(
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
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: AppColors.primaryColor
                  ),
                  child: Text(
                    "لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها ا إلى  " ,
                    style: CustomThemes.whiteColoTextTheme(context)
                        .copyWith(fontSize: 16.sp, height: 1.2.h),
                  ),
                ),
              )
            ],
          ).onlyDirectionalPadding(end: 16)
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: AppColors.greyColorFA,
                  ),
                  child: Text(
                    "لقد تم توليد هى، حيث يمكننصوص الأخرى إض] تحتاج إلى عدد أكبر من الفقرات ",
                    style: CustomThemes.primaryColorTextTheme(context)
                        .copyWith(fontSize: 16.sp, height: 1.2.h),
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
          ).onlyDirectionalPadding(start: 16);
  }
}
