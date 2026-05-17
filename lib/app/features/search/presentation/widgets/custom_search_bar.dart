import 'package:aqar360/app/core/constants/app_colors.dart';
import 'package:aqar360/app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onFilterTap;
  const CustomSearchBar({
    super.key,
    required this.controller,
    required this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            style: Theme.of(context).textTheme.titleMedium,

            decoration: InputDecoration(
              hint: Text(AppStrings.hSearch),

              prefixIcon: Icon(Icons.search),
              suffixIcon: Card(
                color: Theme.of(context).colorScheme.primary,

                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: IconButton(
                    onPressed: () => onFilterTap(controller.text),
                    icon: Icon(
                      Icons.filter_alt_outlined,
                      size: 30,
                      color: AppColors.backgroundWhite,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
