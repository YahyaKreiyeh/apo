class JobCheckoutParameters {
  final int customerId;
  final bool isApolloProducts;
  final JobCheckoutShippingDetailsParameters shippingDetails;
  final String jobDescription;
  final String jobComment;
  final List<int> additionalServiceIds;
  final String customerNotes;
  final DateTime orderDate;
  final String orderType;
  final String customerNumber;
  final String customerPO;
  final bool isBillingSameAsShipping;

  const JobCheckoutParameters({
    required this.customerId,
    required this.isApolloProducts,
    required this.shippingDetails,
    required this.jobDescription,
    required this.jobComment,
    required this.additionalServiceIds,
    required this.customerNotes,
    required this.orderDate,
    required this.orderType,
    required this.customerNumber,
    required this.customerPO,
    required this.isBillingSameAsShipping,
  });
}

class JobCheckoutShippingDetailsParameters {
  final String shipViaCode;
  final String streetAddress;
  final String aptBuildingSuite;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String shippingInstructions;

  const JobCheckoutShippingDetailsParameters({
    required this.shipViaCode,
    required this.streetAddress,
    required this.aptBuildingSuite,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.shippingInstructions,
  });
}
