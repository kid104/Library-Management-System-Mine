import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/app_theme.dart';
import '../../models/borrow_record.dart';
import '../../providers/autho_role.dart';
import '../../providers/circulation_provider.dart';
import '../../widgets/common/book_cover_thumb.dart';
import '../../widgets/common/kpi_stat_card.dart';

class BorrowReturnDeskScreen extends StatefulWidget {
  const BorrowReturnDeskScreen({super.key});

  @override
  State<BorrowReturnDeskScreen> createState() => _BorrowReturnDeskScreenState();
}

class _BorrowReturnDeskScreenState extends State<BorrowReturnDeskScreen> {
  final TextEditingController _borrowStudentController = TextEditingController(text: 'S-00123');
  final TextEditingController _borrowBookController = TextEditingController(text: '978-0132357059');

  final TextEditingController _returnStudentController = TextEditingController(text: 'S-00123');
  final TextEditingController _returnBookController = TextEditingController(text: '978-0132357059');

  @override
  void dispose() {
    _borrowStudentController.dispose();
    _borrowBookController.dispose();
    _returnStudentController.dispose();
    _returnBookController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthRoleProvider>();
    final circ = context.watch<CirculationProvider>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----------------------------------------------------
          // LEFT MAIN: DUAL WORKSTATION DESK (~70%)
          // ----------------------------------------------------
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back, ${auth.userName.split(' ').first}!',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Borrow books, process returns, and keep track of your library activities.',
                  style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 24),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ==========================================
                    // 1. BORROW BOOK PANEL
                    // ==========================================
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.cardSurface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(color: AppColors.infoBg, shape: BoxShape.circle),
                                  child: const Icon(Icons.menu_book, color: AppColors.primaryBlue, size: 20),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Borrow Book', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    Text('Issue a book to a student', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            const Text('Student ID *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                            const SizedBox(height: 6),
                            _buildInputBox(_borrowStudentController, Icons.person_outline, 'Enter student ID (e.g. S-00123)'),
                            const SizedBox(height: 16),

