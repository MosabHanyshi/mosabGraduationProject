import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/address/address_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/cards/cards_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/cart/cart_cubit.dart';
import 'package:mosabhhgraduationproject/businesslogic/cubit/user/user_cubit.dart';
import 'package:mosabhhgraduationproject/data/dataproviders/address_data_provider.dart';
import 'package:mosabhhgraduationproject/data/dataproviders/card_data_provider.dart';
import 'package:mosabhhgraduationproject/data/dataproviders/cart_data_provider.dart';
import 'package:mosabhhgraduationproject/data/dataproviders/user_data_provider.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/address_repo.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/cards_repo.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/cart_repo.dart';
import 'package:mosabhhgraduationproject/data/repositoriy/user_repo.dart';
import 'package:mosabhhgraduationproject/ui/screens/add_address_page.dart';
import 'package:mosabhhgraduationproject/ui/screens/add_card_page.dart';
import 'package:mosabhhgraduationproject/ui/screens/cards_list_page.dart';
import 'package:mosabhhgraduationproject/ui/screens/category_list_page.dart';
import 'package:mosabhhgraduationproject/ui/screens/change_language_page.dart';
import 'package:mosabhhgraduationproject/ui/screens/change_password_page.dart';
import 'package:mosabhhgraduationproject/ui/screens/chat_search.dart';
import 'package:mosabhhgraduationproject/ui/screens/checkout_screen.dart';
import 'package:mosabhhgraduationproject/ui/screens/edit_profile.dart';
import 'package:mosabhhgraduationproject/ui/screens/home_page.dart';
import 'package:mosabhhgraduationproject/ui/screens/intro_page.dart';
import 'package:mosabhhgraduationproject/ui/screens/log_in.dart';
import 'package:mosabhhgraduationproject/ui/screens/profile_page.dart';
import 'package:mosabhhgraduationproject/ui/screens/sign_up.dart';
import 'package:mosabhhgraduationproject/ui/screens/splash_page.dart';
import 'package:mosabhhgraduationproject/ui/widgets/drawer.dart';
import 'app_routes.dart';

class RouteGenerator {
  final _cardCubit = CardsCubit(CardsRepo(CardDataProvider()));
  final _userCubit = UserCubit(UserRepo(UserDataProvider()));
  final _addressCuibit = AddressCubit(AddressRepo(AddressDataProvider()));

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _userCubit,
                  child: LoginPage(),
                ));
      case AppRoutes.register:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _userCubit,
                  child: SignUpPage(),
                ));
      case AppRoutes.intro:
        return MaterialPageRoute(builder: (_) => const IntroPage());
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.categoryList:
        return MaterialPageRoute(builder: (_) => const CategoryListPage());
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case AppRoutes.drawer:
        return MaterialPageRoute(builder: (_) => const MyDrawer());
      case AppRoutes.checkout:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider(
                        create: (BuildContext context) =>
                            CartCubit(CartRepo(CartDataProvider()))),
                    BlocProvider(
                        create: (BuildContext context) =>
                            CardsCubit(CardsRepo(CardDataProvider()))),
                    BlocProvider(
                        create: (BuildContext context) =>
                            AddressCubit(AddressRepo(AddressDataProvider()))),
                  ],
                  child: CheckOutScreen(),
                ));
      case AppRoutes.cardList:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _cardCubit,
                  child: CardListPage(),
                ));
      case AppRoutes.addNewCard:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _cardCubit,
                  child: AddCardsPage(),
                ));
      case AppRoutes.addNewAddress:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _addressCuibit,
                  child: AddAddressPage(),
                ));
      case AppRoutes.profile:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _userCubit,
                  child: ProfilePage(),
                ));
      case AppRoutes.chat:
        return MaterialPageRoute(builder: (_) => HomeScreenChat());
      case AppRoutes.editProfile:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _userCubit,
                  child: EditProfilePage(),
                ));
      case AppRoutes.editProfile:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _userCubit,
                  child: EditProfilePage(),
                ));
      case AppRoutes.changePassword:
        return MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: _userCubit,
                  child: ChangePasswordPage(),
                ));
      case AppRoutes.changeLanguage:
        return MaterialPageRoute(builder: (_) => ChangeLanguagePage());
      default:
        return null;
    }
  }
}
