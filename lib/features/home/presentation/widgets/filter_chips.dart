import 'package:apo/core/constants/constants.dart';
import 'package:apo/core/helpers/spacing.dart';
import 'package:apo/core/themes/text_styles.dart';
import 'package:flutter/material.dart';

class FilterChips extends StatelessWidget {
  final List<String> filters;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  const FilterChips({
    super.key,
    required this.filters,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: const EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: 50,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
          itemCount: 3,
          separatorBuilder: (context, _) => const HorizontalSpace(10),
          itemBuilder: (context, index) {
            final isSelected = index == selectedIndex;
            return ChoiceChip(
              showCheckmark: false,
              visualDensity: VisualDensity.compact,
              padding: EdgeInsets.zero,
              selected: isSelected,
              onSelected: (_) => onSelected(index),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(60),
              ),
              backgroundColor: isSelected
                  ? Theme.of(context).colorScheme.secondaryFixedDim
                  : Theme.of(context).colorScheme.surface,
              labelPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              label: Text(filters[index]),
              labelStyle: isSelected
                  ? TextStyles.text14700
                  : TextStyles.text14400,
              selectedColor: Theme.of(context).colorScheme.secondary,
              side: isSelected
                  ? BorderSide.none
                  : BorderSide(color: Theme.of(context).colorScheme.outline),
            );
          },
        ),
      ),
    );
  }
}
