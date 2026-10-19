import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/reader/reader_notification_screen.dart';
import '../screens/reader/reader_reservation_screen.dart';
import '../screens/reader/my_books_screen.dart';
import '../screens/shell/main_layout_shell.dart';
import '../screens/reader/reader_home_screen.dart';
import '../screens/librarian/borrow_return_desk_screen.dart';
import '../screens/librarian/librarian_notification_screen.dart';
import '../screens/admin/book_inventory_screen.dart';
import '../screens/admin/staff_management_screen.dart';
import '../screens/admin/lms_settings_screen.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/reader/home',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainLayoutShell(child: child),
      routes: [
        // Reader routes
        GoRoute(
          path: '/reader/home',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ReaderHomeScreen()),
        ),
        GoRoute(
          path: '/reader/books',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MyBooksScreen()),
        ),
        GoRoute(
          path: '/reader/reservations',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ReaderReservationsScreen()),
        ),
        GoRoute(
          path: '/reader/notifications',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ReaderNotificationsScreen()),
        ),

        // Librarian routes
        GoRoute(
          path: '/librarian/circulation',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: BorrowReturnDeskScreen()),
        ),
        GoRoute(
          path: '/librarian/notifications',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: LibrarianNotificationsScreen()),
        ),

        // Admin routes
        GoRoute(
          path: '/admin/settings',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: LmsSettingsScreen()),
        ),
        GoRoute(
          path: '/admin/staff',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: StaffManagementScreen()),
        ),
        GoRoute(
          path: '/admin/inventory',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: BookInventoryScreen()),
        ),
      ],
    ),
  ],
);
