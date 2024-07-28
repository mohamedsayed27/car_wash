import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../presentation/widgets/shared_widgets/cached_network_image_widget.dart';
import '../../../presentation/widgets/shared_widgets/custom_app_bar.dart';
import '../../../presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../business_logic/pages_cubit/pages_cubit.dart';
import '../../../core/constants/constants.dart';

class PageScreen extends StatelessWidget {
  final String screenTitle;
  const PageScreen({super.key, required this.screenTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: preferredSize,
        child:  CustomAppBar(
          title: screenTitle,
        ),
      ),
      body: BlocConsumer<PagesCubit, PagesState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          PagesCubit cubit = PagesCubit.get(context);
          return cubit.getPageLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : cubit.basePagesModel!=null?ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 32.h,
                  ),
                  children: [
                    CachedNetworkImageWidget(
                      imagePath: cubit.basePagesModel!.image!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                    const CustomSizedBox(height: 24,),
                    Text(
                      "${cubit.basePagesModel!.content}",
                      style: CustomThemes.primaryColorTextTheme(context)
                          .copyWith(
                              fontSize: 16.sp,
                              fontWeight: CustomFontWeights.w400,
                              height: 1.5.h),
                    ),
                  ],
                ):const SizedBox.shrink();
        },
      ),
    );
  }
}
