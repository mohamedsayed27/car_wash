import 'package:car_wash/bloc_observer.dart';
import 'package:car_wash/business_logic/address_cubit/address_cubit.dart';
import 'package:car_wash/business_logic/auth_cubit/auth_cubit.dart';
import 'package:car_wash/business_logic/chat_cubit/chat_cubit.dart';
import 'package:car_wash/business_logic/pages_cubit/pages_cubit.dart';
import 'package:car_wash/core/app_router/app_router.dart';
import 'package:car_wash/core/app_router/screens_name.dart';
import 'package:car_wash/core/cache_helper/shared_pref_methods.dart';
import 'package:car_wash/core/network/dio_helper.dart';
import 'package:car_wash/core/services/services_locator.dart';
import 'package:car_wash/presentation/screens/vendor_orders_screen/vendor_orders_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'business_logic/orders_cubit/orders_cubit.dart';
import 'business_logic/plans_cubit/plans_cubit.dart';
import 'business_logic/representative_cubit/representative_cubit.dart';
import 'core/app_theme/app_theme.dart';
import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  CacheHelper.init();
  ServicesLocators().init();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) => AuthCubit(),
            ),
            BlocProvider(
              create: (_) => AddressCubit(),
            ),
            BlocProvider(
              create: (_) => RepresentativeCubit(),
            ),
            BlocProvider(
              create: (_) => OrdersCubit()..getTimeSchedule(),
            ),
            BlocProvider(
              create: (_) => PlansCubit(),
            ),
            BlocProvider(
              create: (_) => ChatCubit(),
            ),
            BlocProvider(
              create: (_) => PagesCubit(),
            ),
          ],
          child: MaterialApp(
            title: 'Car Wash',
            navigatorKey: navigatorKey,
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
            // home: AllOrdersScreen(),
            initialRoute: ScreenName.splashScreen,
            onGenerateRoute: AppRouter.generateRoute,
          ),
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
