class Order{

  final String orderId;
  final String customerName;
  final String pickupAddress;
  final String deliveryAddress;
  final String customerPhone;
  final String earning;
  final String estimatedTime;
  bool? accepted;

  Order({
    required this.orderId,
    required this.customerName,
    required this.pickupAddress,
    required this.deliveryAddress,
    required this.customerPhone,
    required this.earning,
    required this.estimatedTime,
    this.accepted = false,
  });


  factory Order.fromJson(Map<String,dynamic> json)
  {
    return Order(
      orderId: json['orderId'] as String,
      customerName: json['customerName'] as String,
      pickupAddress: json['pickupAddress'] as String,
      deliveryAddress: json['deliveryAddress'] as String,
      customerPhone: json['customerPhone'] as String,
      earning: json['earning'] as String,
      estimatedTime: json['estimatedTime'],
    );
  }

}