import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app_ui/presentation/providers/profile_tab_provider.dart';
import 'package:social_media_app_ui/presentation/providers/welcome_provider.dart';
import 'package:social_media_app_ui/presentation/screens/explore_screen.dart';
import 'package:social_media_app_ui/presentation/screens/favorites_screen.dart';
import 'package:social_media_app_ui/presentation/screens/home_screen.dart';
import 'package:social_media_app_ui/presentation/screens/main_shell.dart';
import 'package:social_media_app_ui/presentation/screens/profile_screen.dart';
import 'package:social_media_app_ui/presentation/screens/welcome_screen.dart';

GoRouter router = GoRouter(
  initialLocation: NamedRoutes.home.routeName,
  routes: [
    GoRoute(
      path: NamedRoutes.welcome.routeName,
      builder: (ctx, state) => ChangeNotifierProvider(create: (_) => WelcomeProvider(), child: const WelcomeScreen(),),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) => MainShell(navigationShell: navigationShell),
      branches: [
        StatefulShellBranch(routes: [GoRoute(path: NamedRoutes.home.routeName, builder: (ctx, state) => const HomeScreen())]),
        StatefulShellBranch(routes: [GoRoute(path: NamedRoutes.explore.routeName, builder: (ctx, state) => const ExploreScreen())]),
        StatefulShellBranch(routes: [GoRoute(path: NamedRoutes.favorites.routeName, builder: (ctx, state) => const FavoritesScreen())]),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: NamedRoutes.profile.routeName,
              builder: (ctx, state) => ChangeNotifierProvider(create: (_) => ProfileTabProvider(), child: const ProfileScreen(),),
            ),
          ],
        ),
      ],
    ),
  ],
);

enum NamedRoutes {
  welcome('/welcome'),
  home('/home'),
  explore('/explore'),
  favorites('/favorites'),
  profile('/profile');

  final String routeName;
  const NamedRoutes(this.routeName);
}
