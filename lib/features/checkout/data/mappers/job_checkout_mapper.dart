import 'package:apo/features/checkout/data/models/job_checkout_dto.dart';
import 'package:apo/features/checkout/domain/models/job_checkout_parameters.dart';

extension JobCheckoutParametersMapper on JobCheckoutParameters {
  JobCheckoutDto toDto() {
    return JobCheckoutDto(
      customerId: customerId,
      isApolloProducts: isApolloProducts,
      shippingDetails: JobCheckoutShippingDetailsDto(
        shipViaCode: shippingDetails.shipViaCode,
        streetAddress: shippingDetails.streetAddress,
        aptBuildingSuite: shippingDetails.aptBuildingSuite,
        city: shippingDetails.city,
        state: shippingDetails.state,
        postalCode: shippingDetails.postalCode,
        country: shippingDetails.country,
        shippingInstructions: shippingDetails.shippingInstructions,
      ),
      jobDescription: jobDescription,
      jobComment: jobComment,
      additionalServiceIds: additionalServiceIds,
      customerNotes: customerNotes,
      orderDate: orderDate.toUtc().toIso8601String(),
      orderType: orderType,
      customerNumber: customerNumber,
      customerPO: customerPO,
      isBillingSameAsShipping: isBillingSameAsShipping,
    );
  }
}
