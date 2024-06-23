import 'package:car_wash/core/app_theme/custom_font_weights.dart';
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:car_wash/core/cache_helper/cache_keys.dart';
import 'package:car_wash/core/cache_helper/shared_pref_methods.dart';
import 'package:car_wash/core/constants/constants.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/core/parameters/chat_parameters/send_message_parameters.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../business_logic/chat_cubit/chat_cubit.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/assets_path/svg_path.dart';

class ChatTextField extends StatefulWidget {
  final String orderId;
  final String chatId;

  const ChatTextField({super.key, required this.orderId, required this.chatId});

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    InputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(15.r),
      borderSide: BorderSide(
        color: AppColors.greyColorFA,
        width: 0.59.w,
      ),
    );
    return BlocConsumer<ChatCubit, ChatState>(
      listener: (context, state) {
        if (state is SendMessageSuccessStates) {
          controller.clear();
          ChatCubit.get(context).getChatMessages(id: widget.chatId);
        }
      },
      builder: (context, state) {
        ChatCubit cubit = ChatCubit.get(context);
        return Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            SizedBox(
              height: 40.h,
              child: TextField(
                controller: controller,
                style: CustomThemes.greyColor71TextTheme(context).copyWith(
                    fontSize: 12.sp, fontWeight: CustomFontWeights.w600),
                decoration: InputDecoration(
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                  disabledBorder: border,
                  filled: true,
                  fillColor: AppColors.greyColorFA,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 27.w,
                    vertical: 11.h,
                  ),
                  hintText: "ارسال",
                  hintStyle: CustomThemes.greyColorB0TextTheme(context)
                      .copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600),
                ),
              ),
            ).onlyDirectionalPadding(end: 8.w),
            ElevatedButton(
              onPressed: state is SendMessageLoadingStates?null:() {
                cubit.senMessage(
                    sendMessageParameters: SendMessageParameters(
                        type: CacheHelper.getData(key: CacheKeys.userType),
                        message: controller.text,
                        orderId: widget.orderId));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                shape: const CircleBorder(),
                minimumSize: Size(43.w, 43.h),
                elevation: 0,
                padding: EdgeInsets.zero,
                shadowColor: Colors.transparent,
                foregroundColor: AppColors.whiteColor,
              ),
              child:  SvgPicture.asset(
                      SvgPath.send,
                      width: 16.w,
                      height: 17.h,
                    ),
            )
          ],
        );
      },
    );
  }
}
