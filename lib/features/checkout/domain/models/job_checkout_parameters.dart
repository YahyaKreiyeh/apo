class JobCheckoutParameters {
  final JobCheckoutAddressParameters shippingAddress;
  final JobCheckoutAddressParameters billingAddress;
  final String customerNotes;
  final String jobDescription;
  final String jobComment;
  final List<int> transferIds;
  final String shipViaCode;
  final String shippingInstructions;
  final DateTime? requestedShipDate;
  final bool mustShipByDate;

  const JobCheckoutParameters({
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
}

class JobCheckoutAddressParameters {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final String state;
  final String country;
  final String zipCode;

  const JobCheckoutAddressParameters({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
  });
}
