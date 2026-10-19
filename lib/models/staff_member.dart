class StaffMember {
  final String name;
  final String employeeId;
  final String role;
  final String email;
  final String status;

  const StaffMember({
    required this.name,
    required this.employeeId,
    required this.role,
    required this.email,
    this.status = 'Active',
  });
}

class StaffActivityLog {
  final String dateTime;
  final String staffName;
  final String action;
  final String details;

  const StaffActivityLog({
    required this.dateTime,
    required this.staffName,
    required this.action,
    required this.details,
  });
}