import 'package:apo/core/di/dependency_injection.dart';
import 'package:apo/core/routing/route_names.dart';
import 'package:apo/features/authentication/presentation/cubits/login_cubit.dart';
import 'package:apo/features/authentication/presentation/views/login_view.dart';
import 'package:apo/features/checkout/checkout_type.dart';
import 'package:apo/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:apo/features/checkout/presentation/views/checkout_view.dart';
import 'package:apo/features/dashboard/views/dashboard_view.dart';
import 'package:apo/features/dashboard/widgets/bottom_nav_cubit.dart';
import 'package:apo/features/home/presentation/cubits/product_details_cubit.dart';
import 'package:apo/features/home/presentation/cubits/products_cubit.dart';
import 'package:apo/features/home/presentation/views/cart_view.dart';
import 'package:apo/features/home/presentation/views/home_view.dart';
import 'package:apo/features/home/presentation/views/orders_view.dart';
import 'package:apo/features/home/presentation/views/product_view.dart';
import 'package:apo/features/home/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

StatefulNavigationShell? navigationShell;

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: RouteNames.home.path,
  routes: [..._authenticationRoutes, ..._bottomNavRoutes, ..._appRoutes],
);

final _authenticationRoutes = [
  // GoRoute(
  //   path: RouteNames.forgotPasswordCode.path,
  //   name: RouteNames.forgotPasswordCode.name,
  //   pageBuilder: (context, state) => platformPageBuilder(
  //     context: context,
  //     state: state,
  //     child: BlocProvider(
  //       create: (context) => ForgotPasswordCodeCubit(context.read()),
  //       child: ForgotPasswordCodeView(email: state.extra as String),
  //     ),
  //   ),
  // ),
  GoRoute(
    path: RouteNames.login.path,
    name: RouteNames.login.name,
    builder: (context, state) {
      final enableBackButton = state.extra is bool
          ? state.extra as bool
          : false;
      return BlocProvider(
        create: (context) => getIt<LoginCubit>(),
        child: LoginView(enableBackButton: enableBackButton),
      );
    },
  ),
  // GoRoute(
  //   path: RouteNames.codeVerification.path,
  //   name: RouteNames.codeVerification.name,
  //   builder: (context, state) {
  //     final extra = state.extra;
  //     final args = extra is CodeVerificationArgs
  //         ? extra
  //         : CodeVerificationArgs(phoneNumber: extra is String ? extra : '');
  //     return BlocProvider(
  //       create: (context) => getIt<CodeVerificationCubit>(param1: args),
  //       child: CodeVerificationView(),
  //     );
  //   },
  // ),
  // GoRoute(
  //   path: RouteNames.completeInfo.path,
  //   name: RouteNames.completeInfo.name,
  //   builder: (context, state) {
  //     final phoneNumber = state.extra as String;
  //     return BlocProvider(
  //       create: (context) => getIt<CompleteInfoCubit>(param1: phoneNumber),
  //       child: CompleteInfoView(),
  //     );
  //   },
  // ),
];

final _bottomNavRoutes = [
  StatefulShellRoute.indexedStack(
    parentNavigatorKey: navigatorKey,
    builder: (context, state, shell) => BlocProvider(
      create: (context) => getIt<BottomNavCubit>(),
      child: DashboardView(navigationShell: shell),
    ),
    branches: [
      StatefulShellBranch(
        initialLocation: RouteNames.home.path,
        routes: [
          GoRoute(
            name: RouteNames.home.name,
            path: RouteNames.home.path,
            builder: (context, state) => BlocProvider(
              create: (context) => getIt<ProductsCubit>(),
              child: HomeView(),
            ),
          ),
        ],
      ),
      StatefulShellBranch(
        initialLocation: RouteNames.cart.path,
        routes: [
          GoRoute(
            path: RouteNames.cart.path,
            name: RouteNames.cart.name,
            builder: (context, state) => CartView(),
          ),
        ],
      ),
      StatefulShellBranch(
        initialLocation: RouteNames.orders.path,
        routes: [
          GoRoute(
            name: RouteNames.orders.name,
            path: RouteNames.orders.path,
            builder: (context, state) => OrdersView(),
          ),
        ],
      ),
      StatefulShellBranch(
        initialLocation: RouteNames.profile.path,
        routes: [
          GoRoute(
            name: RouteNames.profile.name,
            path: RouteNames.profile.path,
            builder: (context, state) => ProfileView(),
          ),
        ],
      ),
    ],
  ),
];

final _appRoutes = [
  GoRoute(
    path: RouteNames.checkout.path,
    name: RouteNames.checkout.name,
    builder: (context, state) {
      final type = state.extra is CheckoutType
          ? state.extra as CheckoutType
          : CheckoutType.requestQuote;
      return BlocProvider(
        create: (_) => getIt<CheckoutCubit>(param1: type),
        child: CheckoutView(),
      );
    },
  ),
  GoRoute(
    path: RouteNames.product.path,
    name: RouteNames.product.name,
    builder: (context, state) {
      final idParam = state.pathParameters['id'] ?? '0';
      final productId = int.tryParse(idParam) ?? 0;
      return BlocProvider(
        create: (context) => getIt<ProductDetailsCubit>(param1: productId),
        child: ProductView(),
      );
    },
  ),
];
