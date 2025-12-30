import 'dart:async';

import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/models/api_response_model.dart' hide Failure;
import 'package:apo/core/models/result.dart';
import 'package:apo/core/themes/color_scheme.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:apo/core/utilities/validators.dart';
import 'package:apo/core/widgets/app_toast.dart';
import 'package:apo/features/checkout/checkout_type.dart';
import 'package:apo/features/checkout/domain/models/create_transfer_parameters.dart';
import 'package:apo/features/checkout/presentation/cubits/checkout_cubit.dart';
import 'package:apo/features/checkout/presentation/cubits/checkout_state.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/home/presentation/cubits/cart_cubit.dart';
import 'package:apo/features/home/presentation/cubits/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final _formKey = GlobalKey<FormState>();

  Future<void> _showTransferDialog(CheckoutCubit cubit) async {
    if (!mounted) return;
    if (cubit.state.transferOptions.isEmpty &&
        !cubit.state.transfersStatus.isLoading) {
      await cubit.fetchTransferSelections();
    }
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final colorScheme = Theme.of(dialogContext).colorScheme;
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<CheckoutCubit, CheckoutState>(
            builder: (context, state) {
              final transferContent = switch (state.transfersStatus) {
                Loading() => Row(
                  children: [
                    CircularProgressIndicator(),
                    HorizontalSpace(12),
                    Expanded(
                      child: Text(
                        AppStrings.loadingTransfers,
                        style: TextStyles.text14400.copyWith(
                          color: colorScheme.secondaryText,
                        ),
                      ),
                    ),
                  ],
                ),
                Failure() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.transfersStatus.failureMessage,
                      style: TextStyles.text14400.copyWith(
                        color: colorScheme.error,
                      ),
                    ),
                    VerticalSpace(8),
                    TextButton.icon(
                      onPressed: cubit.fetchTransferSelections,
                      icon: const Icon(Icons.refresh),
                      label: Text(AppStrings.retry),
                    ),
                  ],
                ),
                _ =>
                  state.transferOptions.isEmpty
                      ? Text(
                          AppStrings.noTransfersAvailable,
                          style: TextStyles.text14400.copyWith(
                            color: colorScheme.secondaryText,
                          ),
                        )
                      : SizedBox(
                          width: double.maxFinite,
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final transfer = state.transferOptions[index];
                              final isSelected = state.selectedTransferIds
                                  .contains(transfer.transferId);
                              return CheckboxListTile(
                                value: isSelected,
                                onChanged: (_) => cubit.toggleTransferSelection(
                                  transfer.transferId,
                                ),
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                title: Text(
                                  transfer.transferName,
                                  style: TextStyles.text14400.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  '${transfer.transferCode} • ${transfer.transferType}',
                                  style: TextStyles.text14400.copyWith(
                                    color: colorScheme.secondaryText,
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, _) => VerticalSpace(8),
                            itemCount: state.transferOptions.length,
                          ),
                        ),
              };
              return AlertDialog(
                title: Text(AppStrings.transferSelection),
                content: transferContent,
                actions: [
                  ElevatedButton(
                    onPressed: () => context.pop(),
                    child: Text(AppStrings.done),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _showCreateTransferDialog(CheckoutCubit cubit) async {
    if (!mounted) return;
    final formKey = GlobalKey<FormState>();
    if (cubit.state.transferTypeOptions.isEmpty &&
        !cubit.state.transferTypeStatus.isLoading) {
      await cubit.fetchTransferTypeOptions();
    }
    if (cubit.state.sheetTypeOptions.isEmpty &&
        !cubit.state.sheetTypeStatus.isLoading) {
      await cubit.fetchSheetTypeOptions();
    }
    if (!mounted) return;
    var transferCode = '';
    var transferName = '';
    var transferDescription = '';
    var thumbnailUrl = '';
    var artworkUrl = '';
    var artworkThumbnailUrl = '';
    var designFileUrl = '';
    int? transferTypeId;
    int? defaultSheetTypeId;
    var isSubmitting = false;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        final colorScheme = Theme.of(dialogContext).colorScheme;
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<CheckoutCubit, CheckoutState>(
            builder: (context, state) {
              return StatefulBuilder(
                builder: (context, setDialogState) {
                  Future<void> handleSubmit() async {
                    if (!formKey.currentState!.validate()) return;
                    if (transferTypeId == null || defaultSheetTypeId == null) {
                      AppToast.show(message: AppStrings.requiredField);
                      return;
                    }
                    setDialogState(() => isSubmitting = true);
                    final parameters = CreateTransferParameters(
                      transferCode: transferCode.trim(),
                      transferName: transferName.trim(),
                      description: transferDescription.trim(),
                      thumbnailUrl: thumbnailUrl.trim(),
                      designFileUrl: designFileUrl.trim(),
                      artworkUrl: artworkUrl.trim(),
                      artworkThumbnailUrl: artworkThumbnailUrl.trim(),
                      transferTypeId: transferTypeId ?? 0,
                      defaultSheetTypeId: defaultSheetTypeId ?? 0,
                    );
                    final response = await cubit.createTransfer(parameters);
                    response.when(
                      success: (_) {
                        Navigator.of(dialogContext).pop();
                        cubit.fetchTransferSelections();
                      },
                      failure: (error) {
                        AppToast.show(message: error.messageOrDefault);
                        setDialogState(() => isSubmitting = false);
                      },
                    );
                  }

                  return AlertDialog(
                    title: Text(AppStrings.createNewTransferTitle),
                    content: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.createNewTransferSubtitle,
                              style: TextStyles.text14400.copyWith(
                                color: colorScheme.secondaryText,
                              ),
                            ),
                            VerticalSpace(16),
                            Row(
                              children: [
                                Expanded(
                                  child: _LabeledField(
                                    label: AppStrings.transferCodeLabel,
                                    hintText: AppStrings.transferCodeHint,
                                    validator: Validators.required,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) => transferCode = value,
                                  ),
                                ),
                                HorizontalSpace(12),
                                Expanded(
                                  child: _LabeledField(
                                    label: AppStrings.transferNameLabel,
                                    hintText: AppStrings.transferNameHint,
                                    validator: Validators.required,
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) => transferName = value,
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpace(12),
                            _LabeledField(
                              label: AppStrings.transferDescriptionLabel,
                              hintText: AppStrings.transferDescriptionHint,
                              validator: Validators.required,
                              maxLines: 3,
                              textInputAction: TextInputAction.newline,
                              onChanged: (value) => transferDescription = value,
                            ),
                            VerticalSpace(12),
                            Row(
                              children: [
                                Expanded(
                                  child: _LabeledField(
                                    label: AppStrings.transferThumbnailUrlLabel,
                                    hintText: 'https://example.com',
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) => thumbnailUrl = value,
                                  ),
                                ),
                                HorizontalSpace(12),
                                Expanded(
                                  child: _LabeledField(
                                    label: AppStrings.transferArtworkUrlLabel,
                                    hintText: 'https://example.com',
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) => artworkUrl = value,
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpace(12),
                            Row(
                              children: [
                                Expanded(
                                  child: _LabeledField(
                                    label: AppStrings
                                        .transferArtworkThumbnailUrlLabel,
                                    hintText: 'https://example.com',
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) =>
                                        artworkThumbnailUrl = value,
                                  ),
                                ),
                                HorizontalSpace(12),
                                Expanded(
                                  child: _LabeledField(
                                    label:
                                        AppStrings.transferDesignFileUrlLabel,
                                    hintText: 'https://example.com',
                                    textInputAction: TextInputAction.next,
                                    onChanged: (value) => designFileUrl = value,
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpace(12),
                            Row(
                              children: [
                                Expanded(
                                  child: _LabeledDropdown<int>(
                                    label: AppStrings.transferTypeIdLabel,
                                    hintText: AppStrings.transferTypeIdHint,
                                    value: transferTypeId,
                                    items: state.transferTypeOptions
                                        .map(
                                          (option) => DropdownMenuItem<int>(
                                            value: option.id,
                                            child: Text(
                                              option.detailName,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged:
                                        state.transferTypeStatus.isLoading
                                        ? null
                                        : (value) => setDialogState(
                                            () => transferTypeId = value,
                                          ),
                                  ),
                                ),
                                HorizontalSpace(12),
                                Expanded(
                                  child: _LabeledDropdown<int>(
                                    label: AppStrings.defaultSheetTypeIdLabel,
                                    hintText: AppStrings.defaultSheetTypeIdHint,
                                    value: defaultSheetTypeId,
                                    items: state.sheetTypeOptions
                                        .map(
                                          (option) => DropdownMenuItem<int>(
                                            value: option.id,
                                            child: Text(
                                              option.detailName,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        )
                                        .toList(),
                                    onChanged: state.sheetTypeStatus.isLoading
                                        ? null
                                        : (value) => setDialogState(
                                            () => defaultSheetTypeId = value,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            if (state.transferTypeStatus.isFailure)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  state.transferTypeStatus.failureMessage,
                                  style: TextStyles.text14400.copyWith(
                                    color: colorScheme.error,
                                  ),
                                ),
                              ),
                            if (state.sheetTypeStatus.isFailure)
                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Text(
                                  state.sheetTypeStatus.failureMessage,
                                  style: TextStyles.text14400.copyWith(
                                    color: colorScheme.error,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              onPressed: isSubmitting
                                  ? null
                                  : () => Navigator.of(dialogContext).pop(),
                              child: Text(AppStrings.cancel),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: isSubmitting ? () {} : handleSubmit,
                              child: isSubmitting
                                  ? CircularProgressIndicator()
                                  : Text(AppStrings.save),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        );
      },
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

  Future<void> _submit(QuoteFormController controller) async {
    if (!_formKey.currentState!.validate()) return;
    await controller.submit(items: context.read<CartCubit>().state.items);
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    return '${date.month.toString().padLeft(2, '0')}/'
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  void _handleStatus(BuildContext context, CheckoutState state) {
    if (state.status.isSuccess) {
      final isAuthenticated =
          context.read<ProfileCubit>().state.isAuthenticated;
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
    final selectedTransfers = state.transferOptions
        .where(
          (transfer) => state.selectedTransferIds.contains(transfer.transferId),
        )
        .toList();
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
              ],
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
              if (type == CheckoutType.checkout) ...[
                VerticalSpace(24),
                _SectionTitle(title: AppStrings.jobInformation),
                VerticalSpace(12),
                _LabeledField(
                  label: AppStrings.jobDescription,
                  hintText: AppStrings.jobDescriptionHint,
                  initialValue: state.jobDescription,
                  maxLines: 2,
                  textInputAction: TextInputAction.newline,
                  onChanged: (value) =>
                      cubit.updateJobInformation(description: value),
                ),
                VerticalSpace(12),
                _LabeledField(
                  label: AppStrings.jobComment,
                  hintText: AppStrings.jobCommentHint,
                  initialValue: state.jobComment,
                  maxLines: 2,
                  textInputAction: TextInputAction.newline,
                  onChanged: (value) =>
                      cubit.updateJobInformation(comment: value),
                ),
                VerticalSpace(20),
                _SectionTitle(title: AppStrings.shippingInformation),
                VerticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: _LabeledDropdown<String>(
                        label: AppStrings.shipVia,
                        hintText: AppStrings.selectShippingMethod,
                        value: state.selectedShipViaCode,
                        items: state.shipViaOptions
                            .map(
                              (option) => DropdownMenuItem<String>(
                                value: option.detailCode,
                                child: Text(
                                  option.detailName,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: state.shipViaOptions.isEmpty
                            ? null
                            : cubit.selectShipViaOption,
                      ),
                    ),
                    HorizontalSpace(12),
                    Expanded(
                      child: _LabeledField(
                        key: ValueKey(
                          state.requestedShipDate?.toIso8601String() ?? '',
                        ),
                        label: AppStrings.requestedShipDate,
                        hintText: AppStrings.requestedShipDateHint,
                        initialValue: _formatDate(state.requestedShipDate),
                        readOnly: true,
                        onTap: () => _pickShipDate(
                          cubit.setRequestedShipDate,
                          state.requestedShipDate,
                        ),
                        suffixIcon: const Icon(Icons.calendar_today_outlined),
                      ),
                    ),
                  ],
                ),
                VerticalSpace(12),
                _LabeledField(
                  label: AppStrings.shippingInstructions,
                  hintText: AppStrings.shippingInstructionsHint,
                  initialValue: state.shippingInstructions,
                  maxLines: 2,
                  textInputAction: TextInputAction.newline,
                  onChanged: cubit.updateShippingInstructions,
                ),
                VerticalSpace(4),
                Row(
                  children: [
                    Checkbox(
                      value: state.mustShipByRequestedDate,
                      onChanged: (value) =>
                          cubit.setMustShipByRequestedDate(value ?? false),
                    ),
                    Expanded(
                      child: Text(
                        AppStrings.mustShipByRequestedDate,
                        style: TextStyles.text14400.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                VerticalSpace(20),
                _SectionTitle(title: AppStrings.transferSelection),
                VerticalSpace(12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showTransferDialog(cubit),
                        icon: const Icon(Icons.search),
                        label: Text(AppStrings.addExistingTransfer),
                      ),
                    ),
                    HorizontalSpace(12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _showCreateTransferDialog(cubit),
                        icon: const Icon(Icons.add),
                        label: Text(AppStrings.createNewTransfer),
                      ),
                    ),
                  ],
                ),
                VerticalSpace(12),
                Text(
                  AppStrings.selectedTransfers,
                  style: TextStyles.text14400.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                VerticalSpace(6),
                if (selectedTransfers.isEmpty)
                  Text(
                    AppStrings.noTransfersSelected,
                    style: TextStyles.text14400.copyWith(
                      color: colorScheme.secondaryText,
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final transfer = selectedTransfers[index];
                      return Material(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                        child: ListTile(
                          title: Text(
                            transfer.transferName,
                            style: TextStyles.text14400.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${transfer.transferCode} • ${transfer.transferType}',
                            style: TextStyles.text14400.copyWith(
                              color: colorScheme.secondaryText,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete_outline),
                            color: colorScheme.error,
                            onPressed: () => cubit.toggleTransferSelection(
                              transfer.transferId,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, _) => VerticalSpace(8),
                    itemCount: selectedTransfers.length,
                  ),
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
    Future<void> Function({required List<CartItemEntity> items});

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
