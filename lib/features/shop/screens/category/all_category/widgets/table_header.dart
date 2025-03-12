import 'package:danastoreadminpanel/utils/constants/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TTableHeader extends StatelessWidget {
  const TTableHeader({
    super.key,
    this.onPressed,
    this.buttonText = 'Add',
    this.searchController,
    this.searchOnChanged,
    this.showSearchField = true,
    this.showLeftWidget = true,
    });

    final Function()? onPressed;
    final String buttonText;

    final bool showLeftWidget;
    final TextEditingController? searchController;
    final Function(String)? searchOnChanged;
    final bool showSearchField; 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: TDeviceUtils.isDesktopScreen(context) ? 2 : 1,
            child: showLeftWidget 
            ? Row(
              children: [
                SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: onPressed,
                        child: Text(buttonText))),
              ],
            )
            : const SizedBox.shrink()),
        if (showSearchField)
        Expanded(
          flex: TDeviceUtils.isDesktopScreen(context) ? 2 : 1,
          child: TextFormField(
            controller: searchController,
            onChanged: searchOnChanged,
            decoration: const InputDecoration(
                hintText: 'Search Categories',
                prefixIcon: Icon(Iconsax.search_normal)),
          ),
        ),
      ],
    );
  }
}
