import 'package:flutter/material.dart';

import '../../config/app_theme.dart';
import '../../widgets/common/kpi_stat_card.dart';

class LibrarianNotificationsScreen extends StatefulWidget {
  const LibrarianNotificationsScreen({super.key});

  @override
  State<LibrarianNotificationsScreen> createState() =>
      _LibrarianNotificationsScreenState();
}

class _LibrarianNotificationsScreenState
    extends State<LibrarianNotificationsScreen> {
  String _selectedFilter = 'All (8)';

  final List<Map<String, dynamic>> _alerts = [
    {
      'type': 'Overdue',
      'title': "The book 'Atomic Habits' is overdue. It was due on 2025-06-22.",
      'student': 'Student: S-00123 (Abebe Kebede)',
      'time': '2 hours ago',
      'icon': Icons.notifications_active,
      'bg': AppColors.errorBg,
      'color': AppColors.error,
    },
    {
      'type': 'Due Soon',
      'title': "'The Great Gatsby' will be due in 2 days (2025-06-25).",
      'student': 'Student: S-00145 (Selam Tesfaye)',
      'time': '4 hours ago',
      'icon': Icons.access_time,
      'bg': AppColors.infoBg,
      'color': AppColors.info,
    },
    {
      'type': 'Reservation',
      'title': "Your reservation for 'Dune' is now available.",
      'student': 'Book ID: B-00127',
      'time': '6 hours ago',
      'icon': Icons.calendar_today,
      'bg': AppColors.successBg,
      'color': AppColors.success,
    },
    {
      'type': 'Overdue',
      'title': "The book 'Clean Code' is overdue. It was due on 2025-06-19.",
      'student': 'Student: S-00102 (Yonas Tadesse)',
      'time': '1 day ago',
      'icon': Icons.notifications_active,
      'bg': AppColors.errorBg,
      'color': AppColors.error,
    },
    {
      'type': 'Announcement',
      'title': 'The library will be closed on June 28, 2025 for maintenance.',
      'student': 'All services will resume on June 29, 2025.',
      'time': '2 days ago',
      'icon': Icons.campaign,
      'bg': const Color(0xFFF3E8FF),
      'color': const Color(0xFF7E22CE),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Stay updated with upcoming due dates, overdue books, reservations, and library announcements.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    _filterTab('All (8)'),
                    _filterTab('Due Soon (3)'),
                    _filterTab('Overdue (2)'),
                    _filterTab('Reservations (1)'),
                    _filterTab('Announcements (2)'),
                  ],
                ),
                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: _alerts
                        .where(
                          (a) =>
                              _selectedFilter == 'All (8)' ||
                              _selectedFilter.contains(a['type'] as String),
                        )
                        .map((a) => _buildAlertTile(a))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 24),

          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Notification Summary',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 14),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.6,
                  children: const [
                    KpiStatCard(
                      icon: Icons.notifications_active,
                      title: 'Overdue Books',
                      value: '2',
                      iconBgColor: AppColors.errorBg,
                      iconColor: AppColors.error,
                    ),
                    KpiStatCard(
                      icon: Icons.access_time,
                      title: 'Due Soon',
                      value: '3',
                      iconBgColor: AppColors.infoBg,
                      iconColor: AppColors.info,
                    ),
                    KpiStatCard(
                      icon: Icons.calendar_today,
                      title: 'Reservation(s)',
                      value: '1',
                      iconBgColor: AppColors.successBg,
                      iconColor: AppColors.success,
                    ),
                    KpiStatCard(
                      icon: Icons.campaign,
                      title: 'Announcements',
                      value: '2',
                      iconBgColor: Color(0xFFF3E8FF),
                      iconColor: Color(0xFF7E22CE),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.cardSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Quick Actions',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            'View All →',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      _actionTile(
                        Icons.calendar_month,
                        'View Due Dates',
                        'Check upcoming due dates',
                      ),
                      const Divider(height: 16, color: AppColors.borderSubtle),
                      _actionTile(
                        Icons.menu_book,
                        'Check Overdue Books',
                        'See all overdue items',
                      ),
                      const Divider(height: 16, color: AppColors.borderSubtle),
                      _actionTile(
                        Icons.calendar_today,
                        'Manage Reservations',
                        'View and manage reservations',
                      ),
                      const Divider(height: 16, color: AppColors.borderSubtle),
                      _actionTile(
                        Icons.campaign,
                        'Library Announcements',
                        'Read latest updates',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterTab(String label) {
    final bool isSelected = _selectedFilter == label;
    return InkWell(
      onTap: () => setState(() => _selectedFilter = label),
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        margin: const EdgeInsets.only(right: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }

  Widget _buildAlertTile(Map<String, dynamic> alert) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.borderSubtle)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: alert['bg'] as Color,
              shape: BoxShape.circle,
            ),
            child: Icon(
              alert['icon'] as IconData,
              color: alert['color'] as Color,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  alert['title'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  alert['student'] as String,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                alert['time'] as String,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: alert['bg'] as Color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  alert['type'] as String,
                  style: TextStyle(
                    color: alert['color'] as Color,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionTile(IconData icon, String title, String subtitle) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: AppColors.infoBg,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: AppColors.primaryBlue, size: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 10,
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, size: 16, color: AppColors.textMuted),
      ],
    );
  }
}
