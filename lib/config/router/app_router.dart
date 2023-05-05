import 'package:cine_mapedia/presentation/screens/screens.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: "/", routes: [
  GoRoute(
    path: "/",
    name: DomusScreen.nomen,
    builder: (context, state) => const DomusScreen(),
  ),
]);
