class Endpoints {
  Endpoints._();

  // base url.  https://noaparaideal.site/api/dairi-list
  static const String baseUrl = "https://noaparaideal.site/api/";

  static String? apiUrl = "noaparaideal.site";
  static String? apiEndPoint = "/api/";

  // receiveTimeout
  static const int receiveTimeout = 15000;
  //imagePath base url
  static const String baseImageUrl = "https://noaparaideal.site/";

  // connectTimeout
  static const int connectionTimeout = 30000;
  static const String noticeList = baseUrl + "notice-list/";
  static const String magazineList = baseUrl + "magazine-list/";
  static const String eventList = baseUrl + "event-list";
  static const String holidayList = baseUrl + "holiday-list";
  static const String studentProfile = baseUrl + "student-profile";
  static const String examList = baseUrl + "exam-list";
  static const String siteMessageList = baseUrl + "all-site-messages";
  static const String subjectList = baseUrl + "subject-list";
  static const String attendanceList = baseUrl + "attendance-list";
  static const String studentLogin = baseUrl + "student-logins";
  static const String admission = baseUrl + "site/admission";
  static const String addDiary = "dairi";
  static const String diaryList = "dairi-list";
  static const String provideFeedback = "feedback";
  static const String feedbackList = "feedback-list";
  static const String classList = "class-list";
  static const String routineList = "routine-list";
  static const String contactList = "contact-list";
  static const String teacherLogin =
      "https://new.maphsctg.edu.bd/api/teacher/login";
}
