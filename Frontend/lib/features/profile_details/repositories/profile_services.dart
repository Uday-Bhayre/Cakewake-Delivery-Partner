import 'package:cakewake_delivery/core/services/api_service.dart';
import 'package:cakewake_delivery/features/authentication/model/response.dart';
import 'package:dio/dio.dart' as dio;

class ProfileServices {

  final ApiService _apiService;
  ProfileServices(this._apiService);

  Future<ResponseModel> submitProfile(dio.FormData profileData) async {
    try {
      final response = await _apiService.postItem(
        endpoint: '/profile',
        data: profileData,
        isFormdata: true,
      );
      return ResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to submit profile: $e');
    }
  }
}
