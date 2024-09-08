// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// final rootNavKey = GlobalKey<NavigatorState>();

// final router = GoRouter(
//     navigatorKey: rootNavKey,
//     // initialLocation: AuthLoginPage.route,
//     redirect: (context, state) {
//       // final isAuthorized = BlocProvider.of<AppCubit>(context).state.jwtAuthCheck;
//       final location = state.uri.toString();
//       if (isAuthorized) {
//         return (location.contains('/auth') || location == '/') ? DashboardScreen.route : null;
//       } else {
//         return (!location.contains('/auth') || location == '/') ? AuthLoginPage.route : null;
//       }
//     },
//     routes: [
//       ShellRoute(
//         builder: (context, state, child) {
//           return AuthShell(
//             route: state.uri.toString(),
//             child: child,
//           );
//         },
//         routes: [
//           GoRoute(
//             path: AuthLoginPage.route,
//             name: AuthLoginPage.route,
//             builder: (context, state) => const AuthLoginPage(),
//           ),
//         ],
//       ),
//       StatefulShellRoute.indexedStack(
//         builder: (context, state, navigationShell) {
//           return HomeShell(
//             child: navigationShell,
//           );
//         },
//         branches: [
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 path: DashboardScreen.route,
//                 name: DashboardScreen.route,
//                 // builder: (context, state) {
//                 //   return const DashboardScreen();
//                 // },
//                 pageBuilder: (context, state) => MaterialPage(child: DashboardScreen()),
//               ),
//             ],
//           ),
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                   path: GroupsPage.route,
//                   name: GroupsPage.route,
//                   builder: (context, state) {
//                     return const GroupsPage();
//                   },
//                   routes: [
//                     GoRoute(
//                         path: Products.route,
//                         name: Products.route,
//                         builder: (context, state) {
//                           return Products(group: state.extra as dynamic );
//                         },
//                         routes: [
//                           GoRoute(
//                             path: ProductsPage.route,
//                             name: ProductsPage.route,
//                             builder: (context, state) {
//                               return ProductsPage(
//                                 product: state.extra as dynamic,
//                                 productId: int.parse(state.pathParameters['id']!),
//                               );
//                             },
//                           )
//                         ])
//                   ])
//             ],
//           ),
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 path: CollectionsPage.route,
//                 name: CollectionsPage.route,
//                 builder: (context, state) {
//                   return const CollectionsPage();
//                 },
//               )
//             ],
//           ),
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 path: OrdersPage.route,
//                 name: OrdersPage.route,
//                 builder: (context, state) {
//                   return const OrdersPage();
//                 },
//               )
//             ],
//           ),
         
//           StatefulShellBranch(
//             routes: [
//               GoRoute(
//                 path: StorePage.route,
//                 name: StorePage.route,
//                 builder: (context, state) {
//                   return const StorePage();
//                 },
//               )
//             ],
//           ),
          
         
//         ],
//       ),
//     ]);
