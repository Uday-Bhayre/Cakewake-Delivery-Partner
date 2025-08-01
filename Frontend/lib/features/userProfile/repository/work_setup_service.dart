import 'package:cakewake_delivery/core/services/api_service.dart';
import 'package:cakewake_delivery/features/userProfile/model/response_modal.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';

class WorkSetupService  {

   final ApiService _apiService;

  WorkSetupService(this._apiService);

 
  Future<List<Map<String, String>>> loadCitiesFromCSV() async{
  final data= await rootBundle.loadString('assets/city_dataset/worldcities.csv');
  //Parses the CSV string into a list of rows, where each row is a list of values.
   final List<List<dynamic>> rowsAsListOfValues= const CsvToListConverter().convert(data);

   final headers= rowsAsListOfValues.first.map((e) => e.toString()).toList();

  final cityList= rowsAsListOfValues.skip(1).map((row){
    return Map.fromIterables(headers,row.map((e)=> e.toString()));
  }).toList();
   cityList.sort((a, b) => a['city_ascii']!.compareTo(b['city_ascii']!));
  return cityList;
}


 Future<ResponseModal> submit(FormData formData) async {
    try {
       final response= await _apiService.postItem(endpoint: '/auth/work-setup', data: formData, isFormdata: true);
      return ResponseModal.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getCityAreas() async {
    // Simulating a network call to fetch city areas
    await Future.delayed(const Duration(seconds: 1));
    return cityAreas;
  }

final List<Map<String, dynamic>> cityAreas = [
  {
    "city": "Mumbai",
    "areas": ["Andheri", "Bandra", "Borivali", "Colaba", "Worli", "Juhu"]
  },
  {
    "city": "Delhi",
    "areas": ["Connaught Place", "Saket", "Dwarka", "Rohini", "South Delhi", "Lajpat Nagar"]
  },
  {
    "city": "Ahmedabad",
    "areas": ["Navrangpura", "Satellite", "Maninagar", "Vastrapur", "Prahlad Nagar", "Bopal"]
  },
  {
    "city": "Bangalore",
    "areas": ["Indiranagar", "Koramangala", "Whitefield", "Jayanagar", "Malleshwaram", "Electronic City"]
  },
  {
    "city": "Surat",
    "areas": ["Vesu", "Adajan", "Piplod", "Athwalines", "City Light", "Pal"]
  },
  {
    "city": "Vishakhapatnam",
    "areas": ["MVP Colony", "Seethammadhara", "Madhurawada", "Dwaraka Nagar", "Gajuwaka", "Rushikonda"]
  },
  {
    "city": "Vadodara",
    "areas": ["Alkapuri", "Akota", "Fatehgunj", "Gotri", "Vasna Road", "Sayajigunj"]
  },
  {
    "city": "Rajkot",
    "areas": ["Race Course Road", "Kalawad Road", "150 Feet Ring Road", "Yagnik Road", "University Road", "Gondal Road"]
  },
  {
    "city": "Vijayawada",
    "areas": ["Moghalrajpuram", "Benz Circle", "Auto Nagar", "Labbipet", "Governorpet", "Patamata"]
  },
  {
    "city": "Faridabad",
    "areas": ["Sector 15", "NIT Area", "Surajkund", "Green Field Colony", "Sector 21C", "Charmwood Village"]
  },
  {
    "city": "Bilaspur",
    "areas": ["Nehru Nagar", "Vyapar Vihar", "Sarkanda", "Telipara", "Mungeli Road", "Tifra"]
  },
  {
    "city": "Jamshedpur",
    "areas": ["Bistupur", "Sakchi", "Kadma", "Sonari", "Mango", "Telco Colony"]
  },
  {
    "city": "Patna",
    "areas": ["Kankarbagh", "Patliputra Colony", "Boring Road", "Fraser Road", "Rajendra Nagar", "Gandhi Maidan"]
  },
  {
    "city": "Srinagar",
    "areas": ["Lal Chowk", "Rajbagh", "Hazratbal", "Dal Lake Area", "Batmaloo", "Rawalpora"]
  },
  {
    "city": "Ranchi",
    "areas": ["Lalpur", "Kanke Road", "Morabadi", "Hinoo", "Doranda", "Ashok Nagar"]
  },
  {
    "city": "Najafgarh",
    "areas": ["Nangli Vihar", "Dichaon Kalan", "Mitraon", "Najafgarh Market", "Chhawla", "Paprawat"]
  },
  {
    "city": "Chennai",
    "areas": ["Adyar", "Anna Nagar", "Besant Nagar", "Kotturpuram", "T. Nagar", "Velachery"]
  },
  {
    "city": "Hyderabad",
    "areas": ["Banjara Hills", "Jubilee Hills", "Gachibowli", "Hitech City", "Kondapur", "Secunderabad"]
  },
  {
    "city": "Kolkata",
    "areas": ["Salt Lake City", "Park Street", "Ballygunge", "Howrah", "New Town", "Dum Dum"]
  },
  {
    "city": "Pune",
    "areas": ["Koregaon Park", "Kalyani Nagar", "Baner", "Viman Nagar", "Magarpatta City", "Hinjewadi"]
  },
  {
    "city": "Lucknow",
    "areas": ["Gomti Nagar", "Hazratganj", "Aliganj", "Indira Nagar", "Mahanagar", "Vikas Nagar"]
  },
  {
    "city": "Jaipur",
    "areas": ["C-Scheme", "Malviya Nagar", "Vaishali Nagar", "Mansarovar", "Tonk Road", "Jagatpura"]
  },
  {
    "city": "Kochi",
    "areas": ["Marine Drive", "Kakkanad", "Fort Kochi", "Edappally", "Palarivattom", "Vyttila"]
  },
  {
    "city": "Thiruvananthapuram",
    "areas": ["Pattom", "Kowdiar", "Vazhuthacaud", "Technopark Area", "Kesavadasapuram", "Karamana"]
  }
];
}
