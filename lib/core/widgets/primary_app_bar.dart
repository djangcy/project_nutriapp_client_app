import 'package:flutter/material.dart';

class PrimaryAppBar extends StatefulWidget implements PreferredSizeWidget {
  const PrimaryAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<PrimaryAppBar> createState() => _PrimaryAppBarState();
}

class _PrimaryAppBarState extends State<PrimaryAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
