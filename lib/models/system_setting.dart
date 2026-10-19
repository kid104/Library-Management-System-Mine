class SystemSettings {
  final String institutionName;
  final String contactEmail;
  final String phoneNumber;
  final String address;
  final String academicYear;
  final String dateFormat;
  final String timeFormat;
  final String openingTime;
  final String closingTime;
  final List<String> workingDays;
  final int maxBorrowingDays;
  final int maxBooksPerStudent;
  final int reservationDurationDays;
  final double fineCap;
  final String currency;

  const SystemSettings({
    this.institutionName = 'University Central Library & Information Center',
    this.contactEmail = 'library@univ.et',
    this.phoneNumber = '+251 11 123 4567',
    this.address = 'Addis Ababa, Ethiopia.',
    this.academicYear = '2025 - 2026',
    this.dateFormat = 'YYYY-MM-DD',
    this.timeFormat = '12 Hours (AM/PM)',
    this.openingTime = '08:00 AM',
    this.closingTime = '05:00 PM',
    this.workingDays = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
    this.maxBorrowingDays = 14,
    this.maxBooksPerStudent = 3,
    this.reservationDurationDays = 7,
    this.fineCap = 250.0,
    this.currency = 'ETB',
  });
}