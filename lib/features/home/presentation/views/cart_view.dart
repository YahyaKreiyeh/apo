import 'dart:async';
import 'dart:io';

import 'package:apo/core/constants/app_strings.dart';
import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/models/api_response_model.dart';
import 'package:apo/core/models/result.dart';
import 'package:apo/core/routing/route_names.dart';
import 'package:apo/core/themes/app_colors.dart';
import 'package:apo/core/themes/color_scheme.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:apo/core/widgets/network_image_placeholder.dart';
import 'package:apo/core/widgets/shimmer_placeholder.dart';
import 'package:apo/features/checkout/checkout_type.dart';
import 'package:apo/features/home/domain/models/cart_item_entity.dart';
import 'package:apo/features/home/domain/models/master_detail_type.dart';
import 'package:apo/features/home/presentation/cubits/cart_cubit.dart';
import 'package:apo/features/home/presentation/cubits/cart_state.dart';
import 'package:apo/features/home/presentation/cubits/profile_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  Future<void> _showDecorationDialog(
    BuildContext context,
    CartItemEntity item,
  ) async {
    final cubit = context.read<CartCubit>();
    final imagePicker = ImagePicker();
    final uploadingIndexes = ValueNotifier<Set<int>>(<int>{});
    final isSaving = ValueNotifier<bool>(false);
    if (cubit.state.decorationTypeOptions.isEmpty &&
        !cubit.state.decorationTypeStatus.isLoading) {
      unawaited(cubit.fetchDecorationTypeOptions());
    }
    if (!context.mounted) return;
    final initialDecorations =
        List<CartDecorationSelection>.from(
          cubit.state.decorationsByItem[
                '${item.productId}-${item.variantId}'] ??
            const [],
        );
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        final colorScheme = Theme.of(dialogContext).colorScheme;
        final selectedDecorationId = ValueNotifier<int?>(null);
        return BlocProvider.value(
          value: cubit,
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              final itemKey = '${item.productId}-${item.variantId}';
              final decorations = state.decorationsByItem[itemKey] ?? const [];

              Widget buildDecorationDropdown(
                void Function(void Function()) setState,
              ) {
                if (state.decorationTypeOptions.isEmpty) {
                  return Text(
                    AppStrings.noDecorationTypes,
                    style: TextStyles.text14400.copyWith(
                      color: colorScheme.secondaryText,
                    ),
                  );
                }
                return DropdownButtonFormField<int>(
                  initialValue: selectedDecorationId.value,
                  isExpanded: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.selectDecorationType,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: colorScheme.secondaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.decorationTypeOptions
                      .where(
                        (option) => option.detailCode.toUpperCase() != 'BLANK',
                      )
                      .map(
                        (option) => DropdownMenuItem<int>(
                          value: option.id,
                          child: Text(
                            option.detailName,
                            style: TextStyles.text14400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => selectedDecorationId.value = value),
                );
              }

              Widget buildEmbOptionsDropdown({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                if (state.embOptions.isEmpty) {
                  return Text(
                    AppStrings.noEmbOptions,
                    style: TextStyles.text14400.copyWith(
                      color: colorScheme.secondaryText,
                    ),
                  );
                }
                return DropdownButtonFormField<int>(
                  initialValue: selectedId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.selectEmbOption,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: colorScheme.secondaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.embOptions
                      .map(
                        (option) => DropdownMenuItem<int>(
                          value: option.id,
                          child: Text(
                            option.detailName,
                            style: TextStyles.text14400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                );
              }

              Widget buildEmbTypesDropdown({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                if (state.embTypes.isEmpty) {
                  return Text(
                    AppStrings.noEmbTypes,
                    style: TextStyles.text14400.copyWith(
                      color: colorScheme.secondaryText,
                    ),
                  );
                }
                return DropdownButtonFormField<int>(
                  initialValue: selectedId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.selectEmbType,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: colorScheme.secondaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.embTypes
                      .map(
                        (option) => DropdownMenuItem<int>(
                          value: option.id,
                          child: Text(
                            option.detailName,
                            style: TextStyles.text14400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                );
              }

              Widget buildEmbOptionsContent({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                return state.embOptionsStatus.when(
                  empty: () => buildEmbOptionsDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  success: (_) => buildEmbOptionsDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  loading: () => Row(
                    children: [
                      const CircularProgressIndicator(),
                      HorizontalSpace(12),
                      Expanded(
                        child: Text(
                          AppStrings.loadingEmbOptions,
                          style: TextStyles.text14400.copyWith(
                            color: colorScheme.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  failure: (_, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.embOptionsStatus.failureMessage,
                        style: TextStyles.text14400.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                      VerticalSpace(8),
                      TextButton.icon(
                        onPressed: cubit.fetchEmbOptions,
                        icon: const Icon(Icons.refresh),
                        label: Text(AppStrings.retry),
                      ),
                    ],
                  ),
                );
              }

              Widget buildEmbTypesContent({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                return state.embTypesStatus.when(
                  empty: () => buildEmbTypesDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  success: (_) => buildEmbTypesDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  loading: () => Row(
                    children: [
                      const CircularProgressIndicator(),
                      HorizontalSpace(12),
                      Expanded(
                        child: Text(
                          AppStrings.loadingEmbTypes,
                          style: TextStyles.text14400.copyWith(
                            color: colorScheme.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  failure: (_, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.embTypesStatus.failureMessage,
                        style: TextStyles.text14400.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                      VerticalSpace(8),
                      TextButton.icon(
                        onPressed: cubit.fetchEmbTypes,
                        icon: const Icon(Icons.refresh),
                        label: Text(AppStrings.retry),
                      ),
                    ],
                  ),
                );
              }

              Widget buildHeatTransferTypeDropdown({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                if (state.heatTransferTypeOptions.isEmpty) {
                  return Text(
                    AppStrings.noHeatTransferTypes,
                    style: TextStyles.text14400.copyWith(
                      color: colorScheme.secondaryText,
                    ),
                  );
                }
                return DropdownButtonFormField<int>(
                  initialValue: selectedId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.selectHeatTransferType,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: colorScheme.secondaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.heatTransferTypeOptions
                      .map(
                        (option) => DropdownMenuItem<int>(
                          value: option.id,
                          child: Text(
                            option.detailName,
                            style: TextStyles.text14400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                );
              }

              Widget buildHeatTransferTypeContent({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                return state.heatTransferTypeStatus.when(
                  empty: () => buildHeatTransferTypeDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  success: (_) => buildHeatTransferTypeDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  loading: () => Row(
                    children: [
                      const CircularProgressIndicator(),
                      HorizontalSpace(12),
                      Expanded(
                        child: Text(
                          AppStrings.loadingHeatTransferTypes,
                          style: TextStyles.text14400.copyWith(
                            color: colorScheme.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  failure: (_, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.heatTransferTypeStatus.failureMessage,
                        style: TextStyles.text14400.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                      VerticalSpace(8),
                      TextButton.icon(
                        onPressed: cubit.fetchHeatTransferTypes,
                        icon: const Icon(Icons.refresh),
                        label: Text(AppStrings.retry),
                      ),
                    ],
                  ),
                );
              }

              String formatInchesValue(double? value) {
                if (value == null) {
                  return '';
                }
                if (value % 1 == 0) {
                  return value.toStringAsFixed(0);
                }
                return value.toString();
              }

              Widget buildHeatTransferInchesField({
                required String label,
                required String hintText,
                required String initialValue,
                required ValueChanged<String> onChanged,
              }) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyles.text14400.copyWith(
                        color: colorScheme.secondaryText,
                      ),
                    ),
                    VerticalSpace(6),
                    TextFormField(
                      initialValue: initialValue,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      textInputAction: TextInputAction.next,
                      onChanged: onChanged,
                      onTapOutside: (_) =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      decoration: InputDecoration(
                        hintText: hintText,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        filled: true,
                        fillColor: colorScheme.secondaryContainer,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                );
              }

              Widget buildScreenPrintColorDropdown({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                if (state.screenPrintColorOptions.isEmpty) {
                  return Text(
                    AppStrings.noScreenPrintColors,
                    style: TextStyles.text14400.copyWith(
                      color: colorScheme.secondaryText,
                    ),
                  );
                }
                return DropdownButtonFormField<int>(
                  initialValue: selectedId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.selectScreenPrintColor,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: colorScheme.secondaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.screenPrintColorOptions
                      .map(
                        (option) => DropdownMenuItem<int>(
                          value: option.id,
                          child: Text(
                            option.detailName,
                            style: TextStyles.text14400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                );
              }

              Widget buildScreenPrintGarmentDropdown({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                if (state.screenPrintGarmentOptions.isEmpty) {
                  return Text(
                    AppStrings.noScreenPrintGarments,
                    style: TextStyles.text14400.copyWith(
                      color: colorScheme.secondaryText,
                    ),
                  );
                }
                return DropdownButtonFormField<int>(
                  initialValue: selectedId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.selectScreenPrintGarment,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: colorScheme.secondaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.screenPrintGarmentOptions
                      .map(
                        (option) => DropdownMenuItem<int>(
                          value: option.id,
                          child: Text(
                            option.detailName,
                            style: TextStyles.text14400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                );
              }

              Widget buildScreenPrintLocationDropdown({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                if (state.screenPrintLocationOptions.isEmpty) {
                  return Text(
                    AppStrings.noScreenPrintLocations,
                    style: TextStyles.text14400.copyWith(
                      color: colorScheme.secondaryText,
                    ),
                  );
                }
                return DropdownButtonFormField<int>(
                  initialValue: selectedId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.selectScreenPrintLocation,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: colorScheme.secondaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.screenPrintLocationOptions
                      .map(
                        (option) => DropdownMenuItem<int>(
                          value: option.id,
                          child: Text(
                            option.detailName,
                            style: TextStyles.text14400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                );
              }

              Widget buildScreenPrintColorContent({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                return state.screenPrintColorStatus.when(
                  empty: () => buildScreenPrintColorDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  success: (_) => buildScreenPrintColorDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  loading: () => Row(
                    children: [
                      const CircularProgressIndicator(),
                      HorizontalSpace(12),
                      Expanded(
                        child: Text(
                          AppStrings.loadingScreenPrintColors,
                          style: TextStyles.text14400.copyWith(
                            color: colorScheme.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  failure: (_, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.screenPrintColorStatus.failureMessage,
                        style: TextStyles.text14400.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                      VerticalSpace(8),
                      TextButton.icon(
                        onPressed: cubit.fetchScreenPrintColors,
                        icon: const Icon(Icons.refresh),
                        label: Text(AppStrings.retry),
                      ),
                    ],
                  ),
                );
              }

              Widget buildScreenPrintGarmentContent({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                return state.screenPrintGarmentStatus.when(
                  empty: () => buildScreenPrintGarmentDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  success: (_) => buildScreenPrintGarmentDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  loading: () => Row(
                    children: [
                      const CircularProgressIndicator(),
                      HorizontalSpace(12),
                      Expanded(
                        child: Text(
                          AppStrings.loadingScreenPrintGarments,
                          style: TextStyles.text14400.copyWith(
                            color: colorScheme.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  failure: (_, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.screenPrintGarmentStatus.failureMessage,
                        style: TextStyles.text14400.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                      VerticalSpace(8),
                      TextButton.icon(
                        onPressed: cubit.fetchScreenPrintGarments,
                        icon: const Icon(Icons.refresh),
                        label: Text(AppStrings.retry),
                      ),
                    ],
                  ),
                );
              }

              Widget buildScreenPrintLocationContent({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                return state.screenPrintLocationStatus.when(
                  empty: () => buildScreenPrintLocationDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  success: (_) => buildScreenPrintLocationDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  loading: () => Row(
                    children: [
                      const CircularProgressIndicator(),
                      HorizontalSpace(12),
                      Expanded(
                        child: Text(
                          AppStrings.loadingScreenPrintLocations,
                          style: TextStyles.text14400.copyWith(
                            color: colorScheme.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  failure: (_, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.screenPrintLocationStatus.failureMessage,
                        style: TextStyles.text14400.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                      VerticalSpace(8),
                      TextButton.icon(
                        onPressed: cubit.fetchScreenPrintLocations,
                        icon: const Icon(Icons.refresh),
                        label: Text(AppStrings.retry),
                      ),
                    ],
                  ),
                );
              }

              Widget buildLeatherColorDropdown({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                if (state.leatherColorOptions.isEmpty) {
                  return Text(
                    AppStrings.noLeatherColors,
                    style: TextStyles.text14400.copyWith(
                      color: colorScheme.secondaryText,
                    ),
                  );
                }
                return DropdownButtonFormField<int>(
                  initialValue: selectedId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.selectLeatherColor,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: colorScheme.secondaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.leatherColorOptions
                      .map(
                        (option) => DropdownMenuItem<int>(
                          value: option.id,
                          child: Text(
                            option.detailName,
                            style: TextStyles.text14400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                );
              }

              Widget buildLeatherColorContent({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                return state.leatherColorStatus.when(
                  empty: () => buildLeatherColorDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  success: (_) => buildLeatherColorDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  loading: () => Row(
                    children: [
                      const CircularProgressIndicator(),
                      HorizontalSpace(12),
                      Expanded(
                        child: Text(
                          AppStrings.loadingLeatherColors,
                          style: TextStyles.text14400.copyWith(
                            color: colorScheme.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  failure: (_, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.leatherColorStatus.failureMessage,
                        style: TextStyles.text14400.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                      VerticalSpace(8),
                      TextButton.icon(
                        onPressed: cubit.fetchLeatherColors,
                        icon: const Icon(Icons.refresh),
                        label: Text(AppStrings.retry),
                      ),
                    ],
                  ),
                );
              }

              Widget buildPatchTypeDropdown({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                if (state.patchTypeOptions.isEmpty) {
                  return Text(
                    AppStrings.noPatchTypes,
                    style: TextStyles.text14400.copyWith(
                      color: colorScheme.secondaryText,
                    ),
                  );
                }
                return DropdownButtonFormField<int>(
                  initialValue: selectedId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.selectPatchType,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: colorScheme.secondaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.patchTypeOptions
                      .map(
                        (option) => DropdownMenuItem<int>(
                          value: option.id,
                          child: Text(
                            option.detailName,
                            style: TextStyles.text14400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                );
              }

              Widget buildPatchTypeContent({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                return state.patchTypeStatus.when(
                  empty: () => buildPatchTypeDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  success: (_) => buildPatchTypeDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  loading: () => Row(
                    children: [
                      const CircularProgressIndicator(),
                      HorizontalSpace(12),
                      Expanded(
                        child: Text(
                          AppStrings.loadingPatchTypes,
                          style: TextStyles.text14400.copyWith(
                            color: colorScheme.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  failure: (_, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.patchTypeStatus.failureMessage,
                        style: TextStyles.text14400.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                      VerticalSpace(8),
                      TextButton.icon(
                        onPressed: cubit.fetchPatchTypes,
                        icon: const Icon(Icons.refresh),
                        label: Text(AppStrings.retry),
                      ),
                    ],
                  ),
                );
              }

              Widget buildLabelTypeDropdown({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                if (state.labelTypeOptions.isEmpty) {
                  return Text(
                    AppStrings.noLabelTypes,
                    style: TextStyles.text14400.copyWith(
                      color: colorScheme.secondaryText,
                    ),
                  );
                }
                return DropdownButtonFormField<int>(
                  initialValue: selectedId,
                  isExpanded: true,
                  decoration: InputDecoration(
                    hintText: AppStrings.selectLabelType,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    filled: true,
                    fillColor: colorScheme.secondaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  items: state.labelTypeOptions
                      .map(
                        (option) => DropdownMenuItem<int>(
                          value: option.id,
                          child: Text(
                            option.detailName,
                            style: TextStyles.text14400,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: onChanged,
                );
              }

              Widget buildLabelTypeContent({
                required int? selectedId,
                required ValueChanged<int?> onChanged,
              }) {
                return state.labelTypeStatus.when(
                  empty: () => buildLabelTypeDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  success: (_) => buildLabelTypeDropdown(
                    selectedId: selectedId,
                    onChanged: onChanged,
                  ),
                  loading: () => Row(
                    children: [
                      const CircularProgressIndicator(),
                      HorizontalSpace(12),
                      Expanded(
                        child: Text(
                          AppStrings.loadingLabelTypes,
                          style: TextStyles.text14400.copyWith(
                            color: colorScheme.secondaryText,
                          ),
                        ),
                      ),
                    ],
                  ),
                  failure: (_, _) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.labelTypeStatus.failureMessage,
                        style: TextStyles.text14400.copyWith(
                          color: colorScheme.error,
                        ),
                      ),
                      VerticalSpace(8),
                      TextButton.icon(
                        onPressed: cubit.fetchLabelTypes,
                        icon: const Icon(Icons.refresh),
                        label: Text(AppStrings.retry),
                      ),
                    ],
                  ),
                );
              }

              Future<void> pickDecorationImage(int index) async {
                final selected = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                  imageQuality: 85,
                );
                if (selected == null) return;
                if (kIsWeb) {
                  final bytes = await selected.readAsBytes();
                  cubit.updateDecorationImagePath(
                    item.productId,
                    item.variantId,
                    index,
                    selected.path,
                  );
                  cubit.updateDecorationImageBytes(
                    item.productId,
                    item.variantId,
                    index,
                    bytes,
                    selected.name,
                  );
                  return;
                }
                uploadingIndexes.value = {...uploadingIndexes.value, index};
                final response = await cubit.uploadDecorationImage(
                  productId: item.productId,
                  variantId: item.variantId,
                  index: index,
                  image: selected,
                );
                uploadingIndexes.value = Set<int>.from(
                  uploadingIndexes.value.where((value) => value != index),
                );
                response.when(
                  success: (_) {},
                  failure: (error) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error.title ?? AppStrings.unknownError),
                      ),
                    );
                  },
                );
              }

              String resolveDecorationImageUrl(String path) {
                if (path.startsWith('http')) {
                  return path;
                }
                if (path.startsWith('Content/')) {
                  return 'https://apolloemb.runasp.net/$path';
                }
                return path;
              }

              Widget buildDecorationImagePreview(String imagePath) {
                final resolvedPath = resolveDecorationImageUrl(imagePath);
                if (resolvedPath.startsWith('http')) {
                  return Image.network(resolvedPath, fit: BoxFit.cover);
                }
                if (kIsWeb) {
                  return Image.network(imagePath, fit: BoxFit.cover);
                }
                return Image.file(File(imagePath), fit: BoxFit.cover);
              }

              Widget buildDecorationImageSection({
                required int index,
                required String? imagePath,
              }) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.image_outlined,
                          size: 18,
                          color: colorScheme.primary,
                        ),
                        HorizontalSpace(8),
                        Text(
                          AppStrings.decorationImageLabel,
                          style: TextStyles.text14400,
                        ),
                      ],
                    ),
                    VerticalSpace(10),
                    ValueListenableBuilder<Set<int>>(
                      valueListenable: uploadingIndexes,
                      builder: (context, uploading, _) {
                        final isUploading = uploading.contains(index);
                        if (imagePath == null) {
                          return OutlinedButton.icon(
                            onPressed: isUploading
                                ? null
                                : () => pickDecorationImage(index),
                            icon: isUploading
                                ? const SizedBox(
                                    height: 16,
                                    width: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.upload_outlined),
                            label: Text(AppStrings.uploadImage),
                          );
                        }
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Container(
                                height: 140,
                                width: double.infinity,
                                color: colorScheme.surfaceContainerHighest,
                                child: buildDecorationImagePreview(imagePath),
                              ),
                            ),
                            VerticalSpace(8),
                            OutlinedButton.icon(
                              onPressed: isUploading
                                  ? null
                                  : () => pickDecorationImage(index),
                              icon: isUploading
                                  ? const SizedBox(
                                      height: 16,
                                      width: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : const Icon(Icons.refresh),
                              label: Text(AppStrings.changeImage),
                            ),
                            VerticalSpace(8),
                            OutlinedButton.icon(
                              onPressed: isUploading
                                  ? null
                                  : () => cubit.updateDecorationImagePath(
                                      item.productId,
                                      item.variantId,
                                      index,
                                      null,
                                    ),
                              icon: const Icon(Icons.delete_outline),
                              label: Text(AppStrings.removeImage),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                );
              }

              final decorationContent = state.decorationTypeStatus.when(
                empty: () => const SizedBox.shrink(),
                success: (_) => const SizedBox.shrink(),
                loading: () => Row(
                  children: [
                    const CircularProgressIndicator(),
                    HorizontalSpace(12),
                    Expanded(
                      child: Text(
                        AppStrings.loadingDecorations,
                        style: TextStyles.text14400.copyWith(
                          color: colorScheme.secondaryText,
                        ),
                      ),
                    ),
                  ],
                ),
                failure: (_, _) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.decorationTypeStatus.failureMessage,
                      style: TextStyles.text14400.copyWith(
                        color: colorScheme.error,
                      ),
                    ),
                    VerticalSpace(8),
                    TextButton.icon(
                      onPressed: cubit.fetchDecorationTypeOptions,
                      icon: const Icon(Icons.refresh),
                      label: Text(AppStrings.retry),
                    ),
                  ],
                ),
              );
              return ValueListenableBuilder<Set<int>>(
                valueListenable: uploadingIndexes,
                builder: (context, uploading, _) {
                  return ValueListenableBuilder<bool>(
                    valueListenable: isSaving,
                    builder: (context, saving, __) {
                      final isUploading = uploading.isNotEmpty;
                      final isBusy = isUploading || saving;
                      return WillPopScope(
                        onWillPop: () async => !isBusy,
                        child: AlertDialog(
                        scrollable: true,
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppStrings.addDecorationTitle),
                    VerticalSpace(6),
                    Text(
                      AppStrings.addDecorationSubtitle,
                      style: TextStyles.text14400.copyWith(
                        color: colorScheme.secondaryText,
                      ),
                    ),
                  ],
                ),
                content: StatefulBuilder(
                  builder: (context, setState) {
                    final maxWidth = MediaQuery.of(context).size.width * 0.9;
                    return ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: maxWidth),
                      child: SizedBox(
                        width: maxWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (state.decorationTypeStatus.isLoading ||
                                state.decorationTypeStatus.isFailure)
                              decorationContent,
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: colorScheme.outlineVariant,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.add_circle_outline,
                                        size: 18,
                                        color: colorScheme.primary,
                                      ),
                                      HorizontalSpace(8),
                                      Text(
                                        AppStrings.addNewDecoration,
                                        style: TextStyles.text14500,
                                      ),
                                    ],
                                  ),
                                  VerticalSpace(12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: buildDecorationDropdown(
                                          setState,
                                        ),
                                      ),
                                      HorizontalSpace(12),
                                      ElevatedButton.icon(
                                        style: ElevatedButton.styleFrom(
                                          minimumSize: const Size(0, 52),
                                        ),
                                        onPressed:
                                            selectedDecorationId.value == null
                                            ? null
                                            : () {
                                                final selected = state
                                                    .decorationTypeOptions
                                                    .where(
                                                      (option) =>
                                                          option.id ==
                                                          selectedDecorationId
                                                              .value,
                                                    )
                                                    .toList();
                                                if (selected.isEmpty) {
                                                  return;
                                                }
                                                cubit.addDecorationSelection(
                                                  item.productId,
                                                  item.variantId,
                                                  selected.first,
                                                );
                                                final decorationType =
                                                    MasterDetailTypeX.fromDetailCode(
                                                      selected.first.detailCode,
                                                    );
                                                if (decorationType ==
                                                    MasterDetailType
                                                        .embroideryDecoration) {
                                                  if (state
                                                          .embOptions
                                                          .isEmpty &&
                                                      !state
                                                          .embOptionsStatus
                                                          .isLoading) {
                                                    unawaited(
                                                      cubit.fetchEmbOptions(),
                                                    );
                                                  }
                                                  if (state.embTypes.isEmpty &&
                                                      !state
                                                          .embTypesStatus
                                                          .isLoading) {
                                                    unawaited(
                                                      cubit.fetchEmbTypes(),
                                                    );
                                                  }
                                                } else if (decorationType ==
                                                    MasterDetailType
                                                        .heatTransferDecoration) {
                                                  if (state
                                                          .heatTransferTypeOptions
                                                          .isEmpty &&
                                                      !state
                                                          .heatTransferTypeStatus
                                                          .isLoading) {
                                                    unawaited(
                                                      cubit
                                                          .fetchHeatTransferTypes(),
                                                    );
                                                  }
                                                } else if (decorationType ==
                                                    MasterDetailType
                                                        .screenPrintDecoration) {
                                                  if (state
                                                          .screenPrintColorOptions
                                                          .isEmpty &&
                                                      !state
                                                          .screenPrintColorStatus
                                                          .isLoading) {
                                                    unawaited(
                                                      cubit
                                                          .fetchScreenPrintColors(),
                                                    );
                                                  }
                                                  if (state
                                                          .screenPrintGarmentOptions
                                                          .isEmpty &&
                                                      !state
                                                          .screenPrintGarmentStatus
                                                          .isLoading) {
                                                    unawaited(
                                                      cubit
                                                          .fetchScreenPrintGarments(),
                                                    );
                                                  }
                                                  if (state
                                                          .screenPrintLocationOptions
                                                          .isEmpty &&
                                                      !state
                                                          .screenPrintLocationStatus
                                                          .isLoading) {
                                                    unawaited(
                                                      cubit
                                                          .fetchScreenPrintLocations(),
                                                    );
                                                  }
                                                } else if (decorationType ==
                                                    MasterDetailType
                                                        .leatherDecoration) {
                                                  if (state
                                                          .leatherColorOptions
                                                          .isEmpty &&
                                                      !state
                                                          .leatherColorStatus
                                                          .isLoading) {
                                                    unawaited(
                                                      cubit
                                                          .fetchLeatherColors(),
                                                    );
                                                  }
                                                } else if (decorationType ==
                                                    MasterDetailType
                                                        .patchesDecoration) {
                                                  if (state
                                                          .patchTypeOptions
                                                          .isEmpty &&
                                                      !state
                                                          .patchTypeStatus
                                                          .isLoading) {
                                                    unawaited(
                                                      cubit.fetchPatchTypes(),
                                                    );
                                                  }
                                                } else if (decorationType ==
                                                    MasterDetailType
                                                        .labelsDecoration) {
                                                  if (state
                                                          .labelTypeOptions
                                                          .isEmpty &&
                                                      !state
                                                          .labelTypeStatus
                                                          .isLoading) {
                                                    unawaited(
                                                      cubit.fetchLabelTypes(),
                                                    );
                                                  }
                                                }
                                                setState(
                                                  () =>
                                                      selectedDecorationId
                                                              .value =
                                                          null,
                                                );
                                              },
                                        icon: const Icon(Icons.add, size: 18),
                                        label: Text(AppStrings.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            VerticalSpace(16),
                            Row(
                              children: [
                                Icon(
                                  Icons.auto_awesome,
                                  size: 18,
                                  color: colorScheme.primary,
                                ),
                                HorizontalSpace(8),
                                Text(
                                  AppStrings.yourDecorations,
                                  style: TextStyles.text16500,
                                ),
                                const Spacer(),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary.withValues(
                                      alpha: 0.12,
                                    ),
                                    borderRadius: BorderRadius.circular(999),
                                  ),
                                  child: Text(
                                    '${decorations.length} ${decorations.length == 1 ? 'item' : 'items'}',
                                    style: TextStyles.text12400.copyWith(
                                      color: colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            VerticalSpace(12),
                            if (decorations.isEmpty)
                              Container(
                                padding: const EdgeInsets.all(24),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: colorScheme.surface,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: colorScheme.outlineVariant,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.auto_awesome,
                                      size: 32,
                                      color: colorScheme.outline,
                                    ),
                                    VerticalSpace(12),
                                    Text(
                                      AppStrings.noDecorationsTitle,
                                      style: TextStyles.text14400.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    VerticalSpace(6),
                                    Text(
                                      AppStrings.noDecorationsSubtitle,
                                      style: TextStyles.text13400.copyWith(
                                        color: colorScheme.secondaryText,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            if (decorations.isNotEmpty)
                              ...List.generate(decorations.length, (index) {
                                final decoration = decorations[index];
                                final decorationType =
                                    MasterDetailTypeX.fromDetailCode(
                                      decoration.decorationTypeCode,
                                    );
                                final isEmbroidery =
                                    decorationType ==
                                    MasterDetailType.embroideryDecoration;
                                final isHeatTransfer =
                                    decorationType ==
                                    MasterDetailType.heatTransferDecoration;
                                final isScreenPrint =
                                    decorationType ==
                                    MasterDetailType.screenPrintDecoration;
                                final isLeather =
                                    decorationType ==
                                    MasterDetailType.leatherDecoration;
                                final isPatches =
                                    decorationType ==
                                    MasterDetailType.patchesDecoration;
                                final isLabels =
                                    decorationType ==
                                    MasterDetailType.labelsDecoration;
                                if (isEmbroidery) {
                                  if (state.embOptions.isEmpty &&
                                      !state.embOptionsStatus.isLoading) {
                                    unawaited(cubit.fetchEmbOptions());
                                  }
                                  if (state.embTypes.isEmpty &&
                                      !state.embTypesStatus.isLoading) {
                                    unawaited(cubit.fetchEmbTypes());
                                  }
                                }
                                if (isHeatTransfer) {
                                  if (state.heatTransferTypeOptions.isEmpty &&
                                      !state.heatTransferTypeStatus.isLoading) {
                                    unawaited(cubit.fetchHeatTransferTypes());
                                  }
                                }
                                if (isScreenPrint) {
                                  if (state.screenPrintColorOptions.isEmpty &&
                                      !state.screenPrintColorStatus.isLoading) {
                                    unawaited(cubit.fetchScreenPrintColors());
                                  }
                                  if (state.screenPrintGarmentOptions.isEmpty &&
                                      !state
                                          .screenPrintGarmentStatus
                                          .isLoading) {
                                    unawaited(cubit.fetchScreenPrintGarments());
                                  }
                                  if (state
                                          .screenPrintLocationOptions
                                          .isEmpty &&
                                      !state
                                          .screenPrintLocationStatus
                                          .isLoading) {
                                    unawaited(
                                      cubit.fetchScreenPrintLocations(),
                                    );
                                  }
                                }
                                if (isLeather) {
                                  if (state.leatherColorOptions.isEmpty &&
                                      !state.leatherColorStatus.isLoading) {
                                    unawaited(cubit.fetchLeatherColors());
                                  }
                                }
                                if (isPatches) {
                                  if (state.patchTypeOptions.isEmpty &&
                                      !state.patchTypeStatus.isLoading) {
                                    unawaited(cubit.fetchPatchTypes());
                                  }
                                }
                                if (isLabels) {
                                  if (state.labelTypeOptions.isEmpty &&
                                      !state.labelTypeStatus.isLoading) {
                                    unawaited(cubit.fetchLabelTypes());
                                  }
                                }
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: colorScheme.surface,
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: colorScheme.outlineVariant,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: colorScheme
                                                    .primaryContainer,
                                                borderRadius:
                                                    BorderRadius.circular(999),
                                              ),
                                              child: Text(
                                                '#${index + 1}',
                                                style: TextStyles.text12400
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                              ),
                                            ),
                                            HorizontalSpace(8),
                                            Expanded(
                                              child: Text(
                                                decoration.decorationTypeName,
                                                style: TextStyles.text14500,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                final response = await cubit
                                                    .deleteDecorationSelection(
                                                      productId: item.productId,
                                                      variantId: item.variantId,
                                                      index: index,
                                                    );
                                                response.when(
                                                  success: (_) {},
                                                  failure: (error) {
                                                    if (!context.mounted) {
                                                      return;
                                                    }
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          error.title ??
                                                              AppStrings
                                                                  .unknownError,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.delete_outline,
                                                color: AppColors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        VerticalSpace(12),
                                        buildDecorationImageSection(
                                          index: index,
                                          imagePath:
                                              decoration.decorationImagePath,
                                        ),
                                        if (isEmbroidery) ...[
                                          VerticalSpace(12),
                                          Text(
                                            AppStrings.embOptionsLabel,
                                            style: TextStyles.text14400
                                                .copyWith(
                                                  color:
                                                      colorScheme.secondaryText,
                                                ),
                                          ),
                                          VerticalSpace(6),
                                          buildEmbOptionsContent(
                                            selectedId: decoration.embOptionId,
                                            onChanged: (value) {
                                              final selected = state.embOptions
                                                  .where(
                                                    (option) =>
                                                        option.id == value,
                                                  )
                                                  .toList();
                                              cubit.updateDecorationEmbOption(
                                                item.productId,
                                                item.variantId,
                                                index,
                                                selected.isEmpty
                                                    ? null
                                                    : selected.first,
                                              );
                                            },
                                          ),
                                          VerticalSpace(12),
                                          Text(
                                            AppStrings.embTypeLabel,
                                            style: TextStyles.text14400
                                                .copyWith(
                                                  color:
                                                      colorScheme.secondaryText,
                                                ),
                                          ),
                                          VerticalSpace(6),
                                          buildEmbTypesContent(
                                            selectedId: decoration.embTypeId,
                                            onChanged: (value) {
                                              final selected = state.embTypes
                                                  .where(
                                                    (option) =>
                                                        option.id == value,
                                                  )
                                                  .toList();
                                              cubit.updateDecorationEmbType(
                                                item.productId,
                                                item.variantId,
                                                index,
                                                selected.isEmpty
                                                    ? null
                                                    : selected.first,
                                              );
                                            },
                                          ),
                                        ],
                                        if (isHeatTransfer) ...[
                                          VerticalSpace(12),
                                          Text(
                                            AppStrings.heatTransferTypeLabel,
                                            style: TextStyles.text14400
                                                .copyWith(
                                                  color:
                                                      colorScheme.secondaryText,
                                                ),
                                          ),
                                          VerticalSpace(6),
                                          buildHeatTransferTypeContent(
                                            selectedId:
                                                decoration.heatTransferTypeId,
                                            onChanged: (value) {
                                              final selected = state
                                                  .heatTransferTypeOptions
                                                  .where(
                                                    (option) =>
                                                        option.id == value,
                                                  )
                                                  .toList();
                                              cubit
                                                  .updateDecorationHeatTransferType(
                                                    item.productId,
                                                    item.variantId,
                                                    index,
                                                    selected.isEmpty
                                                        ? null
                                                        : selected.first,
                                                  );
                                            },
                                          ),
                                          VerticalSpace(12),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: buildHeatTransferInchesField(
                                                  label: AppStrings
                                                      .heatTransferWidthLabel,
                                                  hintText: AppStrings
                                                      .heatTransferWidthHint,
                                                  initialValue:
                                                      formatInchesValue(
                                                        decoration
                                                            .heatTransferWidth,
                                                      ),
                                                  onChanged: (value) {
                                                    final parsed =
                                                        value.trim().isEmpty
                                                        ? null
                                                        : double.tryParse(
                                                            value.trim(),
                                                          );
                                                    cubit
                                                        .updateDecorationHeatTransferWidth(
                                                          item.productId,
                                                          item.variantId,
                                                          index,
                                                          parsed,
                                                        );
                                                  },
                                                ),
                                              ),
                                              HorizontalSpace(12),
                                              Expanded(
                                                child: buildHeatTransferInchesField(
                                                  label: AppStrings
                                                      .heatTransferHeightLabel,
                                                  hintText: AppStrings
                                                      .heatTransferHeightHint,
                                                  initialValue:
                                                      formatInchesValue(
                                                        decoration
                                                            .heatTransferHeight,
                                                      ),
                                                  onChanged: (value) {
                                                    final parsed =
                                                        value.trim().isEmpty
                                                        ? null
                                                        : double.tryParse(
                                                            value.trim(),
                                                          );
                                                    cubit
                                                        .updateDecorationHeatTransferHeight(
                                                          item.productId,
                                                          item.variantId,
                                                          index,
                                                          parsed,
                                                        );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                        if (isScreenPrint) ...[
                                          VerticalSpace(12),
                                          Text(
                                            AppStrings.screenPrintColorLabel,
                                            style: TextStyles.text14400
                                                .copyWith(
                                                  color:
                                                      colorScheme.secondaryText,
                                                ),
                                          ),
                                          VerticalSpace(6),
                                          buildScreenPrintColorContent(
                                            selectedId:
                                                decoration.screenPrintColorId,
                                            onChanged: (value) {
                                              final selected = state
                                                  .screenPrintColorOptions
                                                  .where(
                                                    (option) =>
                                                        option.id == value,
                                                  )
                                                  .toList();
                                              cubit
                                                  .updateDecorationScreenPrintColor(
                                                    item.productId,
                                                    item.variantId,
                                                    index,
                                                    selected.isEmpty
                                                        ? null
                                                        : selected.first,
                                                  );
                                            },
                                          ),
                                          VerticalSpace(12),
                                          Text(
                                            AppStrings.screenPrintGarmentLabel,
                                            style: TextStyles.text14400
                                                .copyWith(
                                                  color:
                                                      colorScheme.secondaryText,
                                                ),
                                          ),
                                          VerticalSpace(6),
                                          buildScreenPrintGarmentContent(
                                            selectedId:
                                                decoration.screenPrintGarmentId,
                                            onChanged: (value) {
                                              final selected = state
                                                  .screenPrintGarmentOptions
                                                  .where(
                                                    (option) =>
                                                        option.id == value,
                                                  )
                                                  .toList();
                                              cubit
                                                  .updateDecorationScreenPrintGarment(
                                                    item.productId,
                                                    item.variantId,
                                                    index,
                                                    selected.isEmpty
                                                        ? null
                                                        : selected.first,
                                                  );
                                            },
                                          ),
                                          VerticalSpace(12),
                                          Text(
                                            AppStrings.screenPrintLocationLabel,
                                            style: TextStyles.text14400
                                                .copyWith(
                                                  color:
                                                      colorScheme.secondaryText,
                                                ),
                                          ),
                                          VerticalSpace(6),
                                          buildScreenPrintLocationContent(
                                            selectedId: decoration
                                                .screenPrintLocationId,
                                            onChanged: (value) {
                                              final selected = state
                                                  .screenPrintLocationOptions
                                                  .where(
                                                    (option) =>
                                                        option.id == value,
                                                  )
                                                  .toList();
                                              cubit
                                                  .updateDecorationScreenPrintLocation(
                                                    item.productId,
                                                    item.variantId,
                                                    index,
                                                    selected.isEmpty
                                                        ? null
                                                        : selected.first,
                                                  );
                                            },
                                          ),
                                        ],
                                        if (isLeather) ...[
                                          VerticalSpace(12),
                                          Text(
                                            AppStrings.leatherColorLabel,
                                            style: TextStyles.text14400
                                                .copyWith(
                                                  color:
                                                      colorScheme.secondaryText,
                                                ),
                                          ),
                                          VerticalSpace(6),
                                          buildLeatherColorContent(
                                            selectedId:
                                                decoration.leatherColorId,
                                            onChanged: (value) {
                                              final selected = state
                                                  .leatherColorOptions
                                                  .where(
                                                    (option) =>
                                                        option.id == value,
                                                  )
                                                  .toList();
                                              cubit
                                                  .updateDecorationLeatherColor(
                                                    item.productId,
                                                    item.variantId,
                                                    index,
                                                    selected.isEmpty
                                                        ? null
                                                        : selected.first,
                                                  );
                                            },
                                          ),
                                          VerticalSpace(12),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: buildHeatTransferInchesField(
                                                  label: AppStrings
                                                      .leatherWidthLabel,
                                                  hintText: AppStrings
                                                      .leatherWidthHint,
                                                  initialValue:
                                                      formatInchesValue(
                                                        decoration.leatherWidth,
                                                      ),
                                                  onChanged: (value) {
                                                    final parsed =
                                                        value.trim().isEmpty
                                                        ? null
                                                        : double.tryParse(
                                                            value.trim(),
                                                          );
                                                    cubit
                                                        .updateDecorationLeatherWidth(
                                                          item.productId,
                                                          item.variantId,
                                                          index,
                                                          parsed,
                                                        );
                                                  },
                                                ),
                                              ),
                                              HorizontalSpace(12),
                                              Expanded(
                                                child: buildHeatTransferInchesField(
                                                  label: AppStrings
                                                      .leatherHeightLabel,
                                                  hintText: AppStrings
                                                      .leatherHeightHint,
                                                  initialValue:
                                                      formatInchesValue(
                                                        decoration
                                                            .leatherHeight,
                                                      ),
                                                  onChanged: (value) {
                                                    final parsed =
                                                        value.trim().isEmpty
                                                        ? null
                                                        : double.tryParse(
                                                            value.trim(),
                                                          );
                                                    cubit
                                                        .updateDecorationLeatherHeight(
                                                          item.productId,
                                                          item.variantId,
                                                          index,
                                                          parsed,
                                                        );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                        if (isPatches) ...[
                                          VerticalSpace(12),
                                          Text(
                                            AppStrings.patchTypeLabel,
                                            style: TextStyles.text14400
                                                .copyWith(
                                                  color:
                                                      colorScheme.secondaryText,
                                                ),
                                          ),
                                          VerticalSpace(6),
                                          buildPatchTypeContent(
                                            selectedId: decoration.patchTypeId,
                                            onChanged: (value) {
                                              final selected = state
                                                  .patchTypeOptions
                                                  .where(
                                                    (option) =>
                                                        option.id == value,
                                                  )
                                                  .toList();
                                              cubit.updateDecorationPatchType(
                                                item.productId,
                                                item.variantId,
                                                index,
                                                selected.isEmpty
                                                    ? null
                                                    : selected.first,
                                              );
                                            },
                                          ),
                                          VerticalSpace(12),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: buildHeatTransferInchesField(
                                                  label: AppStrings
                                                      .patchWidthLabel,
                                                  hintText:
                                                      AppStrings.patchWidthHint,
                                                  initialValue:
                                                      formatInchesValue(
                                                        decoration.patchWidth,
                                                      ),
                                                  onChanged: (value) {
                                                    final parsed =
                                                        value.trim().isEmpty
                                                        ? null
                                                        : double.tryParse(
                                                            value.trim(),
                                                          );
                                                    cubit
                                                        .updateDecorationPatchWidth(
                                                          item.productId,
                                                          item.variantId,
                                                          index,
                                                          parsed,
                                                        );
                                                  },
                                                ),
                                              ),
                                              HorizontalSpace(12),
                                              Expanded(
                                                child: buildHeatTransferInchesField(
                                                  label: AppStrings
                                                      .patchHeightLabel,
                                                  hintText: AppStrings
                                                      .patchHeightHint,
                                                  initialValue:
                                                      formatInchesValue(
                                                        decoration.patchHeight,
                                                      ),
                                                  onChanged: (value) {
                                                    final parsed =
                                                        value.trim().isEmpty
                                                        ? null
                                                        : double.tryParse(
                                                            value.trim(),
                                                          );
                                                    cubit
                                                        .updateDecorationPatchHeight(
                                                          item.productId,
                                                          item.variantId,
                                                          index,
                                                          parsed,
                                                        );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                        if (isLabels) ...[
                                          VerticalSpace(12),
                                          Text(
                                            AppStrings.labelTypeLabel,
                                            style: TextStyles.text14400
                                                .copyWith(
                                                  color:
                                                      colorScheme.secondaryText,
                                                ),
                                          ),
                                          VerticalSpace(6),
                                          buildLabelTypeContent(
                                            selectedId: decoration.labelTypeId,
                                            onChanged: (value) {
                                              final selected = state
                                                  .labelTypeOptions
                                                  .where(
                                                    (option) =>
                                                        option.id == value,
                                                  )
                                                  .toList();
                                              cubit.updateDecorationLabelType(
                                                item.productId,
                                                item.variantId,
                                                index,
                                                selected.isEmpty
                                                    ? null
                                                    : selected.first,
                                              );
                                            },
                                          ),
                                          VerticalSpace(12),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: buildHeatTransferInchesField(
                                                  label: AppStrings
                                                      .labelWidthLabel,
                                                  hintText:
                                                      AppStrings.labelWidthHint,
                                                  initialValue:
                                                      formatInchesValue(
                                                        decoration.labelWidth,
                                                      ),
                                                  onChanged: (value) {
                                                    final parsed =
                                                        value.trim().isEmpty
                                                        ? null
                                                        : double.tryParse(
                                                            value.trim(),
                                                          );
                                                    cubit
                                                        .updateDecorationLabelWidth(
                                                          item.productId,
                                                          item.variantId,
                                                          index,
                                                          parsed,
                                                        );
                                                  },
                                                ),
                                              ),
                                              HorizontalSpace(12),
                                              Expanded(
                                                child: buildHeatTransferInchesField(
                                                  label: AppStrings
                                                      .labelHeightLabel,
                                                  hintText: AppStrings
                                                      .labelHeightHint,
                                                  initialValue:
                                                      formatInchesValue(
                                                        decoration.labelHeight,
                                                      ),
                                                  onChanged: (value) {
                                                    final parsed =
                                                        value.trim().isEmpty
                                                        ? null
                                                        : double.tryParse(
                                                            value.trim(),
                                                          );
                                                    cubit
                                                        .updateDecorationLabelHeight(
                                                          item.productId,
                                                          item.variantId,
                                                          index,
                                                          parsed,
                                                        );
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                        actions: [
                          OutlinedButton(
                            onPressed: (saving || isUploading)
                                ? null
                                : () {
                                    cubit.setDecorationsForItem(
                                      item.productId,
                                      item.variantId,
                                      initialDecorations,
                                    );
                                    Navigator.of(dialogContext).pop();
                                  },
                            child: Text(AppStrings.cancel),
                          ),
                          VerticalSpace(8),
                          ElevatedButton(
                            onPressed: (saving || isUploading)
                                ? null
                                : () async {
                                    isSaving.value = true;
                                    final response = await cubit
                                        .saveDecorationsForItem(
                                          cartItemId: item.cartItemId,
                                          quantity: item.quantity,
                                          productId: item.productId,
                                          variantId: item.variantId,
                                        );
                                    isSaving.value = false;
                                    response.when(
                                      success: (_) =>
                                          Navigator.of(dialogContext).pop(),
                                      failure: (error) {
                                        if (!context.mounted) return;
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              error.title ??
                                                  AppStrings.unknownError,
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                            child: saving
                                ? const SizedBox(
                                    height: 18,
                                    width: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : Text(AppStrings.saveDecorations),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      );
    },
  );
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticated = context.select<ProfileCubit, bool>(
      (cubit) => cubit.state.isAuthenticated,
    );

    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.cart)),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return const SizedBox.shrink();
          }
          final primaryActionType = isAuthenticated
              ? CheckoutType.checkout
              : CheckoutType.requestQuote;
          final primaryActionLabel = isAuthenticated
              ? AppStrings.checkout
              : AppStrings.requestQuote;

          return SafeArea(
            minimum: const EdgeInsets.all(Constants.defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlinedButton(
                  onPressed: () => context.goNamed(RouteNames.home.name),
                  child: Text(AppStrings.continueShopping),
                ),
                if (isAuthenticated) ...[
                  VerticalSpace(12),
                  OutlinedButton(
                    onPressed: () => context.pushNamed(
                      RouteNames.checkout.name,
                      extra: CheckoutType.requestQuote,
                    ),
                    child: Text(AppStrings.requestQuote),
                  ),
                ],
                VerticalSpace(12),
                ElevatedButton(
                  onPressed: () => context.pushNamed(
                    RouteNames.checkout.name,
                    extra: primaryActionType,
                  ),
                  child: Text(primaryActionLabel),
                ),
              ],
            ),
          );
        },
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          Future<ApiResponseModel<List<CartItemEntity>>> onRefresh() =>
              context.read<CartCubit>().loadCart();
          final showInitialLoading =
              state.cartStatus.isLoading && state.items.isEmpty;
          final showError = state.cartStatus.isFailure && state.items.isEmpty;
          if (showInitialLoading) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(Constants.defaultPadding),
                itemCount: 3,
                separatorBuilder: (_, _) => VerticalSpace(12),
                itemBuilder: (_, _) => const _CartItemPlaceholder(),
              ),
            );
          }
          if (showError) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(Constants.defaultPadding),
                children: [
                  const SizedBox(height: 120),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          state.cartStatus.failureMessage,
                          style: TextStyles.text14400,
                        ),
                        VerticalSpace(12),
                        ElevatedButton(
                          onPressed: () => context.read<CartCubit>().loadCart(),
                          child: Text(AppStrings.retry),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
          if (state.items.isEmpty) {
            return RefreshIndicator(
              onRefresh: onRefresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(Constants.defaultPadding),
                children: [
                  const SizedBox(height: 120),
                  Center(
                    child: Text(
                      AppStrings.cartEmpty,
                      style: TextStyles.text14400,
                    ),
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: onRefresh,
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(Constants.defaultPadding),
              itemCount: state.items.length + 1,
              separatorBuilder: (_, index) => VerticalSpace(12),
              itemBuilder: (context, index) {
                if (index == 0) {
                  final subtotal = state.items.fold<double>(
                    0,
                    (total, item) =>
                        total +
                        (item.lineTotal ??
                            (item.unitPrice ?? 0) * item.quantity),
                  );
                  return _OrderSummaryCard(
                    itemsCount: state.totalItems,
                    subtotal: subtotal,
                    total: subtotal,
                  );
                }
                final item = state.items[index - 1];
                return Dismissible(
                  key: ValueKey(
                    item.cartItemId > 0
                        ? 'cart-${item.cartItemId}'
                        : '${item.productId}-${item.variantId}',
                  ),
                  background: _DismissBackground(
                    alignment: Alignment.centerLeft,
                    icon: Icons.delete_outline,
                  ),
                  secondaryBackground: _DismissBackground(
                    alignment: Alignment.centerRight,
                    icon: Icons.delete_outline,
                  ),
                  onDismissed: (_) =>
                      context.read<CartCubit>().removeItem(item),
                  child: Container(
                    padding: const EdgeInsets.all(Constants.defaultPadding),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(
                        Constants.defaultRadius,
                      ),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outlineVariant,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).colorScheme.surfaceContainerHighest,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.outlineVariant,
                                ),
                              ),
                              child: item.imageUrl.isEmpty
                                  ? const NetworkImagePlaceholder()
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl: item.imageUrl,
                                        fit: BoxFit.cover,
                                        errorWidget: (_, _, _) =>
                                            NetworkImagePlaceholder(),
                                      ),
                                    ),
                            ),
                            HorizontalSpace(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextStyles.text14400.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  VerticalSpace(6),
                                  Text(
                                    '${AppStrings.sku}: ${item.productSku.isEmpty ? '-' : item.productSku}',
                                    style: TextStyles.text14400.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        VerticalSpace(12),
                        Row(
                          children: [
                            Text(
                              AppStrings.quantity,
                              style: TextStyles.text14400.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.secondaryText,
                              ),
                            ),
                            HorizontalSpace(12),
                            _QuantityStepper(
                              quantity: item.quantity,
                              onDecrease: item.quantity > 1
                                  ? () => context
                                        .read<CartCubit>()
                                        .updateQuantity(
                                          item.productId,
                                          item.variantId,
                                          item.quantity - 1,
                                        )
                                  : null,
                              onIncrease: () =>
                                  context.read<CartCubit>().updateQuantity(
                                    item.productId,
                                    item.variantId,
                                    item.quantity + 1,
                                  ),
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  AppStrings.unitPrice,
                                  style: TextStyles.text14400.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.secondaryText,
                                  ),
                                ),
                                VerticalSpace(4),
                                Text(
                                  item.unitPrice == null
                                      ? '-'
                                      : '\$${item.unitPrice!.toStringAsFixed(0)}',
                                  style: TextStyles.text14400.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        VerticalSpace(12),
                        Builder(
                          builder: (context) {
                            final decorations = item.decorations;
                            final hasDecorations = decorations.isNotEmpty;
                            if (!hasDecorations) {
                              return TextButton.icon(
                                onPressed: () =>
                                    _showDecorationDialog(context, item),
                                icon: const Icon(Icons.add_circle_outline),
                                label: Text(AppStrings.addDecoration),
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.decorationsLabel,
                                  style: TextStyles.text14500.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurface,
                                  ),
                                ),
                                VerticalSpace(8),
                                ...decorations.map(
                                  (decoration) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.surface,
                                        borderRadius: BorderRadius.circular(
                                          16,
                                        ),
                                        border: Border.all(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.outlineVariant,
                                        ),
                                      ),
                                      child: Text(
                                        decoration
                                                .decoration.decorationType
                                                ?.detailName ??
                                            decoration
                                                .decoration.decorationName,
                                        style: TextStyles.text14500,
                                      ),
                                    ),
                                  ),
                                ),
                                VerticalSpace(8),
                                Builder(
                                  builder: (context) {
                                    var isRemoving = false;
                                    return StatefulBuilder(
                                      builder: (context, setState) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: FilledButton.icon(
                                                onPressed: isRemoving
                                                    ? null
                                                : () => _showDecorationDialog(
                                                      context,
                                                      item,
                                                    ),
                                            icon: const Icon(
                                              Icons.edit_outlined,
                                            ),
                                            label: Text(
                                              AppStrings.updateDecoration,
                                            ),
                                            style: FilledButton.styleFrom(
                                              minimumSize: const Size(0, 48),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                          ),
                                        ),
                                        HorizontalSpace(12),
                                        Expanded(
                                          child: OutlinedButton.icon(
                                            onPressed: isRemoving
                                                ? null
                                                : () async {
                                                    setState(
                                                      () => isRemoving = true,
                                                    );
                                                    final lastDecoration =
                                                        decorations.last;
                                                    final decorationId =
                                                        lastDecoration
                                                            .decoration
                                                            .decorationId;
                                                    final response = await context
                                                        .read<CartCubit>()
                                                        .deleteDecorationById(
                                                          decorationId:
                                                              decorationId,
                                                        );
                                                    setState(
                                                      () => isRemoving = false,
                                                    );
                                                    response.when(
                                                      success: (_) {},
                                                      failure: (error) {
                                                        if (!context.mounted) {
                                                          return;
                                                        }
                                                        ScaffoldMessenger.of(
                                                          context,
                                                        ).showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              error.title ??
                                                                  AppStrings
                                                                      .unknownError,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
                                            icon: isRemoving
                                                ? const SizedBox(
                                                    height: 18,
                                                    width: 18,
                                                    child:
                                                        CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                    ),
                                                  )
                                                : const Icon(
                                                    Icons.delete_outline,
                                                    color: AppColors.red,
                                                  ),
                                            label: Text(
                                              AppStrings.removeDecoration,
                                              style:
                                                  TextStyles.text14400.copyWith(
                                                color: AppColors.red,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            style: OutlinedButton.styleFrom(
                                              minimumSize: const Size(0, 48),
                                              side: const BorderSide(
                                                color: AppColors.red,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _DismissBackground extends StatelessWidget {
  const _DismissBackground({required this.alignment, required this.icon});

  final Alignment alignment;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Theme.of(context).colorScheme.onErrorContainer),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback? onDecrease;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _StepButton(icon: Icons.remove, onPressed: onDecrease),
          const SizedBox(width: 8),
          SizedBox(
            width: 28,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: TextStyles.text14400.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _StepButton(icon: Icons.add, onPressed: onIncrease),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEnabled = onPressed != null;
    final iconColor = isEnabled
        ? colorScheme.onSurface
        : colorScheme.onSurface.withValues(alpha: 0.4);

    return SizedBox(
      width: 32,
      height: 32,
      child: Material(
        color: colorScheme.surface,
        shape: const CircleBorder(),
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: Icon(icon, size: 18, color: iconColor),
        ),
      ),
    );
  }
}

class _OrderSummaryCard extends StatelessWidget {
  final int itemsCount;
  final double subtotal;
  final double total;

  const _OrderSummaryCard({
    required this.itemsCount,
    required this.subtotal,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(Constants.defaultPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(Constants.defaultRadius),
        border: Border.all(color: theme.colorScheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.orderSummary, style: TextStyles.text17500),
          VerticalSpace(8),
          Text(
            AppStrings.cartReviewNote,
            style: TextStyles.text14400.copyWith(
              color: theme.colorScheme.secondaryText,
            ),
          ),
          VerticalSpace(12),
          _SummaryRow(
            label: AppStrings.itemsLabel,
            value: itemsCount.toString(),
          ),
          VerticalSpace(8),
          _SummaryRow(
            label: AppStrings.estimatedSubtotal,
            value: '\$${subtotal.toStringAsFixed(2)}',
          ),
          VerticalSpace(12),
          Divider(height: 1, color: theme.colorScheme.outlineVariant),
          VerticalSpace(12),
          _SummaryRow(
            label: AppStrings.totalEstimated,
            value: '\$${total.toStringAsFixed(2)}',
            emphasize: true,
          ),
          VerticalSpace(8),
          Text(
            AppStrings.orderSummaryNote,
            style: TextStyles.text14400.copyWith(
              color: theme.colorScheme.secondaryText,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final bool emphasize;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.emphasize = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = emphasize
        ? TextStyles.text16500.copyWith(color: theme.colorScheme.primary)
        : TextStyles.text14400;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style.copyWith(fontWeight: FontWeight.w500)),
        Text(value, style: style),
      ],
    );
  }
}

class _CartItemPlaceholder extends StatelessWidget {
  const _CartItemPlaceholder();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(Constants.defaultPadding),
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(Constants.defaultRadius),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 72, height: 72, child: ShimmerPlaceholder()),
              HorizontalSpace(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 14,
                      width: double.infinity,
                      color: colorScheme.surface,
                    ),
                    VerticalSpace(8),
                    Container(
                      height: 12,
                      width: 120,
                      color: colorScheme.surface,
                    ),
                  ],
                ),
              ),
            ],
          ),
          VerticalSpace(12),
          Row(
            children: [
              Container(height: 12, width: 60, color: colorScheme.surface),
              HorizontalSpace(12),
              Container(height: 28, width: 120, color: colorScheme.surface),
              const Spacer(),
              Container(height: 12, width: 70, color: colorScheme.surface),
            ],
          ),
          VerticalSpace(12),
          Divider(height: 1, color: colorScheme.outlineVariant),
          VerticalSpace(8),
          Container(height: 12, width: 200, color: colorScheme.surface),
          VerticalSpace(8),
          Container(
            height: 36,
            width: double.infinity,
            color: colorScheme.surface,
          ),
        ],
      ),
    );
  }
}
