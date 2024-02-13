import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrition_app/features/profile/profile.dart';

class GreetingTitleWidget extends ConsumerStatefulWidget {
  const GreetingTitleWidget({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _GreetingTitleWidgetState();
}

class _GreetingTitleWidgetState extends ConsumerState<GreetingTitleWidget> {
  String? _greeting;
  String? _name;

  void _loadGreetingText() {
    final now = DateTime.now();
    String text = 'Good';
    if (now.hour < 12) {
      text += ' Morning';
    } else {
      text += ' Evening';
    }

    setState(() {
      _greeting = text;
    });
  }

  void _loadName() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await ref.read(currentProfileController.notifier).getProfile();

      setState(() {
        _name = ref.read(currentProfileProvider)?.name ?? '';
      });
    });
  }

  @override
  void initState() {
    _loadGreetingText();
    _loadName();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: _greeting ?? 'Good Morning',
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontWeight: FontWeight.w400),
        children: [
          TextSpan(
            text: '\n$_name',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
