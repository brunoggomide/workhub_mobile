import 'package:flutter/material.dart';

class profileDetail extends StatelessWidget {
  const profileDetail({
    super.key,
    required this.onPressed,
    required this.title,
    required this.value,
    required this.icon,
  });

  final VoidCallback onPressed;
  final String title, value;
  final bool icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                )),
            Expanded(
                flex: 5,
                child: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis,
                )),
            icon == true
                ? const Expanded(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    ),
                  )
                : const Expanded(
                    child: SizedBox.shrink(),
                  )
          ],
        ),
      ),
    );
  }
}
