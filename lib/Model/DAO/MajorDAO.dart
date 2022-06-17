import 'package:dio/dio.dart';
import 'package:mentor_mentee_connecting/Model/DAO/BaseDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MajorDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MetaDataDTO.dart';
import 'package:mentor_mentee_connecting/Utils/request.dart';

class MajorDAO extends BaseDAO {
  Future<List<MajorDTO>> getAllMajors({
    int page = 1,
    int size = 50,
    int? total,
    Map<String, dynamic> params = const {},
  }) async {
    Response res;
    res = await request.get(
      'majors',
      queryParameters: {"page": page ?? 1, "size": size ?? 50}..addAll(params),
    );
    final majors = MajorDTO.fromList(res.data["data"]);
    metaDataDTO = MetaDataDTO.fromJson(res.data["metadata"]);
    return majors;
  }
}
