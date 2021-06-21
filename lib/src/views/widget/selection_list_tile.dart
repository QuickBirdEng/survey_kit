import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectionListTile extends StatelessWidget {
  final String text;
  final Function onTap;
  final bool isSelected;

  const SelectionListTile({
    Key? key,
    required this.text,
    required this.onTap,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0),
          child: ListTile(
            title: Text(
              text,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                  ),
            ),
            trailing: isSelected
                ? Icon(
                    Icons.check,
                    size: 32.0,
                    color: isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.black,
                  )
                : Container(
                    width: 0.0,
                    height: 0.0,
                  ),
            onTap: () => onTap.call(),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}
