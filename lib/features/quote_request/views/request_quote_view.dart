import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/themes/color_scheme.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:apo/core/utilities/validators.dart';
import 'package:apo/core/widgets/app_toast.dart';
import 'package:apo/features/home/presentation/cubits/cart_cubit.dart';
import 'package:apo/features/quote_request/presentation/cubits/quote_request_cubit.dart';
import 'package:apo/features/quote_request/presentation/cubits/quote_request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestQuoteView extends StatefulWidget {
  const RequestQuoteView({super.key});

  @override
  State<RequestQuoteView> createState() => _RequestQuoteViewState();
}

class _RequestQuoteViewState extends State<RequestQuoteView> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _pickShipDate(QuoteRequestCubit cubit, DateTime? current) async {
    final now = DateTime.now();
    final selected = await showDatePicker(
      context: context,
      initialDate: current ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 3),
    );
    if (selected == null) return;
    cubit.setDesiredShipDate(selected);
  }

  void _submit(QuoteRequestCubit cubit) {
    if (!_formKey.currentState!.validate()) return;
    cubit.submitQuoteRequest(items: context.read<CartCubit>().state.items);
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.month.toString().padLeft(2, '0')}/'
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuoteRequestCubit, QuoteRequestState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.read<CartCubit>().clear();
          AppToast.show(
            message: AppStrings.requestQuoteSuccess,
            type: AppToastType.success,
          );
          Navigator.of(context).pop();
        } else if (state.status.isFailure) {
          AppToast.show(message: AppStrings.requestQuoteFailed);
        }
      },
      child: BlocBuilder<QuoteRequestCubit, QuoteRequestState>(
        builder: (context, state) {
          final cubit = context.read<QuoteRequestCubit>();
          final colorScheme = Theme.of(context).colorScheme;
          final isSubmitting = state.status.isLoading;
          return Scaffold(
            appBar: AppBar(title: Text(AppStrings.requestCustomQuote)),
            bottomNavigationBar: SafeArea(
              minimum: const EdgeInsets.all(Constants.defaultPadding),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: isSubmitting
                          ? null
                          : () => Navigator.pop(context),
                      child: Text(AppStrings.cancel),
                    ),
                  ),
                  HorizontalSpace(12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: isSubmitting ? () {} : () => _submit(cubit),
                      child: isSubmitting
                          ? CircularProgressIndicator()
                          : Text(
                              AppStrings.submitQuoteRequest,
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                ],
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
                      AppStrings.requestQuoteSubtitle,
                      style: TextStyles.text14400.copyWith(
                        color: colorScheme.secondaryText,
                      ),
                    ),
                    VerticalSpace(20),
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
                                cubit.updateContact(firstName: value),
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
                                cubit.updateContact(lastName: value),
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
                      onChanged: (value) => cubit.updateContact(email: value),
                      validator: (value) => Validators.email(value ?? ''),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    VerticalSpace(12),
                    _LabeledField(
                      label: AppStrings.phone,
                      hintText: AppStrings.phoneHint,
                      initialValue: state.phone,
                      onChanged: (value) => cubit.updateContact(phone: value),
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
                          cubit.updateContact(companyName: value),
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
                          cubit.updateShippingAddress(line1: value),
                      validator: Validators.required,
                      textInputAction: TextInputAction.next,
                    ),
                    VerticalSpace(12),
                    _LabeledField(
                      label: AppStrings.addressLine2Optional,
                      hintText: AppStrings.addressLine2Hint,
                      initialValue: state.shipLine2,
                      onChanged: (value) =>
                          cubit.updateShippingAddress(line2: value),
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
                                cubit.updateShippingAddress(city: value),
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
                                cubit.updateShippingAddress(region: value),
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
                                cubit.updateShippingAddress(zip: value),
                            validator: Validators.required,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                    VerticalSpace(12),
                    _LabeledField(
                      label: AppStrings.country,
                      hintText: AppStrings.countryHint,
                      initialValue: state.shipCountry,
                      onChanged: (value) =>
                          cubit.updateShippingAddress(country: value),
                      validator: Validators.required,
                      textInputAction: TextInputAction.next,
                    ),
                    VerticalSpace(20),
                    _SectionTitle(title: AppStrings.billingAddress),
                    VerticalSpace(12),
                    _LabeledField(
                      label: AppStrings.addressLine1,
                      hintText: AppStrings.addressLine1Hint,
                      initialValue: state.billLine1,
                      onChanged: (value) =>
                          cubit.updateBillingAddress(line1: value),
                      validator: Validators.required,
                      textInputAction: TextInputAction.next,
                    ),
                    VerticalSpace(12),
                    _LabeledField(
                      label: AppStrings.addressLine2Optional,
                      hintText: AppStrings.addressLine2Hint,
                      initialValue: state.billLine2,
                      onChanged: (value) =>
                          cubit.updateBillingAddress(line2: value),
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
                                cubit.updateBillingAddress(city: value),
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
                                cubit.updateBillingAddress(region: value),
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
                                cubit.updateBillingAddress(zip: value),
                            validator: Validators.required,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ],
                    ),
                    VerticalSpace(12),
                    _LabeledField(
                      label: AppStrings.country,
                      hintText: AppStrings.countryHint,
                      initialValue: state.billCountry,
                      onChanged: (value) =>
                          cubit.updateBillingAddress(country: value),
                      validator: Validators.required,
                      textInputAction: TextInputAction.next,
                    ),
                    VerticalSpace(20),
                    _SectionTitle(title: AppStrings.orderDetails),
                    VerticalSpace(12),
                    _LabeledField(
                      label: AppStrings.additionalNotesOptional,
                      hintText: AppStrings.additionalNotesHint,
                      initialValue: state.customerNotes,
                      onChanged: (value) =>
                          cubit.updateOrderDetails(notes: value),
                      maxLines: 3,
                      textInputAction: TextInputAction.newline,
                    ),
                    VerticalSpace(12),
                    _LabeledField(
                      label: AppStrings.artworkDescription,
                      hintText: AppStrings.artworkDescriptionHint,
                      initialValue: state.artworkDescription,
                      onChanged: (value) =>
                          cubit.updateOrderDetails(artworkDescription: value),
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
                            onChanged: (value) => cubit.updateOrderDetails(
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
                            onTap: () =>
                                _pickShipDate(cubit, state.desiredShipDate),
                            suffixIcon: const Icon(
                              Icons.calendar_today_outlined,
                            ),
                          ),
                        ),
                      ],
                    ),
                    VerticalSpace(24),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
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
