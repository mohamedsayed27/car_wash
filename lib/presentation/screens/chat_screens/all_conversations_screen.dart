import 'package:car_wash/core/cache_helper/cache_keys.dart';
import 'package:car_wash/core/cache_helper/shared_pref_methods.dart';
import 'package:car_wash/presentation/screens/chat_screens/chat_screen.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/cached_network_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/chat_cubit/chat_cubit.dart';
import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';
import '../../../data/models/chat_model/conversation_model.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_divider.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';

class AllChatsScreen extends StatefulWidget {
  const AllChatsScreen({super.key});

  @override
  State<AllChatsScreen> createState() => _AllChatsScreenState();
}

class _AllChatsScreenState extends State<AllChatsScreen> {
  @override
  void initState() {
    ChatCubit.get(context)
        .getAllConversation(type: CacheHelper.getData(key: CacheKeys.userType));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "الرسائل",
        ),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          ChatCubit cubit = ChatCubit.get(context);
          return cubit.getAllConversationsLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : ListView.separated(
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, ScreenName.chatScreen,arguments: ChatArgs(chatId: cubit.conversations[index].id.toString(), orderId: cubit.conversations[index].order.toString(), name: cubit.conversations[index].user.toString()));
                        cubit.getChatMessages(id: cubit.conversations[index].id.toString());
                      },
                      child: ChatItemWidget(
                        conversationItem: cubit.conversations[index],
                      ),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const Column(
                      children: [
                        CustomSizedBox(
                          height: 8,
                        ),
                        CustomDivider(
                          width: 0.5,
                          color: AppColors.greyColorB0,
                        ),
                        CustomSizedBox(
                          height: 8,
                        ),
                      ],
                    );
                  },
                  itemCount: cubit.conversations.length,
                );
        },
      ),
    );
  }
}

class ChatItemWidget extends StatelessWidget {
  final ConversationItem conversationItem;

  const ChatItemWidget({
    super.key,
    required this.conversationItem,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 52.h,
          width: 52.w,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: CachedNetworkImageWidget(
            imagePath: conversationItem.avatar!,
            fit: BoxFit.cover,
          ),
        ),
        const CustomSizedBox(
          width: 12,
        ),
        Expanded(
          child: Ink(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            decoration: BoxDecoration(
              color: const Color(0xffFAFAFA),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conversationItem.user ?? "",
                  style: CustomThemes.primaryColorTextTheme(context).copyWith(
                    fontSize: 16.sp,
                    fontWeight: CustomFontWeights.w500,
                  ),
                ),
                const CustomSizedBox(
                  height: 4,
                ),
                Text(
                  conversationItem.message ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CustomThemes.greyColor71TextTheme(context).copyWith(
                    fontSize: 14.sp,
                    fontWeight: CustomFontWeights.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
