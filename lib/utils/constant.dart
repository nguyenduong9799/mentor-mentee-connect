const int ANIMATED_BODY_MS = 500;
const phoneReg = r'^(0|\+)([0-9])+$';

class CourseStatus {
  static const int DRAFT = 1;
  static const int PENDING = 2;
  static const int WAITING = 3;
  static const int CANCEL_NOT_ENOUGH = 4;
  static const int START = 5;
  static const int END = 6;
}

class Badge {
  static const int Fresher = 1;
  static const int Junior = 2;
  static const int Senior = 3;
}

class CertificateStatus {
  static const int Pending = 1;
  static const int Approved = 2;
  static const int Denied = 3;
}
