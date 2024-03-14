import 'package:car_wash/core/constants/extensions.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';
import '../../widgets/chat/chat_text_field.dart';
import '../../widgets/chat/message_item_widget.dart';
import '../../widgets/shared_widgets/custom_app_bar.dart';
import '../../widgets/shared_widgets/custom_divider.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "احمد خالد",
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
              child: ListView.builder(
                reverse: true,
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return MessageItemWidget(
                    isMyMessage: index % 2 == 0 ? true : false,
                  ).onlyDirectionalPadding(bottom: 15);
                },
              ),
            ),
            const ChatTextField(),
          ],
        ).symmetricPadding(horizontal: 24, vertical: 13),
      ),
    );
  }
}
