import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import '../../models/staff_member.dart';
import '../../widgets/common/kpi_stat_card.dart';
import '../../widgets/common/status_badge.dart';

class StaffManagementScreen extends StatelessWidget {
  const StaffManagementScreen({super.key});

  final List<StaffMember> _staff = const [
    StaffMember(name: 'Samuel Worku', employeeId: 'EMP-7701', role: 'Administrator', email: 'samuel.w@library.univ.et'),
    StaffMember(name: 'Meron Alemu', employeeId: 'EMP-7708', role: 'Librarian', email: 'merona@library.univ.et'),
    StaffMember(name: 'Yohannes Girma', employeeId: 'EMP-7715', role: 'Librarian', email: 'yohannes.g@library.univ.et'),
    StaffMember(name: 'Hana Girma', employeeId: 'EMP-7718', role: 'Librarian', email: 'hana@library.univ.et'),
    StaffMember(name: 'Tesfaye Abebe', employeeId: 'EMP-7720', role: 'Librarian', email: 'tesfaye.a@library.univ.et'),
    StaffMember(name: 'Selam Tesfaye', employeeId: 'EMP-7721', role: 'Assistant Librarian', email: 'selam.t@library.univ.et'),
  ];

  final List<StaffActivityLog> _logs = const [
    StaffActivityLog(dateTime: 'Jun 8, 2025  10:24 AM', staffName: 'Samuel Worku', action: 'Created', details: 'New librarian account (EMP-7701)'),
    StaffActivityLog(dateTime: 'Jun 7, 2025  03:12 PM', staffName: 'Meron Alemu', action: 'Updated', details: 'Role changed to Librarian'),
    StaffActivityLog(dateTime: 'Jun 6, 2025  11:45 AM', staffName: 'Hana Girma', action: 'Logged In', details: 'System access'),
    StaffActivityLog(dateTime: 'Jun 5, 2025  09:32 AM', staffName: 'Tesfaye Abebe', action: 'Updated', details: 'Permissions modified'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----------------------------------------------------
          // LEFT MAIN CONTENT (70%)
          // ----------------------------------------------------
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Staff Management', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        SizedBox(height: 4),
                        Text('Manage staff accounts, roles, permissions, and access to the system.', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person_add_outlined, size: 18),
                      label: const Text('Add New Staff Member'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Top Metric Row
                Row(
                  children: const [
                    Expanded(child: KpiStatCard(icon: Icons.groups_outlined, value: '6', title: 'Total Staff', subtitle: 'active accounts', iconBgColor: AppColors.infoBg, iconColor: AppColors.info)),
                    SizedBox(width: 12),
                    Expanded(child: KpiStatCard(icon: Icons.shield_outlined, value: '2', title: 'Administrators', subtitle: 'full access', iconBgColor: Color(0xFFF3E8FF), iconColor: Color(0xFF7E22CE))),
                    SizedBox(width: 12),
                    Expanded(child: KpiStatCard(icon: Icons.person_outline, value: '3', title: 'Librarians', subtitle: 'library operations', iconBgColor: AppColors.infoBg, iconColor: AppColors.info)),
                    SizedBox(width: 12),
                    Expanded(child: KpiStatCard(icon: Icons.check_circle_outline, value: '6', title: 'Active Accounts', subtitle: 'all active', iconBgColor: AppColors.successBg, iconColor: AppColors.success)),
                  ],
                ),
                const SizedBox(height: 24),

                // Staff Members Data Table Card
                Container(
                  decoration: BoxDecoration(color: AppColors.cardSurface, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
                  child: Column(
                    children: [
                      // Header & search
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          children: [
                            const Text('Staff Members', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const Spacer(),
                            Container(
                              width: 240,
                              height: 38,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.border)),
                              child: const TextField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search, size: 16, color: AppColors.textMuted),
                                  hintText: 'Search by name, ID or email...',
                                  border: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(vertical: 8),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.filter_list, size: 14),
                              label: const Text('Filters', style: TextStyle(fontSize: 12)),
                              style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                            ),
                          ],
                        ),
                      ),
                      // Table header row
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: const BoxDecoration(color: AppColors.tableHeaderBg),
                        child: Row(
                          children: const [
                            Expanded(flex: 3, child: Text('Name', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                            Expanded(flex: 2, child: Text('Employee ID', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                            Expanded(flex: 2, child: Text('Role', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                            Expanded(flex: 3, child: Text('Email', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                            Expanded(flex: 2, child: Text('Status', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                            SizedBox(width: 80, child: Text('Actions', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                          ],
                        ),
                      ),
                      ..._staff.map((s) => _buildStaffRow(s)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Recent Staff Activity Audit Log
                _buildActivityTable(),
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
                _buildRolePermissionsCard(),
                const SizedBox(height: 24),
                _buildQuickActionsBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffRow(StaffMember s) {
    Color roleBg = const Color(0xFFEFF6FF);
    Color roleText = const Color(0xFF2563EB);
    if (s.role == 'Administrator') {
      roleBg = const Color(0xFFF3E8FF);
      roleText = const Color(0xFF7E22CE);
    } else if (s.role == 'Assistant Librarian') {
      roleBg = const Color(0xFFECFDF5);
      roleText = const Color(0xFF047857);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.borderSubtle))),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              children: [
                CircleAvatar(radius: 12, backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1), child: const Icon(Icons.person, size: 14, color: AppColors.primaryBlue)),
                const SizedBox(width: 8),
                Text(s.name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
              ],
            ),
          ),
          Expanded(flex: 2, child: Text(s.employeeId, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary))),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(color: roleBg, borderRadius: BorderRadius.circular(12)),
                child: Text(s.role, style: TextStyle(color: roleText, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
          Expanded(flex: 3, child: Text(s.email, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary))),
          const Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: StatusBadge(label: 'Active', type: StatusBadgeType.available))),
          SizedBox(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(icon: const Icon(Icons.edit_outlined, size: 14, color: AppColors.primaryBlue), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
                const SizedBox(width: 6),
                IconButton(icon: const Icon(Icons.person_outline, size: 14, color: AppColors.textSecondary), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
                const SizedBox(width: 6),
                IconButton(icon: const Icon(Icons.more_vert, size: 14, color: AppColors.textMuted), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTable() {
    return Container(
      decoration: BoxDecoration(color: AppColors.cardSurface, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Recent Staff Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text('View All →', style: TextStyle(fontSize: 12, color: AppColors.primaryBlue)),
              ],
            ),
          ),
          ..._logs.map(
            (l) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.borderSubtle))),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Text(l.dateTime, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary))),
                  Expanded(flex: 2, child: Text(l.staffName, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600))),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: AppColors.infoBg, borderRadius: BorderRadius.circular(4)),
                      child: Text(l.action, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: AppColors.info, fontWeight: FontWeight.bold)),
                    ),
                  ),
                  Expanded(flex: 4, child: Text(l.details, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRolePermissionsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.cardSurface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.shield_outlined, color: AppColors.primaryBlue, size: 18),
              SizedBox(width: 8),
              Text('Role Permissions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _roleTab('Administrator', true),
              _roleTab('Librarian', false),
              _roleTab('Assistant Librarian', false),
            ],
          ),
          const SizedBox(height: 16),
          const Text('+ Administrator Permissions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 10),
          _permCheckbox('Manage all staff accounts', true),
          _permCheckbox('Access LMS settings', true),
          _permCheckbox('Manage book inventory', true),
          _permCheckbox('View all records and reports', true),
          _permCheckbox('System configuration', true),
        ],
      ),
    );
  }

  Widget _roleTab(String title, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(color: active ? AppColors.primaryBlue : Colors.white, borderRadius: BorderRadius.circular(4), border: Border.all(color: active ? AppColors.primaryBlue : AppColors.border)),
      child: Text(title, style: TextStyle(fontSize: 10, color: active ? Colors.white : AppColors.textSecondary, fontWeight: FontWeight.bold)),
    );
  }

  Widget _permCheckbox(String label, bool checked) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(checked ? Icons.check_box : Icons.check_box_outline_blank, size: 16, color: AppColors.primaryBlue),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textPrimary)),
        ],
      ),
    );
  }

  Widget _buildQuickActionsBox() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.cardSurface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.bolt, color: AppColors.primaryBlue, size: 18),
              SizedBox(width: 6),
              Text('Quick Actions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _actionTile(Icons.person_add_outlined, 'Add Staff Member', 'Create a new account')),
              const SizedBox(width: 10),
              Expanded(child: _actionTile(Icons.manage_accounts_outlined, 'Manage Roles', 'Assign or change roles')),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _actionTile(Icons.lock_outline, 'Permissions', 'Set access rights')),
              const SizedBox(width: 10),
              Expanded(child: _actionTile(Icons.block_outlined, 'Deactivate Account', 'Disable staff access')),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionTile(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.infoBg.withValues(alpha: 0.25), borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.borderSubtle)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primaryBlue, size: 22),
          const SizedBox(height: 6),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
          const SizedBox(height: 2),
          Text(subtitle, textAlign: TextAlign.center, style: const TextStyle(fontSize: 9, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}