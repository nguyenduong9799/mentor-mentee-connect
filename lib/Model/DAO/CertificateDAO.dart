import 'package:dio/dio.dart';
import 'package:mentor_mentee_connecting/Model/DAO/BaseDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CertificateDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MetaDataDTO.dart';
import 'package:mentor_mentee_connecting/Utils/request.dart';

class CertificateDAO extends BaseDAO {
  Future<List<CertificateDTO>> getAllCertificates({
    int page = 1,
    int size = 50,
    int? total,
    Map<String, dynamic> params = const {},
  }) async {
    Response res;
    res = await request.get(
      'certificates',
      queryParameters: {"page": page, "size": size}..addAll(params),
    );
    final majors = CertificateDTO.fromList(res.data["data"]);
    metaDataDTO = MetaDataDTO.fromJson(res.data["metadata"]);
    return majors;
  }
}
