import 'package:car_wash/core/app_router/app_router.dart';
import 'package:car_wash/core/app_router/screens_name.dart';
import 'package:car_wash/core/services/services_locator.dart';
import 'package:car_wash/presentation/screens/auth_screens/login_screen.dart';
import 'package:car_wash/presentation/screens/auth_screens/register_type_screen.dart';
import 'package:car_wash/presentation/screens/auth_screens/registration_screen.dart';
import 'package:car_wash/presentation/screens/car_services_screen/car_services_screen.dart';
import 'package:car_wash/presentation/screens/chat_screens/chat_screen.dart';
import 'package:car_wash/presentation/screens/confirm_order_screen/user_confirm_order_screen.dart';
import 'package:car_wash/presentation/screens/intro_screens/splash_screen.dart';
import 'package:car_wash/presentation/screens/notification_screen/notification_screen.dart';
import 'package:car_wash/presentation/screens/payment_screens/choose_payment_screen.dart';
import 'package:car_wash/presentation/screens/payment_screens/my_cards_screen.dart';
import 'package:car_wash/presentation/screens/profile_screens/about_us.dart';
import 'package:car_wash/presentation/screens/profile_screens/profile_screen.dart';
import 'package:car_wash/presentation/screens/terms_and_conditions/terms_and_conditions.dart';
import 'package:car_wash/presentation/screens/user_home_screen/user_home_screen.dart';
import 'package:car_wash/presentation/screens/vendor_home_screen/vendor_home_screen.dart';
import 'package:car_wash/presentation/screens/vendor_orders_screen/vendor_orders_screen.dart';
import 'package:car_wash/presentation/screens/vendor_profile_screen/vendor_profile_screen.dart';
import 'package:car_wash/presentation/screens/wallet_screen/wallet_screen.dart';
import 'package:car_wash/presentation/widgets/car_services_widgets/car_type_services_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'core/app_theme/app_theme.dart';
import 'core/constants/constants.dart';
import 'presentation/screens/chat_screens/all_chats_screen.dart';
import 'presentation/screens/vendor_orders_screen/in_progress_order.dart';

void main() async {
  ServicesLocators().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    print(preferredSize);
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme,
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale(
              "ar",
            ),
          ],
          locale: const Locale(
            "ar",
          ),
          // home: UserHomeScreen(),
          initialRoute: ScreenName.splashScreen,
          onGenerateRoute: AppRouter.generateRoute,
        );
      },
    );
  }
}

class ItemWidget extends StatelessWidget {
  final String assetPath;

  const ItemWidget({super.key, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        assetPath,
      ),
    );
  }
}
