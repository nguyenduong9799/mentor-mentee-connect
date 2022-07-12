import 'package:dio/dio.dart';
import 'package:mentor_mentee_connecting/Model/DAO/BaseDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MetaDataDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/SessionDTO.dart';
import 'package:mentor_mentee_connecting/Utils/request.dart';

class SessionDAO extends BaseDAO {
  Future<List<SessionDTO>> getAllSession({
    int page = 1,
    int size = 50,
    int? total,
    Map<String, dynamic> params = const {},
  }) async {
    Response res;
    res = await request.get(
      'sessions',
      queryParameters: {"page": page, "size": size}..addAll(params),
    );
    final sessions = SessionDTO.fromList(res.data["data"]);
    metaDataDTO = MetaDataDTO.fromJson(res.data["metadata"]);
    return sessions;
  }

  Future<List<SessionDTO>> getSessionsByCourseId(
    int courseId, {
    int page = 1,
    int size = 50,
    int? total,
    Map<String, dynamic> params = const {},
  }) async {
    Response res;
    res = await request.get(
      'sessions/$courseId',
      queryParameters: {"page": page, "size": size}..addAll(params),
    );
    final sessions = SessionDTO.fromList(res.data["data"]);
    metaDataDTO = MetaDataDTO.fromJson(res.data["metadata"]);
    return sessions;
  }

  Future<List<SessionDTO>> getTodaySessionsByDate({
    int page = 1,
    int size = 50,
    int? total,
    DateTime? dateTime,
    Map<String, dynamic> params = const {},
  }) async {
    Response res;
    res = await request.get(
      'sessions/by-date',
      queryParameters: {
        "page": page,
        "size": size,
        "in-date": dateTime.toString().replaceAll(' ', 'T')
      }..addAll(params),
    );
    final sessions = SessionDTO.fromList(res.data["data"]);
    metaDataDTO = MetaDataDTO.fromJson(res.data["metadata"]);
    return sessions;
  }
}
