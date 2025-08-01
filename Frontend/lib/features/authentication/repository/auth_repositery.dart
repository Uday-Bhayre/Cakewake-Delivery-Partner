import 'package:cakewake_delivery/core/services/api_service.dart';
import 'package:cakewake_delivery/features/authentication/model/response.dart';

class AuthRepository {
  final ApiService _apiService;

  AuthRepository(this._apiService);

  Future<ResponseModel> sendOtp(String phone) async {
    try {
      final response = await _apiService.postItem(
        endpoint: '/auth/send-otp',
        data: {'mobileNumber': phone},
      );
      return ResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseModel> verifyOtp(String phone, String otp) async {
    try {
      final response = await _apiService.postItem(
        endpoint: '/auth/verify-otp',
        data: {'mobileNumber': phone, 'otp': otp},
      );
      return ResponseModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
