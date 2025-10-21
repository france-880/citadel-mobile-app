class ApiConfig {
  // Base URL for your Laravel backend
  // Change this to your actual backend URL
  static const String baseUrl = 'http://127.0.0.1:8000/api';

  // For production, use your actual domain:
  // static const String baseUrl = 'https://your-domain.com/api';

  // For testing with emulator, use 10.0.2.2 instead of localhost:
  // static const String baseUrl = 'http://10.0.2.2:8000/api';

  // For testing with physical device, use your computer's IP address:
  // static const String baseUrl = 'http://192.168.1.100:8000/api';

  // Mobile API endpoints
  static const String mobileBaseUrl = '$baseUrl/mobile';

  // Authentication endpoints
  static const String loginEndpoint = '/mobile/login';
  static const String logoutEndpoint = '/mobile/logout';
  static const String userEndpoint = '/mobile/me';
  static const String profileEndpoint = '/mobile/profile';
  static const String changePasswordEndpoint = '/mobile/change-password';
  static const String forgotPasswordEndpoint = '/mobile/forgot-password';
  static const String resetPasswordEndpoint = '/mobile/reset-password';
  static const String refreshTokenEndpoint = '/mobile/refresh-token';

  // Health check endpoint
  static const String healthEndpoint = '/mobile/health';

  // Student endpoints
  static const String studentDashboardEndpoint = '/mobile/student/dashboard';
  static const String studentScheduleEndpoint = '/mobile/student/schedule';
  static const String studentAttendanceEndpoint = '/mobile/student/attendance';
  static const String studentCheckInEndpoint =
      '/mobile/student/attendance/check-in';
  static const String studentCheckOutEndpoint =
      '/mobile/student/attendance/check-out';
  static const String studentGradesEndpoint = '/mobile/student/grades';
  static const String studentSubjectsEndpoint = '/mobile/student/subjects';
  static const String studentNotificationsEndpoint =
      '/mobile/student/notifications';

  // Professor endpoints
  static const String professorDashboardEndpoint =
      '/mobile/professor/dashboard';
  static const String professorScheduleEndpoint = '/mobile/professor/schedule';
  static const String professorClassesEndpoint = '/mobile/professor/classes';
  static const String professorAttendanceEndpoint =
      '/mobile/professor/attendance';
  static const String professorMarkAttendanceEndpoint =
      '/mobile/professor/attendance/mark';
  static const String professorStudentsEndpoint = '/mobile/professor/students';
  static const String professorGenerateQREndpoint =
      '/mobile/professor/qr/generate';
  static const String professorNotificationsEndpoint =
      '/mobile/professor/notifications';

  // Common endpoints
  static const String attendanceHistoryEndpoint =
      '/mobile/common/attendance/history';
  static const String attendanceQrScanEndpoint =
      '/mobile/common/attendance/qr-scan';
  static const String attendanceStatsEndpoint =
      '/mobile/common/attendance/stats';
  static const String scheduleTodayEndpoint = '/mobile/common/schedule/today';
  static const String scheduleWeekEndpoint = '/mobile/common/schedule/week';
  static const String scheduleMonthEndpoint = '/mobile/common/schedule/month';
  static const String scheduleUpcomingEndpoint =
      '/mobile/common/schedule/upcoming';
  static const String notificationsEndpoint = '/mobile/common/notifications';
  static const String settingsEndpoint = '/mobile/common/settings';

  // QR Code endpoints
  static const String qrGenerateEndpoint = '/mobile/qr/generate';
  static const String qrScanEndpoint = '/mobile/qr/scan';
  static const String qrHistoryEndpoint = '/mobile/qr/history';

  // File upload endpoints
  static const String uploadProfilePictureEndpoint =
      '/mobile/upload/profile-picture';
  static const String uploadDocumentEndpoint = '/mobile/upload/document';

  // Request timeout duration (in seconds)
  static const int timeoutDuration = 30;
}
