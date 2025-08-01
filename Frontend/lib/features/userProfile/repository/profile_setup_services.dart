import 'package:cakewake_delivery/core/services/api_service.dart';
import 'package:cakewake_delivery/features/userProfile/model/profile_setup.dart';
import 'package:cakewake_delivery/features/userProfile/model/response_modal.dart';
import 'package:logger/logger.dart';

class ProfileSetupServices {
  
 final ApiService _apiservice;

   ProfileSetupServices(this._apiservice);

 Future<ResponseModal> submitProfile(ProfileSetup profileSetup) async {
  try{
    final response = await _apiservice.postItem(endpoint: '/auth/profile-setup', 
   data: profileSetup.toJson(),isFormdata: false);
  Logger().i('Profile setup response: ${response.data}');
   return ResponseModal.fromJson(response.data);

  }
  catch (e) {
    rethrow;
  }
 }

 static final List<String> banks = [
  'State Bank of India',
  'Punjab National Bank',
  'Bank of Baroda',
  'Canara Bank',
  'Union Bank of India',
  'Bank of India',
  'Indian Bank',
  'Central Bank of India',
  'Indian Overseas Bank',
  'UCO Bank',
  'Bank of Maharashtra',
  'Punjab & Sind Bank',
  'HDFC Bank',
  'ICICI Bank',
  'Axis Bank',
  'Kotak Mahindra Bank',
  'IndusInd Bank',
  'Yes Bank',
  'IDFC FIRST Bank',
  'Federal Bank',
  'South Indian Bank',
  'RBL Bank',
  'Bandhan Bank',
  'IDBI Bank',
  'Karur Vysya Bank',
  'City Union Bank',
  'DCB Bank',
  'Jammu & Kashmir Bank',
  'Tamilnad Mercantile Bank',
  'AU Small Finance Bank',
];
}