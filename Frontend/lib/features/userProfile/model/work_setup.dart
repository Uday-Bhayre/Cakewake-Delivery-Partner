import 'package:image_picker/image_picker.dart';

class WorkSetup {
  
  final String workCity;
  final String workArea;
  final  String vehicleType;
  final String  vehicleColor;
  final String manufacturingYear;
  final String vehicleNumber;
  final XFile? rcImage;
  final XFile? insuranceImg;
  final String workTimings;



  const WorkSetup({
    required this.workCity,
    required this.workArea,
    required this.vehicleType,
    required this.vehicleColor,
    required this.manufacturingYear,
    required this.vehicleNumber,
    required this.workTimings,
    required this.rcImage,
    required this.insuranceImg,
  });

  Map<String, dynamic> toJson() {
    return {
      'workCity': workCity,
      'workArea': workArea,
      'vehicleType': vehicleType,
      'vehicleColor': vehicleColor,
      'manufacturingYear': manufacturingYear,
      'vehicleNumber': vehicleNumber,
       'rcImage': rcImage?.path,
      'insuranceImg': insuranceImg?.path,
      'workTimings': workTimings,
    };
  }
}