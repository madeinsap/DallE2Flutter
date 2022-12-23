import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../resource/app_constant.dart';

class ComponentLoading extends StatelessWidget {
  const ComponentLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Loading',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Lottie.asset(searchingAnim),
          Text(
            'Please wait...',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}