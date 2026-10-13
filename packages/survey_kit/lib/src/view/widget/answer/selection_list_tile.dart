import 'package:flutter/material.dart';

class SelectionListTile extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isSelected;
  final bool isExclusive;

  const SelectionListTile({
    Key? key,
    required this.text,
    required this.onTap,
    this.isSelected = false,
    this.isExclusive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Semantics(
        inMutuallyExclusiveGroup: isExclusive,
        checked: isSelected,
        child: Material(
          color: isSelected
              ? colorScheme.primary.withValues(alpha: 0.05)
              : colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
              width: isSelected ? 2.0 : 1.0,
            ),
          ),
          child: ListTile(
            selected: isSelected,
            selectedColor: colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14.0),
            title: Text(
              text,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: isSelected ? colorScheme.primary : null,
              ),
            ),
            trailing: isSelected
                ? Icon(Icons.check_circle, size: 28, color: colorScheme.primary)
                : const SizedBox(width: 28, height: 28),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
