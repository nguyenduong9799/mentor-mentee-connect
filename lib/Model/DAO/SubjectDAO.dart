import 'package:dio/dio.dart';
import 'package:mentor_mentee_connecting/Model/DAO/BaseDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MetaDataDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/SubjectDTO.dart';
import 'package:mentor_mentee_connecting/Utils/request.dart';

class SubjectDAO extends BaseDAO {
  Future<List<SubjectDTO>> getAllSubjects({
    int page = 1,
    int size = 50,
    int? total,
    Map<String, dynamic> params = const {},
  }) async {
    Response res;
    res = await request.get(
      'subjects',
      queryParameters: {"page": page, "size": size}..addAll(params),
    );
    final subjects = SubjectDTO.fromList(res.data["data"]);
    metaDataDTO = MetaDataDTO.fromJson(res.data["metadata"]);
    return subjects;
  }
}
