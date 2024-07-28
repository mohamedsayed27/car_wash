import 'package:car_wash/business_logic/orders_cubit/orders_cubit.dart';
import 'package:car_wash/business_logic/pages_cubit/pages_cubit.dart';
import 'package:car_wash/core/app_theme/custom_themes.dart';
import 'package:car_wash/core/cache_helper/shared_pref_methods.dart';
import 'package:car_wash/presentation/screens/car_services_screen/car_services_screen.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../business_logic/address_cubit/address_cubit.dart';
import '../../../core/app_router/screens_name.dart';
import '../../../core/app_theme/app_colors.dart';
import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/assets_path/images_path.dart';
import '../../../core/assets_path/svg_path.dart';
import '../../../core/constants/constants.dart';
import '../../../data/models/address_model/address_model.dart';
import '../../widgets/choose_car_type_and_location_on_map_widgets/car_type_list.dart';
import '../../widgets/drawers/drawer_button.dart';
import '../../widgets/shared_widgets/address_google_map_widget.dart';
import '../../widgets/shared_widgets/custom_drop_down_button.dart';
import '../../widgets/shared_widgets/custom_elevated_button.dart';
import '../../widgets/shared_widgets/custom_sized_box.dart';
import '../vendor_home_screen/vendor_home_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    AddressCubit.get(context).getCurrentMarker();
    AddressCubit.get(context).getCurrentLocation();
    AddressCubit.get(context).getAddress();
    super.initState();
  }

  List<String> itemsList = [
    "data1",
    "data2",
    "data3",
    "data4",
    "data5",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset(
                ImagesPath.loginLogo,
                width: 96.w,
                height: 94.h,
              ),
            ),
            CustomDrawerButton(
              iconPath: SvgPath.personOutlined,
              title: "حسابى",
              onPressed: () {
                Navigator.pushNamed(context, ScreenName.editProfileScreen);
              },
            ),
            CustomDrawerButton(
              iconPath: SvgPath.messageText,
              title: "الرسائل",
              onPressed: () {
                Navigator.pushNamed(context, ScreenName.allChatsScreen);
              },
            ),
            CustomDrawerButton(
              iconPath: SvgPath.myOrders,
              title: "طلباتى",
              onPressed: () {
                Navigator.pushNamed(context, ScreenName.walletScreen);
              },
            ),
            CustomDrawerButton(
              iconPath: SvgPath.termsAndConditions,
              title: "الشروط والاحكام",
              onPressed: () {
                PagesCubit.get(context).termsAndConditions();
                Navigator.pushNamed(context, ScreenName.pageScreen,arguments: "الشروط والاحكام");
              },
            ),
            CustomDrawerButton(
              iconPath: SvgPath.privacyPolicy,
              title: "سياسة الخصوصيه",
              onPressed: () {
                PagesCubit.get(context).privacyPolicy();
                Navigator.pushNamed(context, ScreenName.pageScreen,arguments: "سياسة الخصوصيه");
              },
            ),
            CustomDrawerButton(
              iconPath: SvgPath.aboutUs,
              title: "عن التطبيق",
              onPressed: () {
                PagesCubit.get(context).aboutUs();
                Navigator.pushNamed(context, ScreenName.pageScreen,arguments: "عن التطبيق");
              },
            ),
            const CustomSizedBox(
              height: 128,
            ),
            CustomDrawerButton(
              iconPath: SvgPath.logout,
              title: "تسجيل الخروج",
              onPressed: () {
                showProgressIndicator(context);
                CacheHelper.clearAllCache().then((value) {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, ScreenName.loginScreen, (route) => false);
                });
              },
            ),
            // Add more items as needed
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          const AddressGoogleMapWidget(),
          PositionedDirectional(
            top: preferredSize.height,
            start: 16,
            end: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomIconButton(
                  assetName: SvgPath.menuDrawer,
                  isNotification: false,
                  onPressed: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),
                const SizedBox(),
                // CustomIconButton(
                //   assetName: SvgPath.notification,
                //   isNotification: true,
                //   onPressed: () {
                //
                //     Navigator.pushNamed(context, ScreenName.notificationScreen);
                //   },
                // ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 32.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -1.h),
                  blurRadius: 16.r,
                  color: AppColors.shadowColor(value: 0.1),
                )
              ],
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16.r),
                topLeft: Radius.circular(16.r),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocConsumer<AddressCubit, AddressState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    var cubit = AddressCubit.get(context);
                    return cubit.getAddressLoading
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: cubit.getAddressesModel!.result != null?CustomDropDownButton<AddressModel>(
                                  items: cubit.getAddressesModel!.result != null
                                      ? cubit.getAddressesModel!.result!
                                          .map(
                                            (e) => DropdownMenuItem(
                                              value: e,
                                              child: Text(e.streetName ?? ""),
                                            ),
                                          )
                                          .toList()
                                      : [],
                                  value: cubit.addressModel,
                                  borderColor: cubit.addressModel == null
                                      ? null
                                      : AppColors.primaryColor,
                                  hintText: "اختر المكان",
                                  onChanged: cubit.chooseSelectedAddress,
                                ):Text(
                                  "لم تقم باضافة عنوان",
                                  textAlign: TextAlign.start,
                                  style:
                                  CustomThemes.greyColor71TextTheme(context).copyWith(
                                    fontSize: 14.sp,
                                    fontWeight: CustomFontWeights.w500,
                                  ),
                                ),
                              ),
                              const CustomSizedBox(
                                width: 16,
                              ),
                              CustomTextButton(
                                title: "اضافة عنوان",
                                onPressed: () {
                                  Navigator.pushNamed(context, ScreenName.addAddressScreen);
                                },
                                style:
                                    CustomThemes.primaryColorTextTheme(context)
                                        .copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primaryColor,
                                ),
                              ),
                            ],
                          );
                  },
                ),
                const CustomSizedBox(
                  height: 18,
                ),
                const CarTypeList(),
                const CustomSizedBox(
                  height: 16,
                ),
                CustomElevatedButton(
                  backgroundColor: AppColors.primaryColor,

                  onPressed: () {
                    if (AddressCubit.get(context).addressModel != null &&
                        OrdersCubit.get(context).carContentImageModel != null) {
                      Navigator.pushNamed(
                        context,
                        ScreenName.carServicesScreen,
                        arguments: CarServicesArgument(
                          addressModel: AddressCubit.get(context).addressModel!,
                          contentImageModel:
                              OrdersCubit.get(context).carContentImageModel,
                        ),
                      );
                    } else {
                      showToast(
                          errorType: 1,
                          message: "من فضلك بأختيار العنوان ونوع السيارة",);
                    }
                  },
                  width: double.infinity,
                  text: "التالي",
                  height: 48,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
