import 'package:go_router/go_router.dart';
import '../ui/view/home.dart';
import '../ui/view/admin/admin_rsvp_view.dart';
import '../ui/view/admin/admin_dashboard_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const WeddingHomePage()),
    GoRoute(
      path: '/admin',
      builder: (context, state) => const AdminDashboardView(),
    ),
    GoRoute(
      path: '/admin/rsvp',
      builder: (context, state) => const AdminRsvpView(),
    ),
  ],
);
