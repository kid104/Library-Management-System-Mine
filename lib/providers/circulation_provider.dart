import 'package:flutter/material.dart';
import '../models/book.dart';
import '../models/borrow_record.dart';

class CirculationProvider extends ChangeNotifier {
  // ---------------------------------------------------------------------------
  // Reader History Data (Readerhom2)
  // ---------------------------------------------------------------------------
  final List<BorrowRecord> _activeBorrows = [
    const BorrowRecord(
      id: 'b1',
      bookTitle: 'Atomic Habits',
      author: 'James Clear',
      category: 'Self-Help',
      isbn: '978-0735211292',
      borrowedDate: 'Oct 2, 2026',
      dueDate: 'Oct 10, 2026',
      dueCountdown: 'Due in 2 days',
      status: CirculationStatus.dueSoon,
    ),
    const BorrowRecord(
      id: 'b2',
      bookTitle: 'Dune',
      author: 'Frank Herbert',
      category: 'Science Fiction',
      isbn: '978-0441013593',
      borrowedDate: 'Sep 28, 2026',
      dueDate: 'Oct 13, 2026',
      dueCountdown: 'Due in 5 days',
      status: CirculationStatus.active,
    ),
    const BorrowRecord(
      id: 'b3',
      bookTitle: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      category: 'Fiction',
      isbn: '978-0743273567',
      borrowedDate: 'Sep 25, 2026',
      dueDate: 'Oct 15, 2026',
      dueCountdown: 'Due in 7 days',
      status: CirculationStatus.active,
    ),
  ];

  final List<BorrowRecord> _borrowingHistory = [
    const BorrowRecord(
      id: 'h1',
      bookTitle: 'Clean Code',
      author: 'Robert C. Martin',
      category: 'Computer Science',
      isbn: '978-0132350884',
      borrowedDate: 'Sep 15, 2026',
      dueDate: 'Oct 1, 2026',
      returnedDate: 'Oct 1, 2026',
      dueCountdown: '',
      status: CirculationStatus.returned,
    ),
    const BorrowRecord(
      id: 'h2',
      bookTitle: 'Sapiens',
      author: 'Yuval Noah Harari',
      category: 'History',
      isbn: '978-0062316097',
      borrowedDate: 'Sep 10, 2026',
      dueDate: 'Sep 27, 2026',
      returnedDate: 'Sep 27, 2026',
      dueCountdown: '',
      status: CirculationStatus.returned,
    ),
    const BorrowRecord(
      id: 'h3',
      bookTitle: '1984',
      author: 'George Orwell',
      category: 'Dystopian',
      isbn: '978-0451524935',
      borrowedDate: 'Sep 5, 2026',
      dueDate: 'Sep 20, 2026',
      returnedDate: 'Sep 20, 2026',
      dueCountdown: '',
      status: CirculationStatus.returned,
    ),
  ];

  List<BorrowRecord> get activeBorrows => _activeBorrows;
  List<BorrowRecord> get borrowingHistory => _borrowingHistory;
  int get currentlyBorrowedCount => _activeBorrows.length;
  int get dueSoonCount => 1;
  int get overdueCount => 0;
  int get completedCount => 8;

  // ---------------------------------------------------------------------------
  // Librarian Desk State (librarian 2)
  // ---------------------------------------------------------------------------
  Book? checkedBook;
  StudentVerification? verifiedStudent;
  bool isCheckingStock = false;
  String? stockErrorMessage;

  final String borrowDate = '2025-06-08';
  final String calculatedDueDate = '2025-06-22 (14 days)';

  LoanReturnAssessment? activeReturnAssessment;
  BookCondition selectedCondition = BookCondition.good;
  bool isSearchingReturnRecord = false;
  String? returnErrorMessage;

  // Check Availability button handler
  void checkAvailability(String studentId, String bookQuery) {
    isCheckingStock = true;
    stockErrorMessage = null;
    notifyListeners();

    if (studentId.trim().isEmpty || bookQuery.trim().isEmpty) {
      stockErrorMessage = 'Please enter both Student ID and Book ISBN/Title.';
      isCheckingStock = false;
      notifyListeners();
      return;
    }

    verifiedStudent = StudentVerification(
      studentId: studentId.trim(),
      name: 'Abebe Kebede',
      department: 'Computer Science',
      activeLoansCount: 2,
    );

    if (bookQuery.toLowerCase().contains('unavailable') || bookQuery == '0') {
      checkedBook = null;
      stockErrorMessage = 'Book is currently OUT OF STOCK (0 copies available).';
    } else {
      checkedBook = Book(
        id: 'b-gatsby',
        title: bookQuery.length > 10 ? 'The Great Gatsby' : bookQuery,
        author: 'F. Scott Fitzgerald',
        isbn: '978-0132357059',
        category: 'Fiction',
        totalCopies: 6,
        availableCopies: 4,
      );
    }

    isCheckingStock = false;
    notifyListeners();
  }

  // Find Active Loan Record button handler
  void searchBorrowRecord(String studentId, String bookQuery) {
    isSearchingReturnRecord = true;
    returnErrorMessage = null;
    notifyListeners();

    if (studentId.trim().isEmpty || bookQuery.trim().isEmpty) {
      returnErrorMessage = 'Enter Student ID and Book Title/ISBN to inspect record.';
      isSearchingReturnRecord = false;
      notifyListeners();
      return;
    }

    activeReturnAssessment = const LoanReturnAssessment(
      recordId: 'rec-901',
      studentName: 'Abebe Kebede',
      bookTitle: 'The Great Gatsby',
      isbn: '978-0132357059',
      borrowDate: '2025-06-08',
      dueDate: '2025-06-22',
      overdueDays: 5,
      dailyFineRate: 0.40,
      totalFine: 2.00,
    );

    isSearchingReturnRecord = false;
    notifyListeners();
  }

  void setCondition(BookCondition condition) {
    selectedCondition = condition;
    notifyListeners();
  }

  void confirmBorrowing(BuildContext context) {
    if (checkedBook == null || verifiedStudent == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Issued "${checkedBook!.title}" to ${verifiedStudent!.name} successfully!'),
        backgroundColor: const Color(0xFF059669),
      ),
    );
    checkedBook = null;
    verifiedStudent = null;
    notifyListeners();
  }

  void confirmReturn(BuildContext context) {
    if (activeReturnAssessment == null) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Return completed for "${activeReturnAssessment!.bookTitle}". Condition: ${selectedCondition.name}.'),
        backgroundColor: const Color(0xFF059669),
      ),
    );
    activeReturnAssessment = null;
    notifyListeners();
  }
}