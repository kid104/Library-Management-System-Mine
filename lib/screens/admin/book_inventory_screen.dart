import 'package:flutter/material.dart';
import '../../config/app_theme.dart';
import '../../widgets/common/book_cover_thumb.dart';
import '../../widgets/common/category_badge.dart';
import '../../widgets/common/kpi_stat_card.dart';
import '../../widgets/common/status_badge.dart';

class BookInventoryScreen extends StatefulWidget {
  const BookInventoryScreen({super.key});

  @override
  State<BookInventoryScreen> createState() => _BookInventoryScreenState();
}

class _BookInventoryScreenState extends State<BookInventoryScreen> {
  String _selectedCategory = 'All Categories';
  String _selectedStatus = 'All Statuses';

  final List<Map<String, dynamic>> _inventory = [
    {
      'title': 'Atomic Habits',
      'author': 'James Clear',
      'isbn': '978-0735211292',
      'category': 'Self-Help',
      'total': 5,
      'available': 3,
      'status': 'Available',
      'shelf': 'Shelf A1',
    },
    {
      'title': 'Dune',
      'author': 'Frank Herbert',
      'isbn': '978-0441013593',
      'category': 'Science Fiction',
      'total': 4,
      'available': 1,
      'status': 'Low Stock',
      'shelf': 'Shelf B2',
    },
    {
      'title': 'The Great Gatsby',
      'author': 'F. Scott Fitzgerald',
      'isbn': '978-0743273567',
      'category': 'Fiction',
      'total': 6,
      'available': 6,
      'status': 'Available',
      'shelf': 'Shelf C3',
    },
    {
      'title': 'Clean Code',
      'author': 'Robert C. Martin',
      'isbn': '978-0132350884',
      'category': 'Computer Science',
      'total': 3,
      'available': 2,
      'status': 'Available',
      'shelf': 'Shelf D1',
    },
    {
      'title': 'Sapiens',
      'author': 'Yuval Noah Harari',
      'isbn': '978-0062316097',
      'category': 'History',
      'total': 5,
      'available': 4,
      'status': 'Available',
      'shelf': 'Shelf E2',
    },
    {
      'title': "Harry Potter and the Sorcerer's Stone",
      'author': 'J.K. Rowling',
      'isbn': '978-0545582885',
      'category': 'Fantasy',
      'total': 7,
      'available': 5,
      'status': 'Available',
      'shelf': 'Shelf F1',
    },
    {
      'title': '1984',
      'author': 'George Orwell',
      'isbn': '978-0451524935',
      'category': 'Dystopian',
      'total': 4,
      'available': 2,
      'status': 'Available',
      'shelf': 'Shelf F3',
    },
    {
      'title': 'To Kill a Mockingbird',
      'author': 'Harper Lee',
      'isbn': '978-0061120084',
      'category': 'Classic',
      'total': 6,
      'available': 5,
      'status': 'Available',
      'shelf': 'Shelf G1',
    },
    {
      'title': 'The Martian',
      'author': 'Andy Weir',
      'isbn': '978-0553418026',
      'category': 'Science Fiction',
      'total': 4,
      'available': 1,
      'status': 'Low Stock',
      'shelf': 'Shelf B1',
    },
    {
      'title': 'Data Structures and Algorithms',
      'author': 'Goodrich & Tamassia',
      'isbn': '978-0134260794',
      'category': 'Computer Science',
      'total': 5,
      'available': 4,
      'status': 'Available',
      'shelf': 'Shelf D3',
    },
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
                // Top Action Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Book Inventory', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textPrimary)),
                        SizedBox(height: 4),
                        Text('Manage book titles, authors, categories, physical copies, shelf locations, and availability status.', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 18),
                      label: const Text('Add New Book'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Search & Filter Dropdowns Row
                Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.border)),
                        child: const TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search, size: 18, color: AppColors.textMuted),
                            hintText: 'Search by title, author, ISBN, or accession number...',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: _buildDropdown(['All Categories', 'Fiction', 'Computer Science', 'History'], _selectedCategory, (v) => setState(() => _selectedCategory = v!)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 2,
                      child: _buildDropdown(['All Statuses', 'Available', 'Low Stock', 'Out of Stock'], _selectedStatus, (v) => setState(() => _selectedStatus = v!)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.search, size: 16),
                      label: const Text('Search'),
                      style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // 5 Metric KPI Cards Row
                Row(
                  children: const [
                    Expanded(child: KpiStatCard(icon: Icons.menu_book, value: '1,248', title: 'Total Books', subtitle: 'titles in collection', iconBgColor: AppColors.infoBg, iconColor: AppColors.info)),
                    SizedBox(width: 8),
                    Expanded(child: KpiStatCard(icon: Icons.copy, value: '2,860', title: 'Total Copies', subtitle: 'physical copies', iconBgColor: Color(0xFFEFF6FF), iconColor: Color(0xFF2563EB))),
                    SizedBox(width: 8),
                    Expanded(child: KpiStatCard(icon: Icons.check_circle_outline, value: '2,341', title: 'Available Copies', subtitle: 'available for loan', iconBgColor: AppColors.successBg, iconColor: AppColors.success)),
                    SizedBox(width: 8),
                    Expanded(child: KpiStatCard(icon: Icons.swap_horiz, value: '487', title: 'On Loan', subtitle: 'currently borrowed', iconBgColor: AppColors.warningBg, iconColor: AppColors.warning)),
                    SizedBox(width: 8),
                    Expanded(child: KpiStatCard(icon: Icons.access_time, value: '32', title: 'Reserved', subtitle: 'awaiting availability', iconBgColor: AppColors.errorBg, iconColor: AppColors.error)),
                  ],
                ),
                const SizedBox(height: 24),

                // Inventory Table Card
                _buildInventoryTable(),
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
                _buildInventoryOverviewCard(),
                const SizedBox(height: 24),
                _buildQuickActionsCard(),
                const SizedBox(height: 24),
                _buildRecentBookActivityCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(List<String> items, String currentVal, ValueChanged<String?> onChanged) {
    return Container(
      height: 42,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(6), border: Border.all(color: AppColors.border)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentVal,
          isExpanded: true,
          style: const TextStyle(fontSize: 12, color: AppColors.textPrimary),
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e, overflow: TextOverflow.ellipsis))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildInventoryTable() {
    return Container(
      decoration: BoxDecoration(color: AppColors.cardSurface, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.border)),
      child: Column(
        children: [
          // Table header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(color: AppColors.tableHeaderBg, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
            child: Row(
              children: const [
                SizedBox(width: 30, child: Icon(Icons.check_box_outline_blank, size: 16, color: AppColors.textMuted)),
                SizedBox(width: 44, child: Text('Cover', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                Expanded(flex: 3, child: Text('Title', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                Expanded(flex: 2, child: Text('Author', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                Expanded(flex: 2, child: Text('ISBN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                Expanded(flex: 2, child: Text('Category', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                SizedBox(width: 45, child: Text('Total', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                SizedBox(width: 55, child: Text('Available', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                Expanded(flex: 2, child: Text('Status', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                Expanded(flex: 2, child: Text('Location', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
                SizedBox(width: 60, child: Text('Actions', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11, color: AppColors.textSecondary))),
              ],
            ),
          ),
          ..._inventory.map((item) => _buildTableRow(item)),
          // Pagination footer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Showing 1–10 of 1,248', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                Row(
                  children: [
                    _pageBtn(icon: Icons.chevron_left, onPressed: null),
                    const SizedBox(width: 4),
                    _pageNumber(1, isActive: true),
                    const SizedBox(width: 4),
                    _pageNumber(2),
                    const SizedBox(width: 4),
                    _pageNumber(3),
                    const SizedBox(width: 4),
                    _pageNumber(4),
                    const SizedBox(width: 4),
                    _pageNumber(5),
                    const SizedBox(width: 4),
                    _pageBtn(icon: Icons.chevron_right, onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.borderSubtle))),
      child: Row(
        children: [
          const SizedBox(width: 30, child: Icon(Icons.check_box_outline_blank, size: 16, color: AppColors.textMuted)),
          SizedBox(width: 44, child: BookCoverThumb(title: item['title'] as String, width: 30, height: 42)),
          Expanded(flex: 3, child: Text(item['title'] as String, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12))),
          Expanded(flex: 2, child: Text(item['author'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary))),
          Expanded(flex: 2, child: Text(item['isbn'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary))),
          Expanded(flex: 2, child: Align(alignment: Alignment.centerLeft, child: CategoryBadge(category: item['category'] as String))),
          SizedBox(width: 45, child: Text('${item['total']}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
          SizedBox(width: 55, child: Text('${item['available']}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold))),
          Expanded(
            flex: 2,
            child: Center(
              child: StatusBadge(
                label: item['status'] as String,
                type: item['status'] == 'Available' ? StatusBadgeType.available : StatusBadgeType.lowStock,
              ),
            ),
          ),
          Expanded(flex: 2, child: Text(item['shelf'] as String, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary))),
          SizedBox(
            width: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(icon: const Icon(Icons.edit_outlined, size: 14, color: AppColors.primaryBlue), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
                const SizedBox(width: 6),
                IconButton(icon: const Icon(Icons.delete_outline, size: 14, color: AppColors.error), onPressed: () {}, padding: EdgeInsets.zero, constraints: const BoxConstraints()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pageNumber(int number, {bool isActive = false}) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(color: isActive ? AppColors.primaryBlue : Colors.transparent, borderRadius: BorderRadius.circular(4)),
      child: Center(child: Text('$number', style: TextStyle(color: isActive ? Colors.white : AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold))),
    );
  }

  Widget _pageBtn({required IconData icon, VoidCallback? onPressed}) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(4)),
      child: IconButton(padding: EdgeInsets.zero, icon: Icon(icon, size: 14, color: onPressed != null ? AppColors.textPrimary : AppColors.textMuted), onPressed: onPressed),
    );
  }

  // Right Rail: Donut Chart Overview Card
  Widget _buildInventoryOverviewCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppColors.cardSurface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.pie_chart_outline, color: AppColors.sidebarBlue, size: 18),
              SizedBox(width: 8),
              Text('Inventory Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              // Circular Donut Mockup
              SizedBox(
                width: 90,
                height: 90,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(value: 0.82, strokeWidth: 8, color: const Color(0xFF10B981), backgroundColor: const Color(0xFFE2E8F0)),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text('2,860', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        Text('Total Copies', style: TextStyle(fontSize: 8, color: AppColors.textMuted)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    _legendItem(Color(0xFF10B981), 'Available', '2,341 (81.8%)'),
                    SizedBox(height: 6),
                    _legendItem(Color(0xFFF59E0B), 'On Loan', '487 (17.0%)'),
                    SizedBox(height: 6),
                    _legendItem(Color(0xFFEF4444), 'Reserved', '32 (1.1%)'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsCard() {
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
              Expanded(child: _actionTile(Icons.add_circle_outline, 'Add New Book', 'Add a new book title')),
              const SizedBox(width: 10),
              Expanded(child: _actionTile(Icons.file_upload_outlined, 'Import Books', 'Bulk import from file')),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(child: _actionTile(Icons.sell_outlined, 'Manage Categories', 'View and edit categories')),
              const SizedBox(width: 10),
              Expanded(child: _actionTile(Icons.location_on_outlined, 'Manage Locations', 'Edit shelf locations')),
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

  Widget _buildRecentBookActivityCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: AppColors.cardSurface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Recent Book Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
              Text('View All →', style: TextStyle(fontSize: 11, color: AppColors.primaryBlue)),
            ],
          ),
          const SizedBox(height: 12),
          _activityItem('New book added\nClean Code', 'by Robert C. Martin · 2 hours ago'),
          const Divider(height: 16, color: AppColors.borderSubtle),
          _activityItem('Book updated\nAtomic Habits', 'by James Clear · 4 hours ago'),
          const Divider(height: 16, color: AppColors.borderSubtle),
          _activityItem('Copy checked in\nDune (Copy #3)', '1 day ago'),
        ],
      ),
    );
  }

  Widget _activityItem(String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BookCoverThumb(title: title, width: 28, height: 40),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(fontSize: 9, color: AppColors.textMuted)),
            ],
          ),
        ),
      ],
    );
  }
}

class _legendItem extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  const _legendItem(this.color, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 6),
        Text('$label: ', style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
        Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    );
  }
}