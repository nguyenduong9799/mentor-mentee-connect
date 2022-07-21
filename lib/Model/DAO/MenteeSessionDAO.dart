import 'package:dio/dio.dart';
import 'package:mentor_mentee_connecting/Model/DAO/BaseDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MenteeSessionDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MetaDataDTO.dart';
import 'package:mentor_mentee_connecting/Utils/request.dart';

class MenteeSessionDAO extends BaseDAO {
  Future<List<MenteeSessionDTO>> getAllMenteeSessionById(
    int sessionId, {
    int page = 1,
    int size = 50,
    int? total,
    Map<String, dynamic> params = const {},
  }) async {
    Response res;
    res = await request.get(
      'sessions/detail/$sessionId',
      queryParameters: {"page": page, "size": size}..addAll(params),
    );
    final listMenteeSession = MenteeSessionDTO.fromList(res.data["data"]);
    metaDataDTO = MetaDataDTO.fromJson(res.data["metadata"]);
    return listMenteeSession;
  }

  Future<void> checkAttendant(int id) async {
    Response res = await request.put("sessions/update-attendance", data: [
      {"id": id, "isAttended": 1}
    ]);
  }
}
