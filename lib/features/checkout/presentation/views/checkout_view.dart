import 'dart:async';

import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/themes/color_scheme.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:apo/core/utilities/validators.dart';
import 'package:apo/core/widgets/app_toast.dart';
import 'package:apo/features/checkout/checkout_type.dart';
import 'package:apo/features/checkout/domain/models/job_checkout_parameters.dart';
import 'package:apo/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:apo/features/checkout/presentation/cubits/checkout_state.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/home/presentation/cubits/cart_cubit.dart';
import 'package:apo/features/home/presentation/cubits/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _formKey = GlobalKey<FormState>();
  DateTime? _orderDate;
  String? _selectedOrderType;
  String? _selectedJobType;
  String? _selectedLocation;
  String _sageOrderNo = '';
  String _customerPO = '';
  String _customerNo = '';
  String _shippingCountry = '';
  bool _isBillingSameAsShipping = false;
  final Set<int> _selectedAdditionalServiceIds = <int>{};

  static const List<String> _orderTypeOptions = <String>[
    'Standard',
    'Rush',
    'Custom',
    'Bulk',
  ];
  static const List<String> _jobTypeOptions = <String>[
    'Standard',
    'Inter Branch',
  ];
  static const List<String> _locationOptions = <String>[
    'California',
    'New Jersey',
    'Illinois',
    'Texas',
  ];
  static const List<_AdditionalServiceOption> _additionalServiceOptions =
      <_AdditionalServiceOption>[
        _AdditionalServiceOption(id: 109, label: 'Poly Bag'),
        _AdditionalServiceOption(id: 110, label: 'Size Stickers'),
        _AdditionalServiceOption(id: 111, label: 'Card Insert'),
        _AdditionalServiceOption(id: 112, label: 'Tagging'),
        _AdditionalServiceOption(id: 113, label: 'Solvy/Steam'),
        _AdditionalServiceOption(id: 114, label: 'Open Zipper'),
        _AdditionalServiceOption(id: 115, label: 'Drop Ship'),
        _AdditionalServiceOption(id: 116, label: 'Remove Label'),
        _AdditionalServiceOption(id: 117, label: 'Trim Backing of Logo'),
      ];

  void _updateShippingAddress({
    required QuoteFormController controller,
    String? line1,
    String? line2,
    String? city,
    String? region,
    String? zip,
  }) {
    controller.updateShippingAddress(
      line1: line1,
      line2: line2,
      city: city,
      region: region,
      zip: zip,
    );
    if (!_isBillingSameAsShipping) return;
    controller.updateBillingAddress(
      line1: line1,
      line2: line2,
      city: city,
      region: region,
      zip: zip,
    );
  }

  Future<void> _pickShipDate(
    ValueChanged<DateTime?> onDateSelected,
    DateTime? current,
  ) async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: current ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 3),
    );
    if (selected == null) return;
    onDateSelected(selected);
  }

  Future<void> _pickOrderDate() async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: _orderDate ?? now,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 10),
    );
    if (selected == null || !mounted) return;
    setState(() => _orderDate = selected);
  }

  Future<void> _submit(QuoteFormController controller) async {
    if (!_formKey.currentState!.validate()) return;
    final state = context.read<CheckoutCubit>().state;
    JobCheckoutParameters? checkoutParameters;
    if (state.type == CheckoutType.checkout) {
      final additionalServiceIds = _selectedAdditionalServiceIds.toList()
        ..sort();
      checkoutParameters = JobCheckoutParameters(
        customerId: int.tryParse(_customerNo.trim()) ?? 12,
        isApolloProducts: true,
        shippingDetails: JobCheckoutShippingDetailsParameters(
          shipViaCode: state.selectedShipViaCode?.trim() ?? '',
          streetAddress: state.shipLine1.trim(),
          aptBuildingSuite: state.shipLine2.trim(),
          city: state.shipCity.trim(),
          state: state.shipState.trim(),
          postalCode: state.shipZip.trim(),
          country: _shippingCountry.trim(),
          shippingInstructions: state.shippingInstructions.trim(),
        ),
        jobDescription: state.jobDescription.trim(),
        jobComment: state.jobComment.trim(),
        additionalServiceIds: additionalServiceIds,
        customerNotes: state.customerNotes.trim(),
        orderDate: (_orderDate ?? DateTime.now()).toUtc(),
        orderType: (_selectedOrderType ?? '').trim().toLowerCase(),
        customerNumber: _customerNo.trim(),
        customerPO: _customerPO.trim(),
        isBillingSameAsShipping: _isBillingSameAsShipping,
      );
    }
    await controller.submit(
      items: context.read<CartCubit>().state.items,
      checkoutParameters: checkoutParameters,
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.month.toString().padLeft(2, '0')}/'
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  void _handleStatus(BuildContext context, CheckoutState state) {
    if (state.status.isSuccess) {
      final isAuthenticated = context
          .read<ProfileCubit>()
          .state
          .isAuthenticated;
      if (isAuthenticated) {
        unawaited(context.read<CartCubit>().loadCart());
      } else if (state.type == CheckoutType.requestQuote) {
        unawaited(context.read<CartCubit>().clearCart());
      } else {
        context.read<CartCubit>().clear();
      }
      AppToast.show(
        message: state.type.successMessage,
        type: AppToastType.success,
      );
      Navigator.of(context).pop();
    } else if (state.status.isFailure) {
      AppToast.show(message: state.type.failureMessage);
    }
  }

  Widget _buildForm(
    BuildContext context,
    CheckoutState state,
    QuoteFormController controller,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSubmitting = state.status.isLoading;
    final cubit = context.read<CheckoutCubit>();
    final type = state.type;
    return Scaffold(
      appBar: AppBar(title: Text(type.title)),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.all(Constants.defaultPadding),
        child: ElevatedButton(
          onPressed: isSubmitting ? () {} : () => _submit(controller),
          child: isSubmitting
              ? CircularProgressIndicator()
              : Text(type.submitLabel, textAlign: TextAlign.center),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(Constants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                type.subtitle,
                style: TextStyles.text14400.copyWith(
                  color: colorScheme.secondaryText,
                ),
              ),
              VerticalSpace(20),
              if (type != CheckoutType.checkout) ...[
                _SectionTitle(title: AppStrings.contactInformation),
                VerticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: _LabeledField(
                        label: AppStrings.firstName,
                        hintText: AppStrings.firstNameHint,
                        initialValue: state.firstName,
                        onChanged: (value) =>
                            controller.updateContact(firstName: value),
                        validator: Validators.required,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    HorizontalSpace(12),
                    Expanded(
                      child: _LabeledField(
                        label: AppStrings.lastName,
                        hintText: AppStrings.lastNameHint,
                        initialValue: state.lastName,
                        onChanged: (value) =>
                            controller.updateContact(lastName: value),
                        validator: Validators.required,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                VerticalSpace(12),
                _LabeledField(
                  label: AppStrings.email,
                  hintText: AppStrings.emailHint,
                  initialValue: state.email,
                  onChanged: (value) => controller.updateContact(email: value),
                  validator: (value) => Validators.email(value ?? ''),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                VerticalSpace(12),
                _LabeledField(
                  label: AppStrings.phone,
                  hintText: AppStrings.phoneHint,
                  initialValue: state.phone,
                  onChanged: (value) => controller.updateContact(phone: value),
                  validator: Validators.required,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                ),
                VerticalSpace(12),
                _LabeledField(
                  label: AppStrings.companyName,
                  hintText: AppStrings.companyNameHint,
                  initialValue: state.companyName,
                  onChanged: (value) =>
                      controller.updateContact(companyName: value),
                  textInputAction: TextInputAction.next,
                ),
                VerticalSpace(20),
                _SectionTitle(title: AppStrings.shippingAddress),
                VerticalSpace(12),
                _LabeledField(
                  label: AppStrings.addressLine1,
                  hintText: AppStrings.addressLine1Hint,
                  initialValue: state.shipLine1,
                  onChanged: (value) =>
                      controller.updateShippingAddress(line1: value),
                  validator: Validators.required,
                  textInputAction: TextInputAction.next,
                ),
                VerticalSpace(12),
                _LabeledField(
                  label: AppStrings.addressLine2Optional,
                  hintText: AppStrings.addressLine2Hint,
                  initialValue: state.shipLine2,
                  onChanged: (value) =>
                      controller.updateShippingAddress(line2: value),
                  textInputAction: TextInputAction.next,
                ),
                VerticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: _LabeledField(
                        label: AppStrings.city,
                        hintText: AppStrings.cityHint,
                        initialValue: state.shipCity,
                        onChanged: (value) =>
                            controller.updateShippingAddress(city: value),
                        validator: Validators.required,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    HorizontalSpace(12),
                    Expanded(
                      child: _LabeledField(
                        label: AppStrings.state,
                        hintText: AppStrings.stateHint,
                        initialValue: state.shipState,
                        onChanged: (value) =>
                            controller.updateShippingAddress(region: value),
                        validator: Validators.required,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    HorizontalSpace(12),
                    Expanded(
                      child: _LabeledField(
                        label: AppStrings.zipCode,
                        hintText: AppStrings.zipCodeHint,
                        initialValue: state.shipZip,
                        onChanged: (value) =>
                            controller.updateShippingAddress(zip: value),
                        validator: Validators.required,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                VerticalSpace(12),

                VerticalSpace(20),
                _SectionTitle(title: AppStrings.billingAddress),
                VerticalSpace(12),
                _LabeledField(
                  label: AppStrings.addressLine1,
                  hintText: AppStrings.addressLine1Hint,
                  initialValue: state.billLine1,
                  onChanged: (value) =>
                      controller.updateBillingAddress(line1: value),
                  validator: Validators.required,
                  textInputAction: TextInputAction.next,
                ),
                VerticalSpace(12),
                _LabeledField(
                  label: AppStrings.addressLine2Optional,
                  hintText: AppStrings.addressLine2Hint,
                  initialValue: state.billLine2,
                  onChanged: (value) =>
                      controller.updateBillingAddress(line2: value),
                  textInputAction: TextInputAction.next,
                ),
                VerticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: _LabeledField(
                        label: AppStrings.city,
                        hintText: AppStrings.cityHint,
                        initialValue: state.billCity,
                        onChanged: (value) =>
                            controller.updateBillingAddress(city: value),
                        validator: Validators.required,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    HorizontalSpace(12),
                    Expanded(
                      child: _LabeledField(
                        label: AppStrings.state,
                        hintText: AppStrings.stateHint,
                        initialValue: state.billState,
                        onChanged: (value) =>
                            controller.updateBillingAddress(region: value),
                        validator: Validators.required,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    HorizontalSpace(12),
                    Expanded(
                      child: _LabeledField(
                        label: AppStrings.zipCode,
                        hintText: AppStrings.zipCodeHint,
                        initialValue: state.billZip,
                        onChanged: (value) =>
                            controller.updateBillingAddress(zip: value),
                        validator: Validators.required,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                VerticalSpace(12),

                VerticalSpace(20),
                _SectionTitle(title: AppStrings.orderDetails),
                VerticalSpace(12),
                _LabeledField(
                  label: AppStrings.additionalNotesOptional,
                  hintText: AppStrings.additionalNotesHint,
                  initialValue: state.customerNotes,
                  onChanged: (value) =>
                      controller.updateOrderDetails(notes: value),
                  maxLines: 3,
                  textInputAction: TextInputAction.newline,
                ),
                VerticalSpace(12),
                _LabeledField(
                  label: AppStrings.artworkDescription,
                  hintText: AppStrings.artworkDescriptionHint,
                  initialValue: state.artworkDescription,
                  onChanged: (value) =>
                      controller.updateOrderDetails(artworkDescription: value),
                  maxLines: 2,
                  textInputAction: TextInputAction.newline,
                ),
                VerticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: _LabeledField(
                        label: AppStrings.numberOfEmbroideryLocations,
                        hintText: AppStrings.embroideryLocationsHint,
                        initialValue: state.numberOfLocations,
                        onChanged: (value) => controller.updateOrderDetails(
                          numberOfLocations: value,
                        ),
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    HorizontalSpace(12),
                    Expanded(
                      child: _LabeledField(
                        key: ValueKey(
                          state.desiredShipDate?.toIso8601String() ?? '',
                        ),
                        label: AppStrings.desiredShipDate,
                        hintText: AppStrings.desiredShipDateHint,
                        initialValue: _formatDate(state.desiredShipDate),
                        readOnly: true,
                        onTap: () => _pickShipDate(
                          controller.setDesiredShipDate,
                          state.desiredShipDate,
                        ),
                        suffixIcon: const Icon(Icons.calendar_today_outlined),
                      ),
                    ),
                  ],
                ),
              ] else ...[
                _SectionTitle(title: 'Order Information'),
                VerticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: _LabeledField(
                        key: ValueKey(_orderDate?.toIso8601String() ?? ''),
                        label: 'Order Date',
                        hintText: 'Select order date',
                        initialValue: _formatDate(_orderDate),
                        readOnly: true,
                        onTap: _pickOrderDate,
                        suffixIcon: const Icon(Icons.calendar_today_outlined),
                      ),
                    ),
                    HorizontalSpace(12),
                    Expanded(
                      child: _LabeledDropdown<String>(
                        label: 'Order Type',
                        hintText: 'Select order type',
                        value: _selectedOrderType,
                        items: _orderTypeOptions
                            .map(
                              (option) => DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedOrderType = value),
                      ),
                    ),
                  ],
                ),
                VerticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: _LabeledField(
                        label: 'Sage Order No',
                        hintText: 'Enter sage order number',
                        initialValue: _sageOrderNo,
                        onChanged: (value) => _sageOrderNo = value,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    HorizontalSpace(12),
                    Expanded(
                      child: _LabeledField(
                        label: 'Customer PO',
                        hintText: 'Enter customer PO',
                        initialValue: _customerPO,
                        onChanged: (value) => _customerPO = value,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                VerticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: _LabeledField(
                        label: 'Customer No',
                        hintText: 'Enter customer number',
                        initialValue: _customerNo,
                        onChanged: (value) => _customerNo = value,
                        validator: Validators.required,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    HorizontalSpace(12),
                    Expanded(
                      child: _LabeledDropdown<String>(
                        label: 'Job Type',
                        hintText: 'Select job type',
                        value: _selectedJobType,
                        items: _jobTypeOptions
                            .map(
                              (option) => DropdownMenuItem<String>(
                                value: option,
                                child: Text(option),
                              ),
                            )
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedJobType = value),
                      ),
                    ),
                  ],
                ),
                VerticalSpace(12),
                _LabeledDropdown<String>(
                  label: 'Location',
                  hintText: 'Select location',
                  value: _selectedLocation,
                  items: _locationOptions
                      .map(
                        (option) => DropdownMenuItem<String>(
                          value: option,
                          child: Text(option),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedLocation = value),
                ),
                VerticalSpace(20),
                _SectionTitle(title: 'Job Description'),
                VerticalSpace(12),
                _LabeledField(
                  label: 'Job Description',
                  hintText: 'Enter job description',
                  initialValue: state.jobDescription,
                  maxLines: 2,
                  textInputAction: TextInputAction.newline,
                  onChanged: (value) =>
                      cubit.updateJobInformation(description: value),
                ),
                VerticalSpace(20),
                _SectionTitle(title: 'Customer Notes'),
                VerticalSpace(12),
                _LabeledField(
                  label: 'Customer Notes',
                  hintText: 'Enter customer notes',
                  initialValue: state.customerNotes,
                  maxLines: 2,
                  textInputAction: TextInputAction.newline,
                  onChanged: (value) =>
                      controller.updateOrderDetails(notes: value),
                ),
                VerticalSpace(20),
                _SectionTitle(title: 'Shipping Details'),
                VerticalSpace(12),
                _LabeledField(
                  label: 'Street Address',
                  hintText: 'Enter street address',
                  initialValue: state.shipLine1,
                  onChanged: (value) => _updateShippingAddress(
                    controller: controller,
                    line1: value,
                  ),
                  validator: Validators.required,
                  textInputAction: TextInputAction.next,
                ),
                VerticalSpace(12),
                _LabeledField(
                  label: 'Apt/Suite',
                  hintText: 'Enter apt/suite',
                  initialValue: state.shipLine2,
                  onChanged: (value) => _updateShippingAddress(
                    controller: controller,
                    line2: value,
                  ),
                  textInputAction: TextInputAction.next,
                ),
                VerticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: _LabeledField(
                        label: 'City',
                        hintText: 'Enter city',
                        initialValue: state.shipCity,
                        onChanged: (value) => _updateShippingAddress(
                          controller: controller,
                          city: value,
                        ),
                        validator: Validators.required,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    HorizontalSpace(12),
                    Expanded(
                      child: _LabeledField(
                        label: 'State',
                        hintText: 'Enter state',
                        initialValue: state.shipState,
                        onChanged: (value) => _updateShippingAddress(
                          controller: controller,
                          region: value,
                        ),
                        validator: Validators.required,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                VerticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: _LabeledField(
                        label: 'Postal Code',
                        hintText: 'Enter postal code',
                        initialValue: state.shipZip,
                        onChanged: (value) => _updateShippingAddress(
                          controller: controller,
                          zip: value,
                        ),
                        validator: Validators.required,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    HorizontalSpace(12),
                    Expanded(
                      child: _LabeledField(
                        label: 'Country',
                        hintText: 'Enter country',
                        initialValue: _shippingCountry,
                        onChanged: (value) => _shippingCountry = value,
                        validator: Validators.required,
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                  ],
                ),
                VerticalSpace(12),
                _LabeledField(
                  label: 'Ship Via',
                  hintText: 'Enter ship via',
                  initialValue: state.selectedShipViaCode,
                  onChanged: (value) => cubit.selectShipViaOption(value),
                  textInputAction: TextInputAction.next,
                ),
                VerticalSpace(12),
                _LabeledField(
                  label: 'Shipping Instructions',
                  hintText: 'Enter shipping instructions',
                  initialValue: state.shippingInstructions,
                  maxLines: 2,
                  textInputAction: TextInputAction.newline,
                  onChanged: cubit.updateShippingInstructions,
                ),
                VerticalSpace(4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _isBillingSameAsShipping,
                      onChanged: (value) {
                        final isSame = value ?? false;
                        setState(() => _isBillingSameAsShipping = isSame);
                        if (!isSame) return;
                        controller.updateBillingAddress(
                          line1: state.shipLine1,
                          line2: state.shipLine2,
                          city: state.shipCity,
                          region: state.shipState,
                          zip: state.shipZip,
                        );
                      },
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 13),
                        child: Text(
                          'Billing address is the same as shipping address',
                          style: TextStyles.text14400.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                VerticalSpace(20),
                _SectionTitle(title: 'Additional Services'),
                VerticalSpace(8),
                ..._additionalServiceOptions.map((service) {
                  final isSelected = _selectedAdditionalServiceIds.contains(
                    service.id,
                  );
                  return CheckboxListTile(
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value ?? false) {
                          _selectedAdditionalServiceIds.add(service.id);
                        } else {
                          _selectedAdditionalServiceIds.remove(service.id);
                        }
                      });
                    },
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: Text(
                      service.label,
                      style: TextStyles.text14400.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }),
                // VerticalSpace(20),
                // _SectionTitle(title: 'Line Items'),
                // VerticalSpace(12),
                // Text(
                //   'Line items will be implemented later.',
                //   style: TextStyles.text14400.copyWith(
                //     color: colorScheme.secondaryText,
                //   ),
                // ),
              ],
              VerticalSpace(24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckoutCubit, CheckoutState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: _handleStatus,
      child: BlocBuilder<CheckoutCubit, CheckoutState>(
        builder: (context, state) {
          final cubit = context.read<CheckoutCubit>();
          final form = _buildForm(
            context,
            state,
            QuoteFormController(
              updateContact: cubit.updateContact,
              updateShippingAddress: cubit.updateShippingAddress,
              updateBillingAddress: cubit.updateBillingAddress,
              updateOrderDetails: cubit.updateOrderDetails,
              setDesiredShipDate: cubit.setDesiredShipDate,
              submit: cubit.submit,
            ),
          );
          return form;
        },
      ),
    );
  }
}

typedef ContactUpdater =
    void Function({
      String? firstName,
      String? lastName,
      String? email,
      String? phone,
      String? companyName,
    });

typedef AddressUpdater =
    void Function({
      String? line1,
      String? line2,
      String? city,
      String? region,
      String? zip,
    });

typedef OrderDetailsUpdater =
    void Function({
      String? notes,
      String? artworkDescription,
      String? numberOfLocations,
    });

typedef SubmitHandler =
    Future<void> Function({
      required List<CartItemEntity> items,
      JobCheckoutParameters? checkoutParameters,
    });

class QuoteFormController {
  QuoteFormController({
    required this.updateContact,
    required this.updateShippingAddress,
    required this.updateBillingAddress,
    required this.updateOrderDetails,
    required this.setDesiredShipDate,
    required this.submit,
  });

  final ContactUpdater updateContact;
  final AddressUpdater updateShippingAddress;
  final AddressUpdater updateBillingAddress;
  final OrderDetailsUpdater updateOrderDetails;
  final ValueChanged<DateTime?> setDesiredShipDate;
  final SubmitHandler submit;
}

class _AdditionalServiceOption {
  const _AdditionalServiceOption({required this.id, required this.label});

  final int id;
  final String label;
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyles.text20700.copyWith(fontWeight: FontWeight.w600),
    );
  }
}

class _LabeledField extends StatelessWidget {
  const _LabeledField({
    super.key,
    required this.label,
    required this.hintText,
    this.initialValue,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.maxLines = 1,
    this.readOnly = false,
    this.onTap,
    this.onChanged,
    this.suffixIcon,
  });

  final String label;
  final String hintText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final int maxLines;
  final bool readOnly;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.text14400.copyWith(fontWeight: FontWeight.w600),
        ),
        VerticalSpace(8),
        TextFormField(
          initialValue: initialValue,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.primary),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

class _LabeledDropdown<T> extends StatelessWidget {
  const _LabeledDropdown({
    required this.label,
    required this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String hintText;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyles.text14400.copyWith(fontWeight: FontWeight.w600),
        ),
        VerticalSpace(8),
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items,
          onChanged: onChanged,
          isExpanded: true,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: colorScheme.surfaceContainerHighest,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.outlineVariant),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: colorScheme.primary),
            ),
          ),
          icon: const Icon(Icons.expand_more),
        ),
      ],
    );
  }
}
