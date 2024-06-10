import 'package:car_wash/presentation/screens/confirm_order_screen/user_confirm_order_arguments.dart';
import 'package:car_wash/presentation/screens/confirm_order_screen/user_confirm_order_arguments.dart';
import 'package:flutter/material.dart';

import '../../presentation/screens/address_screens/add_address_screen.dart';
import '../../presentation/screens/auth_screens/login_screen.dart';
import '../../presentation/screens/auth_screens/register_type_screen.dart';
import '../../presentation/screens/auth_screens/registration_screen.dart';
import '../../presentation/screens/car_services_screen/car_services_screen.dart';
import '../../presentation/screens/chat_screens/all_conversations_screen.dart';
import '../../presentation/screens/chat_screens/chat_screen.dart';
import '../../presentation/screens/confirm_order_screen/user_confirm_order_screen.dart';
import '../../presentation/screens/confirm_order_screen/vendor_confirm_order.dart';
import '../../presentation/screens/intro_screens/splash_screen.dart';
import '../../presentation/screens/notification_screen/notification_screen.dart';
import '../../presentation/screens/payment_screens/choose_payment_screen.dart';
import '../../presentation/screens/payment_screens/my_cards_screen.dart';
import '../../presentation/screens/plans_screen/plans_screen.dart';
import '../../presentation/screens/profile_screens/about_us.dart';
import '../../presentation/screens/profile_screens/edit_profile_screen.dart';
import '../../presentation/screens/profile_screens/profile_screen.dart';
import '../../presentation/screens/terms_and_conditions/terms_and_conditions.dart';
import '../../presentation/screens/user_home_screen/user_home_screen.dart';
import '../../presentation/screens/user_order_progress_screen/user_order_progress_screen.dart';
import '../../presentation/screens/vendor_home_screen/vendor_home_screen.dart';
import '../../presentation/screens/vendor_orders_screen/in_progress_order.dart';
import '../../presentation/screens/vendor_orders_screen/vendor_orders_screen.dart';
import '../../presentation/screens/vendor_profile_screen/vendor_profile_screen.dart';
import '../../presentation/screens/wallet_screen/wallet_screen.dart';
import 'screens_name.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case ScreenName.splashScreen:
          return MaterialPageRoute(builder: (_)=>const SplashScreen(),);
        case ScreenName.loginScreen:
          return MaterialPageRoute(builder: (_)=>const LoginScreen(),);
        case ScreenName.allChatsScreen:
          return SlideRightRoute(page: const AllChatsScreen(),);
        case ScreenName.carServicesScreen:
          final CarServicesArgument carServicesArgument = settings.arguments as CarServicesArgument;
          return SlideRightRoute(page: CarServicesScreen(carServicesArgument: carServicesArgument,),);
        case ScreenName.chatScreen:
          final ChatArgs chatArgs = settings.arguments as ChatArgs;
          return SlideRightRoute(page: ChatScreen(chatArgs: chatArgs,),);
        case ScreenName.userHomeScreen:
          return SlideRightRoute(page: const UserHomeScreen(),);
        case ScreenName.vendorHomeScreen:
          return SlideRightRoute(page: const VendorHomeScreen(),);
        case ScreenName.notificationScreen:
          return SlideRightRoute(page: const NotificationScreen(),);
        case ScreenName.registerScreen:
          return SlideRightRoute(page:const RegistrationScreen(),);
        case ScreenName.registerTypeScreen:
          return SlideRightRoute(page: const RegisterTypeScreen(),);
        case ScreenName.userConfirmOrderScreen:
          final UserConfirmOrderArguments userConfirmOrderArguments = settings.arguments as UserConfirmOrderArguments;
          return SlideRightRoute(page: UserConfirmOrderScreen(userConfirmOrderArguments: userConfirmOrderArguments,),);
        case ScreenName.userOrderProgressScreen:
          return SlideRightRoute(page: const UserOrderProgressScreen(),);
        case ScreenName.vendorConfirmOrderScreen:
          return SlideRightRoute(page: const VendorConfirmOrderScreen(),);
        case ScreenName.vendorOrdersScreen:
          return SlideRightRoute(page: const VendorOrdersScreen(),);
        case ScreenName.vendorProfileScreen:
          return SlideRightRoute(page: const VendorProfileScreen(),);
        case ScreenName.vendorProgressOrderScreen:
          return SlideRightRoute(page: const VendorInProgressOrderScreen(),);
        case ScreenName.walletScreen:
          return SlideRightRoute(page: const WalletScreen(),);
        case ScreenName.plansScreen:
          return SlideRightRoute(page: const PlansScreen(),);
        case ScreenName.pageScreen:
          final screenTitle = settings.arguments as String;
          return SlideRightRoute(page:  PageScreen(screenTitle:screenTitle,),);
        case ScreenName.aboutUsScreen:
          return SlideRightRoute(page: const AboutUsScreen(),);
        case ScreenName.addAddressScreen:
          return SlideRightRoute(page: const AddAddressScreen(title: 'اضافة عنوان',),);
        case ScreenName.editProfileScreen:
          return SlideRightRoute(page: const EditProfileScreen(),);
        case ScreenName.profileScreen:
          return SlideRightRoute(page: const ProfileScreen(),);
        case ScreenName.choosePaymentScreen:
          return SlideRightRoute(page: const ChoosePaymentScreen(),);
        case ScreenName.myCardsScreen:
          return SlideRightRoute(page: const MyCardsScreen(),);
        default:
          return _errorRoute();
      }
    } catch (e) {
      return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error when routing to this screen'),
        ),
      );
    });
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget page;

  SlideRightRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return page;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 250),
          reverseTransitionDuration: const Duration(milliseconds: 250),
        );
}
