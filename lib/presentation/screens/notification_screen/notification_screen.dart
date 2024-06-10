import 'package:car_wash/core/app_router/screens_name.dart';
import 'package:car_wash/core/constants/extensions.dart';
import 'package:car_wash/data/models/notification_model/notification_model.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_app_bar.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../business_logic/auth_cubit/auth_cubit.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../core/constants/constants.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child: const CustomAppBar(
          title: "الاشعارات",
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          AuthCubit cubit = AuthCubit.get(context);
          return cubit.getNotificationsLoading
              ? Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Column(
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Text(
                        "يوجد ${cubit.notifications.length} اشعارات",
                        style:
                            CustomThemes.greyColor71TextTheme(context).copyWith(
                          fontSize: 16.sp,
                          fontWeight: CustomFontWeights.w600,
                        ),
                      ),
                    ),
                    const CustomSizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (_, index) {

                          return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context,
                                    ScreenName.vendorConfirmOrderScreen);
                              },
                              child: NotificationWidget(notificationItem: cubit.notifications[index],));
                        },
                        separatorBuilder: (_, index) {
                          return const CustomSizedBox(
                            height: 16,
                          );
                        },
                        itemCount: cubit.notifications.length,
                      ),
                    ),
                  ],
                );
        },
      ).symmetricPadding(
        horizontal: 16,
      ),
    );
  }
}

class NotificationWidget extends StatefulWidget {
  final NotificationItem notificationItem;
  const NotificationWidget({super.key, required this.notificationItem});

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {

   DateTime? parseDateTime(String dateString) {
    try {
      DateFormat format = DateFormat('EEEE h:mm a dd MMM');
      return format.parse(dateString);
    } catch (e) {
      print('Error parsing date: $e');
      return null;
    }
  }

   Map<String, dynamic> splitDateComponents(String dateString) {
    DateTime? dateTime = parseDateTime(dateString);
    if (dateTime != null) {
      String day = DateFormat('EEEE').format(dateTime); // Day of the week
      String hour = DateFormat('h:mm a').format(dateTime); // Time
      String month = DateFormat('MMM').format(dateTime); // Month
      int date = dateTime.day; // Day of the month

      return {
        'day': day,
        'hour': hour,
        'month': month,
        'date': date,
      };
    } else {
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(bottom: 15.h),
      title: Text(
        widget.notificationItem.notificationTitle??"",
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: CustomThemes.primaryColorTextTheme(context).copyWith(
          fontSize: 18.sp,
          fontWeight: CustomFontWeights.w500,
        ),
      ),
      // title: ,
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            splitDateComponents(widget.notificationItem.sendAt.toString())["day"],
            style: CustomThemes.greyColor71TextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.w500,
            ),
          ),
          const CustomSizedBox(
            height: 4,
          ),
          Text(
            splitDateComponents(widget.notificationItem.sendAt.toString())["hour"],
            style: CustomThemes.primaryColorTextTheme(context).copyWith(
              fontSize: 16.sp,
              fontWeight: CustomFontWeights.w500,
            ),
          ),
          const CustomSizedBox(
            height: 4,
          ),
          Text(
            "${splitDateComponents(widget.notificationItem.sendAt.toString())["month"]} ${splitDateComponents(widget.notificationItem.sendAt.toString())["date"]}",
            style: CustomThemes.greyColor71TextTheme(context).copyWith(
              fontSize: 14.sp,
              fontWeight: CustomFontWeights.w500,
            ),
          ),
        ],
      ),
      shape: UnderlineInputBorder(
          borderSide: BorderSide(
        color: const Color(0xffEFEFEF),
        width: 1.w,
      )),
    );
  }
}
