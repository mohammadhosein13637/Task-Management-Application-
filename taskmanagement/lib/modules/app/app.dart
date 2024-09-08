import 'dart:ui';

import 'package:animations/animations.dart';
// import 'package:atlaspump_adminpanel/domains/admin_respository/admin_repository.dart';
// import 'package:atlaspump_adminpanel/domains/app_repository/controllers/menu_App_controller.dart';
// import 'package:atlaspump_adminpanel/domains/user_repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:taskmanagement/domains/user_repository/user_repository.dart';
import 'package:taskmanagement/modules/app/cubit/app_cubit.dart';

import 'package:taskmanagement/uikit/ui_kit.dart' as ui_kit;
import 'package:go_router/go_router.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

class App extends StatelessWidget {
  //
  final UserRepository userRepo;
  // final AdminRepository adminRepo;

  const App({
    super.key,
    required this.userRepo,
    // required this.adminRepo,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(
          value: userRepo,
        ),
        // RepositoryProvider.value(
        //   value: adminRepo,
        // )
      ],
      child: BlocProvider(
        create: (context) => AppCubit(
          userRepo: userRepo,
        ),
        child: OverlaySupport.global(
          child: BlocListener<AppCubit, AppState>(
            listenWhen: (previous, current) =>
                previous.jwtAuthCheck != current.jwtAuthCheck,
            listener: (context, state) {
              // GoRouter.of(rootNavKey.currentContext!).refresh();
            },
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Atlas Pump Admin Panel',
              theme: ThemeData.dark().copyWith(
                // scaffoldBackgroundColor: ui_kit.Theme.background,
                // canvasColor: ui_kit.Theme.secoundary,
                pageTransitionsTheme: const PageTransitionsTheme(
                  builders: {
                    TargetPlatform.windows: FadeThroughPageTransitionsBuilder(),
                    TargetPlatform.android: FadeThroughPageTransitionsBuilder(),
                    TargetPlatform.iOS: FadeThroughPageTransitionsBuilder(),
                    TargetPlatform.macOS: FadeThroughPageTransitionsBuilder(),
                    TargetPlatform.linux: FadeThroughPageTransitionsBuilder(),
                  },
                ),
              ),
              scrollBehavior: const MaterialScrollBehavior().copyWith(
                physics: const BouncingScrollPhysics(),
                dragDevices: {
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.unknown,
                },
              ),
              builder: (context, child) {
                var width = MediaQuery.of(context).size.width;
                late double temp;
                switch (width) {
                  case <= 480:
                    temp = width;
                    break;
                  case > 480 && <= 720:
                    temp = width * 0.95;
                    break;
                  case > 720:
                    temp = width * 0.90;
                    break;
                  default:
                }
                return ResponsiveScaledBox(width: temp, child: child!);
              },
              localizationsDelegates: const [
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('fa', 'IR'),
                Locale('en', 'US'),
              ],
              locale: const Locale('fa', 'IR'),
              // routerConfig: router,
              
              // home: MultiProvider(
              //   providers: [
              //     ChangeNotifierProvider(
              //       create: (context) => MenuAppController(),
              //     ),
              //   ],
              //   child: MainPage(),
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
