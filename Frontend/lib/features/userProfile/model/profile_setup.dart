class ProfileSetup{
  final String name;
  final String email;
  final String gender;
  final String accountHolderName;
  final String accountNo;
  final String bankName;
  final String ifsc;

  ProfileSetup({
    required this.name,
    required this.email,
    required this.gender,
    required this.accountHolderName,
    required this.accountNo,
    required this.bankName,
    required this.ifsc,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'gender': gender,
      'name_of_account_holder': accountHolderName,
      'bank_account_number': accountNo,
      'bank_name': bankName,
      'ifsc': ifsc,
    };
  }
}