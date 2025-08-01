class ResponseModel{
  final String? message;
  final bool? success;
  final DeliveryPartner? deliveryPartner;
  final String? token;
  final String? expiry;
 
  ResponseModel({
     this.message,
     this.success,
     this.deliveryPartner,
     this.token,
     this.expiry,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      message: json['message'] ?? '',
      success: json['success'] ?? false,
      deliveryPartner: json['delivery_partner'] != null
          ? DeliveryPartner.fromJson(json['delivery_partner'])
          : null,
      token: json['token'],
      expiry: json['token_expiry'],
    );
  }
}

class DeliveryPartner {
   String? mobileNumber;
   String? workSetupId;
   String? documentSetupId;
   String? profileSetupId;

   DeliveryPartner({
     this.mobileNumber,
     this.workSetupId,
     this.documentSetupId,
     this.profileSetupId,
   });

   factory DeliveryPartner.fromJson(Map<String, dynamic> json) {
     return DeliveryPartner(
       mobileNumber: json['mobileNumber'],
       workSetupId: json['work_setup'] ?? '',
       documentSetupId: json['documents'] ?? '',
       profileSetupId: json['profile_setup'] ?? '',
     );
   }
}