                            const Text('Book Title or ISBN *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                            const SizedBox(height: 6),
                            _buildInputBox(_borrowBookController, Icons.search, 'Enter book title or ISBN (e.g. 978-0132357059)'),
                            const SizedBox(height: 16),

                            // Check Stock Button
                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: circ.isCheckingStock
                                    ? null
                                    : () {
                                        circ.checkAvailability(
                                          _borrowStudentController.text,
                                          _borrowBookController.text,
                                        );
                                      },
                                icon: circ.isCheckingStock
                                    ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2))
                                    : const Icon(Icons.inventory_2_outlined, size: 16),
                                label: const Text('Check Stock & Availability'),
                                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                              ),
                            ),
                            const SizedBox(height: 12),

                            if (circ.stockErrorMessage != null)
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(color: AppColors.errorBg, borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  circ.stockErrorMessage!,
                                  style: const TextStyle(color: AppColors.errorText, fontSize: 12, fontWeight: FontWeight.w500),
                                ),
                              ),

                            // Verified Book Card
                            if (circ.checkedBook != null) ...[
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: AppColors.infoBg.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.borderSubtle),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: const [
                                            Icon(Icons.check_circle, size: 16, color: AppColors.successText),
                                            SizedBox(width: 6),
                                            Text('Book In Stock', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.successText)),
                                          ],
                                        ),
                                        Text('${circ.checkedBook!.availableCopies} Copies Available', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    _infoRow('Title:', circ.checkedBook!.title),
                                    _infoRow('Author:', circ.checkedBook!.author),
                                    _infoRow('ISBN:', circ.checkedBook!.isbn),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],

                            // Verified Student Card
                            if (circ.verifiedStudent != null) ...[
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: AppColors.successBg.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.borderSubtle),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: const [
                                        Icon(Icons.person_outline, size: 16, color: AppColors.successText),
                                        SizedBox(width: 6),
                                        Text('Student Verified', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.successText)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    _infoRow('Name:', circ.verifiedStudent!.name),
                                    _infoRow('Student ID:', circ.verifiedStudent!.studentId),
                                    _infoRow('Department:', circ.verifiedStudent!.department),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),

                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
                                child: Column(
                                  children: [
                                    _dateFieldRow('Borrow Date:', circ.borrowDate),
                                    const SizedBox(height: 6),
                                    _dateFieldRow('Due Date:', circ.calculatedDueDate),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () => circ.confirmBorrowing(context),
                                  icon: const Icon(Icons.menu_book, size: 18),
                                  label: const Text('Confirm Borrowing'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.primaryBlue,
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    // ==========================================
                    // 2. RETURN BOOK PANEL
                    // ==========================================
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppColors.cardSurface,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(color: AppColors.successBg, shape: BoxShape.circle),
                                  child: const Icon(Icons.swap_horiz, color: AppColors.success, size: 20),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text('Return Book', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    Text('Process a book return and check for fines', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),

                            const Text('Student ID *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                            const SizedBox(height: 6),
                            _buildInputBox(_returnStudentController, Icons.person_outline, 'Enter student ID (e.g. S-00123)'),
                            const SizedBox(height: 16),

                            const Text('Book Title or ISBN *', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                            const SizedBox(height: 6),
                            _buildInputBox(_returnBookController, Icons.search, 'Enter book title or ISBN (e.g. 978-0132357059)'),
                            const SizedBox(height: 16),

                            SizedBox(
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                onPressed: circ.isSearchingReturnRecord
                                    ? null
                                    : () {
                                        circ.searchBorrowRecord(
                                          _returnStudentController.text,
                                          _returnBookController.text,
                                        );
                                      },
                                icon: circ.isSearchingReturnRecord
                                    ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2))
                                    : const Icon(Icons.receipt_long_outlined, size: 16),
                                label: const Text('Find Active Loan Record'),
                                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 12)),
                              ),
                            ),
                            const SizedBox(height: 12),

                            if (circ.activeReturnAssessment != null) ...[
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: AppColors.infoBg.withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.borderSubtle),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _infoRow('Student Name:', circ.activeReturnAssessment!.studentName),
                                    _infoRow('Book Title:', circ.activeReturnAssessment!.bookTitle),
                                    _infoRow('ISBN:', circ.activeReturnAssessment!.isbn),
                                    _infoRow('Borrow Date:', circ.activeReturnAssessment!.borrowDate),
                                    _infoRow('Due Date:', circ.activeReturnAssessment!.dueDate),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),

                              if (circ.activeReturnAssessment!.hasOverdue)
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEF2F2),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: const Color(0xFFFECACA)),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: const [
                                                Icon(Icons.warning_amber_rounded, size: 16, color: AppColors.error),
                                                SizedBox(width: 4),
                                                Text('Overdue Fine', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.error)),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              '\$${circ.activeReturnAssessment!.totalFine.toStringAsFixed(2)}',
                                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: AppColors.error),
                                            ),
                                            Text(
                                              'The book is ${circ.activeReturnAssessment!.overdueDays} days overdue.',
                                              style: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Daily rate: \$${circ.activeReturnAssessment!.dailyFineRate.toStringAsFixed(2)}', style: const TextStyle(fontSize: 10)),
                                            Text('Overdue days: ${circ.activeReturnAssessment!.overdueDays}', style: const TextStyle(fontSize: 10)),
                                            Text('Total: \$${circ.activeReturnAssessment!.totalFine.toStringAsFixed(2)}', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.error)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              const SizedBox(height: 12),

                              // Condition Radio Selector
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.border)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('Select Book Condition *', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        _conditionRadio('Good', BookCondition.good, circ),
                                        _conditionRadio('Minor damage', BookCondition.minorDamage, circ),
                                        _conditionRadio('Lost', BookCondition.lost, circ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),

                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () => circ.confirmReturn(context),
                                  icon: const Icon(Icons.swap_horiz, size: 18),
                                  label: const Text('Confirm Return'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF059669),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 24),

          // ----------------------------------------------------
          // RIGHT RAIL (~30%)
          // ----------------------------------------------------
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('My Reading Summary', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    Text('View All →', style: TextStyle(fontSize: 12, color: AppColors.primaryBlue)),
                  ],
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
                    KpiStatCard(icon: Icons.menu_book, title: 'Books Borrowed', value: '3', iconBgColor: AppColors.infoBg, iconColor: AppColors.info),
                    KpiStatCard(icon: Icons.access_time, title: 'Due Soon', value: '1', iconBgColor: AppColors.infoBg, iconColor: AppColors.info),
                    KpiStatCard(icon: Icons.calendar_today, title: 'Reservation(s)', value: '1', iconBgColor: AppColors.infoBg, iconColor: AppColors.info),
                    KpiStatCard(icon: Icons.notifications, title: 'Notifications', value: '2', iconBgColor: AppColors.errorBg, iconColor: AppColors.error),
                  ],
                ),
                const SizedBox(height: 24),
                _buildUpcomingDueCard(),
                const SizedBox(height: 24),
                _buildRecentNotificationsCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBox(TextEditingController controller, IconData icon, String hint) {
    return Container(
      height: 42,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.border)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Icon(icon, color: AppColors.textMuted, size: 18),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                isDense: true,
              ),
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(width: 90, child: Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary))),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
        ],
      ),
    );
  }

  Widget _dateFieldRow(String label, String value) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary))),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.circular(4), border: Border.all(color: AppColors.border)),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 11, color: AppColors.textSecondary),
                const SizedBox(width: 4),
                Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _conditionRadio(String label, BookCondition value, CirculationProvider circ) {
    return Row(
      children: [
        Radio<BookCondition>(
          value: value,
          groupValue: circ.selectedCondition,
          activeColor: AppColors.primaryBlue,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          onChanged: (BookCondition? val) {
            if (val != null) circ.setCondition(val);
          },
        ),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
        const SizedBox(width: 6),
      ],
    );
  }

  Widget _buildUpcomingDueCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.cardSurface, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Upcoming Due Dates', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text('View All →', style: TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
            ],
          ),
          const SizedBox(height: 12),
          _dueItem('Atomic Habits', 'James Clear', 'Due in 2 days', AppColors.errorBg, AppColors.errorText),
          const Divider(height: 16, color: AppColors.borderSubtle),
          _dueItem('Dune', 'Frank Herbert', 'Due in 5 days', AppColors.warningBg, AppColors.warningText),
        ],
      ),
    );
  }

  Widget _dueItem(String title, String author, String chipLabel, Color bg, Color text) {
    return Row(
      children: [
        BookCoverThumb(title: title, width: 28, height: 40),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)),
              Text(author, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(10)),
          child: Text(chipLabel, style: TextStyle(color: text, fontSize: 9, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildRecentNotificationsCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.cardSurface, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Recent Notifications', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text('View All →', style: TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
            ],
          ),
          const SizedBox(height: 12),
          _notifItem(Icons.notifications, AppColors.errorBg, AppColors.error, 'Your book "Atomic Habits" is due in 2 days.', '2 hours ago'),
          const Divider(height: 16, color: AppColors.borderSubtle),
          _notifItem(Icons.info_outline, AppColors.infoBg, AppColors.info, 'New reservation for "The Martian" is now available.', '1 day ago'),
        ],
      ),
    );
  }

  Widget _notifItem(IconData icon, Color bg, Color color, String title, String time) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 14),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(time, style: const TextStyle(fontSize: 9, color: AppColors.textMuted)),
            ],
          ),
        ),
      ],
    );
  }
}