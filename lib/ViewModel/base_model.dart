import 'package:mentor_mentee_connecting/Constant/view_status.dart';
import 'package:scoped_model/scoped_model.dart';

class BaseModel extends Model {
  ViewStatus _status = ViewStatus.Completed;
  String? _msg;
  ViewStatus get status => _status;
  String? get msg => _msg;

  void setState(ViewStatus newState, [String? msg]) {
    _status = newState;
    _msg = msg;
    notifyListeners();
  }
}
