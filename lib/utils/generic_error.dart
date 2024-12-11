import 'package:flutter/material.dart';

class GenericError extends StatelessWidget {
  const GenericError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error, color: Colors.red),
          Text(
            'An error has occurred.',
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }
}
