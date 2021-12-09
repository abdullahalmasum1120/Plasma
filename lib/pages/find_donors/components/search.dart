import 'package:blood_donation/components/constant/colors.dart';
import 'package:blood_donation/components/constant/size.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final TextEditingController controller;
  final IconData suffixIcon;

  const SearchBar({
    Key? key,
    required this.context,
    required this.onChanged,
    required this.onClear,
    required this.controller,
    required this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MySizes.defaultSpace / 2),
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.text,
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(MySizes.defaultRadius),
              ),
              contentPadding: const EdgeInsets.all(MySizes.defaultSpace / 2),
              hintText: "Search donor",
              fillColor: MyColors.primary.withOpacity(0.05),
              filled: true,
              prefixIcon: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.filter_list),
              ),
              suffixIcon: IconButton(
                onPressed: onClear,
                icon: Icon(
                  suffixIcon,
                  color: (suffixIcon == Icons.search)
                      ? MyColors.grey
                      : MyColors.primary,
                ),
              ),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
