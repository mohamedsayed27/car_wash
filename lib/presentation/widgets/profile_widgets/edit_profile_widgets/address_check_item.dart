import 'package:car_wash/business_logic/address_cubit/address_cubit.dart';
import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/core/app_theme/custom_font_weights.dart';
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:car_wash/core/assets_path/svg_path.dart';
import '../../../../presentation/widgets/shared_widgets/custom_outlined_button.dart';
import '../../../../presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';



class AddressCheckButtonWidget extends StatelessWidget {
  final bool isSelected;
  final void Function()? onPressed;
  final String title;
  final String description;
  final String addressId;

  const AddressCheckButtonWidget({
    super.key,
    required this.isSelected,
    this.onPressed,
    required this.title,
    required this.description, required this.addressId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomOutlinedButton(
            borderColor:
                // isSelected ?
                AppColors.primaryColor ,
                    // : AppColors.greyColorB0,
            borderRadius: 6,
            onPressed: onPressed,
            foregroundColor: AppColors.primaryColor,
            backgroundColor:
            // isSelected ?
            AppColors.primaryColor.withOpacity(0.08),
                // :
            // AppColors.whiteColor,
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.5.h),
            child: Row(
              children: [
                SvgPicture.asset(
                  SvgPath.location,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: const ColorFilter.mode(
                    // isSelected ?
                    AppColors.primaryColor ,
                        // : AppColors.greyColorB0,
                    BlendMode.srcIn,
                  ),
                ),
                const CustomSizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                      title,
                      style:
                      // isSelected ?
                      CustomThemes.primaryColorTextTheme(context)
                          .copyWith(
                        fontSize: 14.sp,
                        fontWeight: CustomFontWeights.bold,
                      )
                    // : CustomThemes.greyColorB0TextTheme(context)
                    //     .copyWith(
                    //     fontSize: 14.sp,
                    //     fontWeight: CustomFontWeights.w500,
                    //   ),
                  ),
                )
                // Expanded(
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       ,
                //       const CustomSizedBox(
                //         height: 4,
                //       ),
                //       Text(
                //         description,
                //         style:
                //         // isSelected ?
                //         CustomThemes.primaryColorTextTheme(context)
                //                 .copyWith(
                //                 fontSize: 14.sp,
                //                 fontWeight: CustomFontWeights.w500,
                //               )
                //             // : CustomThemes.greyColorB0TextTheme(context)
                //             //     .copyWith(
                //             //     fontSize: 14.sp,
                //             //     fontWeight: CustomFontWeights.w500,
                //             //   ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
        const CustomSizedBox(
          width: 12,
        ),
        // CustomSizedBox(
        //   height: 20,
        //   width: 20,
        //   child: IconButton(
        //     onPressed: () {
        //
        //     },
        //     icon: SvgPicture.asset(
        //       SvgPath.edit,
        //       width: 20.w,
        //       height: 20.h,
        //       colorFilter: const ColorFilter.mode(
        //         AppColors.primaryColor,
        //         BlendMode.srcIn,
        //       ),
        //     ),
        //     padding: EdgeInsets.zero,
        //   ),
        // ),
        // const CustomSizedBox(
        //   width: 8,
        // ),
        CustomSizedBox(
          height: 20,
          width: 20,
          child: IconButton(
            onPressed: () {
              AddressCubit.get(context).deleteAddress(addressId: addressId);
            },
            icon: SvgPicture.asset(
              SvgPath.trash,
              width: 20.w,
              height: 20.h,
              colorFilter: const ColorFilter.mode(
                AppColors.primaryColor,
                BlendMode.srcIn,
              ),
            ),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }
}
