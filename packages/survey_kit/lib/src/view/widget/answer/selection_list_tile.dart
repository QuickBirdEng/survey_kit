import 'package:flutter/material.dart';

class SelectionListTile extends StatelessWidget {
  final String text;
  final Function() onTap;
  final bool isSelected;

  const SelectionListTile({
    Key? key,
    required this.text,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      // The background lives on a Material (not a decorated Container) so the
      // ListTile's ink splashes stay visible.
      child: Material(
        color: isSelected
            ? Theme.of(context).primaryColor.withValues(alpha: 0.05)
            : Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: isSelected
                ? Theme.of(context).primaryColor
                : Colors.grey.shade300,
            width: isSelected ? 2.0 : 1.0,
          ),
        ),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14.0, vertical: 0.0),
          title: Text(
            text,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).textTheme.titleLarge?.color,
                ),
          ),
          trailing: isSelected
              ? Icon(
                  Icons.check_circle,
                  size: 28,
                  color: Theme.of(context).primaryColor,
                )
              : const SizedBox(
                  width: 28,
                  height: 28,
                ),
          onTap: onTap,
        ),
      ),
    );
  }
}
