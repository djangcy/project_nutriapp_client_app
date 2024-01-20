import 'package:flutter/material.dart';

class PrimaryFullSearchBar extends StatelessWidget {
  const PrimaryFullSearchBar({
    super.key,
    this.controller,
    this.hintText,
    this.focusNode,
    this.leading = const Icon(Icons.search),
    this.trailing = const [],
    this.onTap,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController? controller;
  final String? hintText;
  final FocusNode? focusNode;
  final Widget leading;
  final Iterable<Widget> trailing;

  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      focusNode: focusNode,
      hintText: hintText,
      hintStyle: MaterialStateProperty.all(
        TextStyle(
          fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize,
        ),
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 12),
      ),
      leading: leading,
      trailing: trailing,
      onTap: onTap,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
    );
  }
}
