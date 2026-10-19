import 'package:flutter/material.dart';

import '../../config/app_theme.dart';
import '../../models/system_setting.dart';

class LmsSettingsScreen extends StatefulWidget {
  const LmsSettingsScreen({super.key});

  @override
  State<LmsSettingsScreen> createState() => _LmsSettingsScreenState();
}

class _LmsSettingsScreenState extends State<LmsSettingsScreen> {
  final SystemSettings _settings = const SystemSettings();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----------------------------------------------------
          // LEFT MAIN CONTENT (70%) - Single continuous scroll
          // ----------------------------------------------------
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'LMS Settings',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Configure library rules, circulation settings, and system parameters.',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),

                // 1. Institution Information Panel
                _buildCard(
                  icon: Icons.account_balance_outlined,
                  title: 'Institution Information',
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _inputGroup(
                              'Institution Name *',
                              _settings.institutionName,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _inputGroup(
                                    'Contact Email *',
                                    _settings.contactEmail,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _inputGroup(
                                    'Phone Number *',
                                    _settings.phoneNumber,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _inputGroup(
                              'Address *',
                              _settings.address,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      // Library Logo Upload Box
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Library Logo',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              height: 120,
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.menu_book,
                                      color: AppColors.primaryBlue,
                                      size: 30,
                                    ),
                                    SizedBox(height: 6),
                                    Text(
                                      'Choose Logo',
                                      style: TextStyle(
                                        color: AppColors.primaryBlue,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Recommended: 200×80 px',
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: AppColors.textMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 2. System Settings Panel
                _buildCard(
                  icon: Icons.tune_outlined,
                  title: 'System Settings',
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _inputGroup(
                              'Academic Year',
                              _settings.academicYear,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _inputGroup(
                              'Date Format',
                              _settings.dateFormat,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _inputGroup('Default Language', 'English'),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _inputGroup(
                              'Time Format',
                              _settings.timeFormat,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 3. Working Hours Panel
                _buildCard(
                  icon: Icons.access_time,
                  title: 'Working Hours',
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _inputGroup(
                          'Opening Time *',
                          _settings.openingTime,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _inputGroup(
                          'Closing Time *',
                          _settings.closingTime,
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Working Days',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              runSpacing: 6,
                              children: [
                                _dayCheck('Mon', true),
                                _dayCheck('Tue', true),
                                _dayCheck('Wed', true),
                                _dayCheck('Thu', true),
                                _dayCheck('Fri', true),
                                _dayCheck('Sat', false),
                                _dayCheck('Sun', false),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 4. Circulation Rules & Lending Limits
                _buildCard(
                  icon: Icons.cached,
                  title: 'Circulation Rules & Lending Limits',
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _inputGroup(
                              'Maximum Borrowing Days *',
                              '${_settings.maxBorrowingDays}',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _inputGroup(
                              'Maximum Books Per Student *',
                              '${_settings.maxBooksPerStudent}',
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _inputGroup('Grace Period (Days) *', '0'),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _inputGroup(
                              'Maximum Extensions / Renewals *',
                              '2',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 5. Fine Policy Panel
                _buildCard(
                  icon: Icons.monetization_on_outlined,
                  title: 'Fine Policy',
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _inputGroup('Fine Rate Per Day *', '5.00'),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _inputGroup(
                              'Currency Symbol *',
                              _settings.currency,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _inputGroup(
                              'Fine Cap (0 for No Cap) *',
                              '${_settings.fineCap.toInt()}',
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _inputGroup(
                              'Lost Book Replacement Fee Multiplier',
                              '1.5x',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // 6. Reservation Settings Panel
                _buildCard(
                  icon: Icons.calendar_today_outlined,
                  title: 'Reservation Settings',
                  child: Row(
                    children: [
                      Expanded(
                        child: _inputGroup(
                          'Hold Pickup Window (Days) *',
                          '${_settings.reservationDurationDays}',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _inputGroup(
                          'Max Active Holds Per Student *',
                          '3',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Save Changes Footer Action Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('LMS Settings saved successfully!'),
                            backgroundColor: Color(0xFF059669),
                          ),
                        );
                      },
                      icon: const Icon(Icons.save_outlined, size: 18),
                      label: const Text('Save Settings'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),

          const SizedBox(width: 24),

          // ----------------------------------------------------
          // RIGHT RAIL (30%)
          // ----------------------------------------------------
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCurrentSettingsSummary(),
                const SizedBox(height: 24),
                _buildQuickInfoCard(),
                const SizedBox(height: 24),
                _buildLastUpdatedCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.primaryBlue, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _inputGroup(String label, String value, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: value,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 12),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            isDense: true,
          ),
        ),
      ],
    );
  }

  Widget _dayCheck(String day, bool checked) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          checked ? Icons.check_box : Icons.check_box_outline_blank,
          size: 14,
          color: checked ? AppColors.primaryBlue : AppColors.textMuted,
        ),
        const SizedBox(width: 4),
        Text(
          day,
          style: TextStyle(
            fontSize: 11,
            color: checked ? AppColors.textPrimary : AppColors.textMuted,
          ),
        ),
      ],
    );
  }

  Widget _buildCurrentSettingsSummary() {
    return Container(
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
                'Current Settings Summary',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
              Text(
                'Overview',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _summaryRow(Icons.access_time, 'Borrowing Period', '14 days'),
          _summaryRow(Icons.menu_book, 'Max Books per Student', '3 books'),
          _summaryRow(
            Icons.monetization_on_outlined,
            'Fine Rate per Day',
            '5 ETB',
          ),
          _summaryRow(Icons.hourglass_empty, 'Grace Period', '0 days'),
          _summaryRow(Icons.bookmark_outline, 'Max Hold Duration', '3 days'),
          _summaryRow(
            Icons.calendar_today_outlined,
            'Reservation Duration',
            '7 days',
          ),
          _summaryRow(
            Icons.account_balance_wallet_outlined,
            'Fine Cap (per book)',
            '250 ETB',
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.primaryBlue),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickInfoCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.infoBg.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderSubtle),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.info_outline, size: 16, color: AppColors.info),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'These settings control borrowing, reservation, and fine calculations across the entire system.',
              style: TextStyle(fontSize: 11, color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastUpdatedCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.cardSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: const [
          Icon(Icons.history, size: 16, color: AppColors.textMuted),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last Updated',
                style: TextStyle(fontSize: 10, color: AppColors.textMuted),
              ),
              Text(
                'Jun 8, 2025 · 10:24 AM by Admin',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
