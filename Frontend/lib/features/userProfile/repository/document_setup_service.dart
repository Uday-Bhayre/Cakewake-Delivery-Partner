import 'package:cakewake_delivery/core/services/api_service.dart';
import 'package:cakewake_delivery/features/userProfile/model/response_modal.dart';
import 'package:dio/dio.dart';

class DocumentSetupService{
  final ApiService _apiService;
  DocumentSetupService(this._apiService);

  Future<ResponseModal> submit(FormData formdata) async{
    try{
      final response= await _apiService.postItem(
        endpoint: '/auth/documents-upload', data: formdata,isFormdata: true);
      return ResponseModal.fromJson(response.data);
    }
    catch(e)
    {
      rethrow;
    } 

  }
}

