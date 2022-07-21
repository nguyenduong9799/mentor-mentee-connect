import 'package:dio/dio.dart';
import 'package:mentor_mentee_connecting/Model/DAO/BaseDAO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/CourseDTO.dart';
import 'package:mentor_mentee_connecting/Model/DTO/MetaDataDTO.dart';
import 'package:mentor_mentee_connecting/Utils/request.dart';

class CourseDAO extends BaseDAO {
  Future<List<CourseDTO>> getAllCourses({
    int page = 1,
    int size = 50,
    int? total,
    Map<String, dynamic> params = const {},
  }) async {
    Response res;
    res = await request.get(
      'courses',
      queryParameters: {"page": page, "size": size}..addAll(params),
    );
    final courses = CourseDTO.fromList(res.data["data"]);
    metaDataDTO = MetaDataDTO.fromJson(res.data["metadata"]);
    return courses;
  }

  Future<CourseDTO> getCourseById(
    int courseId, {
    int page = 1,
    int size = 50,
    int? total,
    Map<String, dynamic> params = const {},
  }) async {
    Response res;
    res = await request.get(
      'courses/$courseId',
      queryParameters: {"page": page, "size": size}..addAll(params),
    );
    final course = CourseDTO.fromJson(res.data);
    return course;
  }

  Future<List<CourseDTO>> getCoursesBySubjectId(
    int subjectId, {
    int page = 1,
    int size = 50,
    int? total,
    Map<String, dynamic> params = const {},
  }) async {
    Response res;
    res = await request.get(
      'subjects/$subjectId',
      queryParameters: {"page": page, "size": size}..addAll(params),
    );
    final courses = CourseDTO.fromList(res.data["data"]);
    metaDataDTO = MetaDataDTO.fromJson(res.data["metadata"]);
    return courses;
  }

  Future<CourseDTO> updateCourse(CourseDTO updateCourse) async {
    var dataJson = updateCourse.toJson();
    Response res = await request.put("courses", data: dataJson);
    return CourseDTO.fromJson(res.data);
  }
}
