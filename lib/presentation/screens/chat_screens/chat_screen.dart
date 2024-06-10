import 'package:car_wash/core/cache_helper/cache_keys.dart';
import 'package:car_wash/core/cache_helper/shared_pref_methods.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/core/enums/user_type_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/chat_cubit/chat_cubit.dart';
import '../../../core/constants/constants.dart';
import '../../widgets/chat/chat_text_field.dart';
import '../../widgets/chat/message_item_widget.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_divider.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';

class ChatArgs extends Equatable {
  final String chatId;
  final String orderId;
  final String name;

  ChatArgs({required this.chatId, required this.orderId, required this.name,});

  @override
  // TODO: implement props
  List<Object?> get props => [
        chatId,
        orderId,
      ];
}

class ChatScreen extends StatelessWidget {
  final ChatArgs chatArgs;

  const ChatScreen({super.key, required this.chatArgs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child:  CustomAppBar(
          title: chatArgs.name,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomDivider(),
            const CustomSizedBox(
              height: 15,
            ),
            Expanded(
              child: BlocConsumer<ChatCubit, ChatState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  ChatCubit cubit = ChatCubit.get(context);
                  return ListView.builder(
                    reverse: true,
                    itemCount: cubit.chats.length,
                    itemBuilder: (BuildContext context, int index) {
                      return MessageItemWidget(
                        isMyMessage: CacheHelper.getData(
                                        key: CacheKeys.userType) ==
                                    UserTypeEnum.client.name &&
                                cubit.chats[index].clientId!.isNotEmpty
                            ? true
                            : CacheHelper.getData(key: CacheKeys.userType) ==
                                        UserTypeEnum.representative.name &&
                                    cubit.chats[index].representativeId!
                                        .isNotEmpty
                                ? true
                                : false,
                        message: cubit.chats[index].message ?? "",
                      ).onlyDirectionalPadding(bottom: 15);
                    },
                  );
                },
              ),
            ),
             ChatTextField(
              orderId: chatArgs.orderId, chatId: chatArgs.chatId,
            ),
          ],
        ).symmetricPadding(horizontal: 24, vertical: 13),
      ),
    );
  }
}
