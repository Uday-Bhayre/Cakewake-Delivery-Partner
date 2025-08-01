import 'package:image_picker/image_picker.dart';

class Profile{
  final String name;
  final String email;
  final String contact;
  final String workArea;
  final String workCity;
   XFile? profileImage;
  final String vehicleType;
  final String vehicleColor;
  final String manufacturingYear; 
  final String vehicleNumber;
  final String accountNumber;
  final String bankName;
  final String ifscCode;
  final String accountHolderName;

  Profile({
    required this.name,
    required this.email,
    required this.contact,
    required this.workArea,
    required this.workCity,
    required this.profileImage,
    required this.vehicleType,
    required this.vehicleColor,
    required this.manufacturingYear,
    required this.vehicleNumber,
    required this.accountNumber,
    required this.bankName,
    required this.ifscCode,
    required this.accountHolderName,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      email: json['email'],
      contact: json['contact'],
      workArea: json['workArea'],
      workCity: json['workCity'],
      profileImage: XFile(json['profileImage']),
      vehicleType: json['vehicleType'],
      vehicleColor: json['vehicleColor'],
      manufacturingYear: json['manufacturingYear'],
      vehicleNumber: json['vehicleNumber'],
      accountNumber: json['accountNumber'],
      bankName: json['bankName'],
      ifscCode: json['ifscCode'],
      accountHolderName: json['accountHolderName'],
    );
  }
}