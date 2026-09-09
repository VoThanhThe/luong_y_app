import 'package:flutter/material.dart';

import '../../shared/widgets/app_scaffold.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Thông báo',
      body: const Center(
        child: Text('Màn hình Thông báo'),
      ),
    );
  }
}