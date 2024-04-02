import 'package:car_wash/core/app_theme/app_colors.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_outlined_button.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/orders_cubit/orders_cubit.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';

class SelectTimeComponent extends StatefulWidget {
  const SelectTimeComponent({super.key});

  @override
  State<SelectTimeComponent> createState() => _SelectTimeComponentState();
}

class _SelectTimeComponentState extends State<SelectTimeComponent> {
  List<String> timeList({int index = 0}) => [
        "0$index:00",
        "0$index:00",
        "0$index:00",
        "0$index:00",
        "0$index:00",
        "0$index:00",
        "0$index:00",
        "0$index:00",
        "0$index:00",
        "0$index:00",
        "0$index:00",
        "$index:00",
        "$index:00",
        "$index:00",
        "$index:00",
        "$index:00",
        "$index:00",
        "$index:00",
        "$index:00",
        "$index:00",
        "$index:00",
        "$index:00",
        "$index:00",
        "$index:00",
      ];

  int? currentIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "الوقت",
          style: CustomThemes.primaryColorTextTheme(context).copyWith(
            fontSize: 16.sp,
            fontWeight: CustomFontWeights.bold,
          ),
        ).symmetricPadding(horizontal: 16),
        const CustomSizedBox(
          height: 16,
        ),
        BlocConsumer<OrdersCubit, OrdersState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            OrdersCubit cubit = OrdersCubit.get(context);
            return CustomSizedBox(
              height: 40,
              width: double.infinity,
              child: cubit.selectedDateScheduleModel != null
                  ? cubit.selectedDateScheduleModel!.times != null &&
                          cubit.selectedDateScheduleModel!.times!.isNotEmpty
                      ? ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          itemBuilder: (_, index) {
                            return SelectDateButton(
                              time: cubit.selectedDateScheduleModel
                                      ?.times?[index].time ??
                                  "",
                              isSelected: cubit.selectedDateScheduleModel?.times
                                      ?.indexWhere((element) =>
                                          element.id ==
                                          cubit.selectedTimeModel?.id) ==
                                  index,
                              onPressed: () {
                                cubit.changeSelectedTimeScheduleModel(
                                  cubit
                                      .selectedDateScheduleModel?.times?[index],
                                );
                              },
                            );
                          },
                          separatorBuilder: (_, index) {
                            return const CustomSizedBox(
                              width: 8,
                            );
                          },
                          itemCount:
                              cubit.selectedDateScheduleModel?.times?.length ??
                                  0,
                        )
                      : Text(
                          "لم يتم تحديد مواعيد",
                          textAlign: TextAlign.center,
                          style: CustomThemes.greyColor71TextTheme(context)
                              .copyWith(
                            fontSize: 14.sp,
                            fontWeight: CustomFontWeights.w500,
                          ),
                        )
                  : Text(
                      "قم بآختيار التاريخ",
                      textAlign: TextAlign.center,
                      style:
                          CustomThemes.greyColor71TextTheme(context).copyWith(
                        fontSize: 14.sp,
                        fontWeight: CustomFontWeights.w500,
                      ),
                    ),
            );
          },
        ),
      ],
    );
  }
}

class SelectDateButton extends StatelessWidget {
  final String time;
  final bool isSelected;
  final void Function()? onPressed;

  const SelectDateButton({
    super.key,
    required this.time,
    required this.isSelected,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomOutlinedButton(
      borderColor: isSelected ? AppColors.primaryColor : AppColors.greyColorB0,
      onPressed: onPressed,
      foregroundColor: AppColors.primaryColor,
      backgroundColor: isSelected
          ? AppColors.primaryColor.withOpacity(0.08)
          : AppColors.whiteColor,
      borderRadius: 8,
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 7.h,
      ),
      child: Text(
        time,
        style: isSelected
            ? CustomThemes.primaryColorTextTheme(context).copyWith(
                fontSize: 16.sp,
                fontWeight: CustomFontWeights.bold,
              )
            : CustomThemes.greyColorB0TextTheme(context).copyWith(
                fontSize: 16.sp,
                fontWeight: CustomFontWeights.w500,
              ),
      ),
    );
  }
}
