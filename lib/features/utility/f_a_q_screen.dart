import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../shared/widgets/app_scaffold.dart';
import '../../shared/widgets/mlkit_text.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({super.key});

  @override
  State<FAQScreen> createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Các vấn đề thường gặp',
      isShowBackButton: true,
      backgroundColor: AppColors.grayLightColor,
      // Tận dụng subHeader để làm thanh tìm kiếm đi kèm gradient của AppBar
      subHeader: Container(
        height: 45,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(25),
        ),
        child: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Tìm kiếm FAQs',
            hintStyle: TextStyle(color: AppColors.grayColor, fontSize: 14),
            prefixIcon: Icon(Icons.search, color: AppColors.primaryDarkColor),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: Icon(Icons.cancel, color: AppColors.grayColor),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                      });
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          ),
          onChanged: (value) {
            setState(() {}); // Cập nhật giao diện khi người dùng nhập
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildFAQCategory(
            title: 'Đăng ký khám & đặt lịch',
            questions: [
              '1. Làm thế nào để đăng ký khám qua ứng dụng Lương Y?',
              '2. Tôi có thể thay đổi hoặc hủy lịch khám không?',
              '3. Khi nào tôi nhận được xác nhận lịch khám?',
            ],
          ),
          const SizedBox(height: 12),
          _buildFAQCategory(
            title: 'Thanh toán & bảo hiểm',
            questions: [
              '1. Lương Y có hỗ trợ thanh toán trực tuyến trên ứng dụng không?',
              '2. Bệnh viện có hỗ trợ thanh toán qua bảo hiểm y tế không?',
            ],
          ),
          const SizedBox(height: 12),
          _buildFAQCategory(
            title: 'Sử dụng ứng dụng & hỗ trợ kỹ thuật',
            questions: [
              '1. Tôi quên mật khẩu đăng nhập thì làm sao?',
              '2. Cần hỗ trợ kỹ thuật thì liên hệ ai?',
            ],
          ),
          const SizedBox(height: 12),
          _buildFAQCategory(
            title: 'Liên kết và xem hồ sơ y tế',
            questions: [
              '1. Mã bệnh nhân của tôi ở đâu?',
              '2. Làm sao để liên kết hồ sơ y tế của tôi với ứng dụng Lương Y?',
              '3. Tôi đã nhập mã bệnh nhân nhưng không liên kết được?',
            ],
          ),
          const SizedBox(height: 12),
          _buildFAQCategory(
            title: 'Tài khoản',
            questions: [
              '1. Tôi quên mật khẩu thì phải làm sao?',
              '2. Tôi có thể dùng cùng một tài khoản Lương Y để xem hồ sơ của người thân không?',
              '3. Ứng dụng Lương Y có thu phí không?',
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFAQCategory({
    required String title,
    required List<String> questions,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha((0.03 * 255).toInt()),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        initiallyExpanded: true, // <--- Mặc định mở (xổ ra) hết
        shape: const Border(), // <--- Xóa đường border khi mở
        collapsedShape: const Border(), // <--- Xóa đường border khi thu gọn
        title: MlKitText(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryDarkColor,
          ),
        ),
        iconColor: AppColors.primaryDarkColor,
        collapsedIconColor: AppColors.grayColor,
        children: List.generate(questions.length, (index) {
          return Column(
            children: [
              // Chỉ hiển thị Divider giữa các câu hỏi bên trong (từ phần tử thứ 2 trở đi)
              if (index > 0)
                const Divider(
                  height: 1,
                  thickness: 0.5,
                  indent: 16,
                  endIndent: 16,
                ),
              ListTile(
                title: MlKitText(
                  questions[index],
                  style: const TextStyle(fontSize: 13.5, color: Colors.black87),
                ),
                onTap: () {
                  // Xử lý xem chi tiết câu trả lời
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
