enum CirculationStatus {
  active,
  dueSoon,
  overdue,
  returned,
}

enum BookCondition {
  good,
  minorDamage,
  lost,
}

class BorrowRecord {
  final String id;
  final String bookTitle;
  final String author;
  final String category;
  final String isbn;
  final String borrowedDate;
  final String dueDate;
  final String? returnedDate;
  final String dueCountdown;
  final CirculationStatus status;
  final String? coverUrl;

  const BorrowRecord({
    required this.id,
    required this.bookTitle,
    required this.author,
    required this.category,
    required this.isbn,
    required this.borrowedDate,
    required this.dueDate,
    this.returnedDate,
    required this.dueCountdown,
    required this.status,
    this.coverUrl,
  });
}

class StudentVerification {
  final String studentId;
  final String name;
  final String department;
  final int activeLoansCount;
  final bool hasOverdueFines;

  const StudentVerification({
    required this.studentId,
    required this.name,
    required this.department,
    this.activeLoansCount = 0,
    this.hasOverdueFines = false,
  });
}

class LoanReturnAssessment {
  final String recordId;
  final String studentName;
  final String bookTitle;
  final String isbn;
  final String borrowDate;
  final String dueDate;
  final int overdueDays;
  final double dailyFineRate;
  final double totalFine;

  const LoanReturnAssessment({
    required this.recordId,
    required this.studentName,
    required this.bookTitle,
    required this.isbn,
    required this.borrowDate,
    required this.dueDate,
    this.overdueDays = 0,
    this.dailyFineRate = 0.40,
    this.totalFine = 0.0,
  });

  bool get hasOverdue => overdueDays > 0;
}