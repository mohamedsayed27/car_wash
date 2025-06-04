// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl_phone_field/intl_phone_field.dart';
//
// import '../../../business_logic/auth_cubit/auth_cubit.dart';
// import '../../../core/app_theme/app_colors.dart';
// import '../../../core/app_theme/custom_font_weights.dart';
// import '../../../core/app_theme/custom_themes.dart';
//
// class PhoneAuthField extends StatefulWidget {
//   final TextEditingController? textEditingController;
//   const PhoneAuthField({super.key, this.textEditingController});
//
//   @override
//   State<PhoneAuthField> createState() => _PhoneAuthFieldState();
// }
//
// class _PhoneAuthFieldState extends State<PhoneAuthField> {
//   final border = OutlineInputBorder(
//     borderSide: BorderSide(
//       color: AppColors.greyColorB0,
//       width: 1.w,
//     ),
//     borderRadius: BorderRadius.circular(8.r),
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return IntlPhoneField(
//       style: CustomThemes.primaryColorTextTheme(context).copyWith(
//         fontWeight: CustomFontWeights.w600,
//         fontSize: 16.sp,
//       ),
//       keyboardType: TextInputType.phone,
//       controller: widget.textEditingController,
//       decoration: InputDecoration(
//         border: border,
//         enabledBorder: border,
//         focusedBorder: border,
//         hintText: "رقم الهاتف",
//
//         hintStyle: CustomThemes.greyColorD9TextTheme(context).copyWith(
//           fontWeight: CustomFontWeights.w500,
//           fontSize: 16.sp,
//         ),
//         contentPadding: EdgeInsets.symmetric(
//           vertical: 12.h
//         ),
//         counter: const SizedBox.shrink(),
//       ),
//       initialCountryCode: "EG",
//       languageCode: "ar",
//
//       validator: (value) async{
//         return "صيغة غير صحيحة";
//       },
//       dropdownIconPosition: IconPosition.trailing,
//       // autovalidateMode: AutovalidateMode.,
//       // pickerDialogStyle: PickerDialogStyle(),
//       textAlign: TextAlign.start,
//       onChanged: (phone) {
//         print(phone.completeNumber);
//       },
//       onCountryChanged: (country) {
//         AuthCubit.get(context).countryDialCode = country.dialCode;
//         print('Country changed to: ' + country.dialCode);
//       },
//     );
//   }
// }
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/reg_exp.dart';

class PhoneAuthField extends StatefulWidget {
  final TextEditingController? textEditingController;

  const PhoneAuthField({super.key, required this.textEditingController});

  @override
  State<PhoneAuthField> createState() => _PhoneAuthFieldState();
}

class _PhoneAuthFieldState extends State<PhoneAuthField> {
  final border = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.greyColorB0,
      width: 1.w,
    ),
    borderRadius: BorderRadius.circular(8.r),
  );

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: TextFormField(
              enabled: false,
              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                fontWeight: CustomFontWeights.w600,
                fontSize: 16.sp,
              ),
              onTapOutside: (pointer) {
                FocusScope.of(context).requestFocus(FocusNode());
              },

              keyboardType: TextInputType.phone,
              validator: (value){
                if(widget.textEditingController!.text.isEmpty){
                  return "";
                }else if(RegularExp.phoneRegExp.hasMatch(widget.textEditingController!.text)){
                  return "";
                }
                return null;
              },
              controller: TextEditingController(),
              decoration: InputDecoration(
                border: border,
                enabledBorder: border,
                disabledBorder: border,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.redColor,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                focusedBorder: border,
                hintText: "966+",
                hintStyle: CustomThemes.greyColorD9TextTheme(context).copyWith(
                  fontWeight: CustomFontWeights.w500,
                  fontSize: 16.sp,
                ),
                counter: const SizedBox.shrink(),
              ),
            ),
          ),
          const CustomSizedBox(width: 16,),
          Expanded(
            flex: 4,
            child: TextFormField(
              style: CustomThemes.primaryColorTextTheme(context).copyWith(
                fontWeight: CustomFontWeights.w600,
                fontSize: 16.sp,
              ),
              onTapOutside: (pointer) {
                FocusScope.of(context).requestFocus(FocusNode());
              },

              keyboardType: TextInputType.phone,
              validator: (value){
                if(widget.textEditingController!.text.isEmpty){
                  return "ادخل رقم الهاتف";
                }else if(RegularExp.phoneRegExp.hasMatch(widget.textEditingController!.text)){
                  return "صيفة الهاتف غير صحيحة";
                }
                return null;

              },
              controller: widget.textEditingController,
              decoration: InputDecoration(
                border: border,
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.redColor,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                enabledBorder: border,
                focusedBorder: border,
                hintText: "رقم الهاتف",
                hintStyle: CustomThemes.greyColorD9TextTheme(context).copyWith(
                  fontWeight: CustomFontWeights.w500,
                  fontSize: 16.sp,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 12.h,horizontal: 16.w,),
                counter: const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
