import 'package:image_picker/image_picker.dart';

class DocumentSetup{
  XFile? img;
  String? aadhaarNumber;
  String? panNumber;

  DocumentSetup({
    this.img,
    this.aadhaarNumber,
    this.panNumber,
  });

  factory DocumentSetup.fromJson(Map<String, dynamic> json) {
    return DocumentSetup(
      img: json['img'],
      aadhaarNumber: json['aadhaarNumber'],
      panNumber: json['panNumber'],
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'img': img,
      'aadhaarNumber': aadhaarNumber,
      'panNumber': panNumber,
    };
  }
}