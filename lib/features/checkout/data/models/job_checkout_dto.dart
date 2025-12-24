class JobCheckoutDto {
  final JobCheckoutAddressDto shippingAddress;
  final JobCheckoutAddressDto billingAddress;
  final String customerNotes;
  final String jobDescription;
  final String jobComment;
  final List<int> transferIds;
  final String shipViaCode;
  final String shippingInstructions;
  final String? requestedShipDate;
  final bool mustShipByDate;

  const JobCheckoutDto({
    required this.shippingAddress,
    required this.billingAddress,
    required this.customerNotes,
    required this.jobDescription,
    required this.jobComment,
    required this.transferIds,
    required this.shipViaCode,
    required this.shippingInstructions,
    required this.requestedShipDate,
    required this.mustShipByDate,
  });

  Map<String, dynamic> toJson() => {
    'shippingAddress': shippingAddress.toJson(),
    'billingAddress': billingAddress.toJson(),
    'customerNotes': customerNotes,
    'jobDescription': jobDescription,
    'jobComment': jobComment,
    'transferIds': transferIds,
    'shipViaCode': shipViaCode,
    'shippingInstructions': shippingInstructions,
    'requestedShipDate': requestedShipDate,
    'mustShipByDate': mustShipByDate,
  };
}

class JobCheckoutAddressDto {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  const JobCheckoutAddressDto({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });

  Map<String, dynamic> toJson() => {
    'addressLine1': addressLine1,
    'addressLine2': addressLine2,
    'city': city,
    'state': state,
    'country': country,
    'zipCode': zipCode,
  };
}
