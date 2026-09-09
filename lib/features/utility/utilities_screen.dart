import 'package:flutter/material.dart';

import '../../shared/widgets/app_scaffold.dart';

class UtilitiesScreen extends StatefulWidget {
  const UtilitiesScreen({super.key});

  @override
  State<UtilitiesScreen> createState() => _UtilitiesScreenState();
}

class _UtilitiesScreenState extends State<UtilitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Tiện ích',
      body: const Center(
        child: Text('Màn hình Tiện ích'), 
      )
    );
  }
}