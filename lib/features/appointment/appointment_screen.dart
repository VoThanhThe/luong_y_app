import 'package:flutter/material.dart';

import '../../shared/widgets/app_scaffold.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Lịch hẹn',
      action: IconButton(
        icon: const Icon(Icons.add_circle, color: Colors.white, size: 36),
        onPressed: () {
          // Thêm hành động khi nhấn nút thêm lịch hẹn
          // Ví dụ: Điều hướng đến màn hình tạo lịch hẹn mới
          // Navigator.of(context).push(MaterialPageRoute(builder: (context) => CreateAppointmentScreen()));
        },
      ),
      body: const Center(
        child: Text('Màn hình Lịch hẹn'),
      ),
    );
  }
}