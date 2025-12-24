import 'package:apo/features/checkout/data/models/job_checkout_dto.dart';
import 'package:apo/features/checkout/domain/models/job_checkout_parameters.dart';

extension JobCheckoutParametersMapper on JobCheckoutParameters {
  JobCheckoutDto toDto() {
    return JobCheckoutDto(
      shippingAddress: JobCheckoutAddressDto(
        addressLine1: shippingAddress.addressLine1,
        addressLine2: shippingAddress.addressLine2,
        city: shippingAddress.city,
        state: shippingAddress.state,
        country: shippingAddress.country,
        zipCode: shippingAddress.zipCode,
      ),
      billingAddress: JobCheckoutAddressDto(
        addressLine1: billingAddress.addressLine1,
        addressLine2: billingAddress.addressLine2,
        city: billingAddress.city,
        state: billingAddress.state,
        country: billingAddress.country,
        zipCode: billingAddress.zipCode,
      ),
      customerNotes: customerNotes,
      jobDescription: jobDescription,
      jobComment: jobComment,
      transferIds: transferIds,
      shipViaCode: shipViaCode,
      shippingInstructions: shippingInstructions,
      requestedShipDate: requestedShipDate?.toUtc().toIso8601String(),
      mustShipByDate: mustShipByDate,
    );
  }
}
