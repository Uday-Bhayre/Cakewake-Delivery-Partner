
class ResponseModal{
   bool? success;
   String? message;

   ResponseModal({
    this.success,
    this.message,
  });


  factory ResponseModal.fromJson(Map<String, dynamic> json) {
    return ResponseModal(
      success: json['success'],
      message: json['message'],
    );
  }
}