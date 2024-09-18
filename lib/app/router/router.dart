import 'package:chai/app/screens/about.dart';
import 'package:chai/app/screens/home.dart';
import 'package:go_router/go_router.dart';

import 'bottom_nav.dart';

final router = GoRouter(
  routes: <RouteBase>[
    StatefulShellRoute(
      builder: (context, state, shell) => shell,
      navigatorContainerBuilder: (context, shell, children) {
        return ScaffoldWithNavBar(navigationShell: shell, children: children);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomePage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/about',
              builder: (context, state) => const AboutPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
