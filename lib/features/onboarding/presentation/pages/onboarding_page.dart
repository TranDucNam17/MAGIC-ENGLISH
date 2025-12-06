import 'package:flutter/material.dart';
import 'package:btl_magicenglish/features/auth/presentation/pages/login_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Định nghĩa các màu sắc thương hiệu để dễ dàng tái sử dụng và quản lý
    const Color primaryBlue = Color(0xFF0D47A1); // Một màu xanh dương đậm, hiện đại
    const Color almostWhite = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);
    const Color mediumGrey = Color(0xFF6C757D);

    return Scaffold(
      // 1. General: Sử dụng Scaffold với màu nền xanh rất nhạt
      backgroundColor: almostWhite,
      body: SafeArea(
        // 2. General: Bao bọc nội dung trong SafeArea
        child: Padding(
          // 3. General: Thêm padding ngang cho nội dung chính và nút bấm
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            // 4. General: Sử dụng Column với spaceBetween để đẩy nội dung lên trên và nút xuống dưới
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 5. Hero Section: Phần trên cùng của màn hình
              const Expanded(
                child: HeroSection(),
              ),

              // 6. Bottom Button: Nút bấm ở cuối màn hình
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
                child: PrimaryButton(
                  text: 'Start',
                  onPressed: () {
                    // TODO: Điều hướng đến màn hình đăng nhập (Login Screen)
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HeroSection extends StatelessWidget {
  const HeroSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);
    const Color darkText = Color(0xFF1A252F);
    const Color mediumGrey = Color(0xFF6C757D);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // Căn giữa nội dung theo chiều dọc
      children: [
        // 7. Hero Section: Hình ảnh minh họa
        Image.asset(
          'assets/images/onboarding_hero.png',
          height: 250, // Điều chỉnh chiều cao cho phù hợp
          errorBuilder: (context, error, stackTrace) {
            // Hiển thị một placeholder nếu ảnh không tải được
            return Container(
              height: 250,
              width: 250,
              color: Colors.grey[300],
              child: const Icon(Icons.school, size: 100, color: Colors.grey),
            );
          },
        ),

        // 8. General: Thêm khoảng trống dọc
        const SizedBox(height: 48),

        // 9. Hero Section: Tên ứng dụng "MAGIC ENGLISH"
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style: TextStyle(
              fontFamily: 'Roboto', // Sử dụng font sans-serif hiện đại
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: 'MAGIC ',
                style: TextStyle(color: primaryBlue), // Màu xanh cho "MAGIC"
              ),
              TextSpan(
                text: 'ENGLISH',
                style: TextStyle(color: darkText), // Màu tối cho "ENGLISH"
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // 10. Hero Section: Phụ đề
        const Text(
          'Learn English — smarter, faster, your way',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: mediumGrey,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF0D47A1);

    return Container(
      // 11. Bottom Button: Tạo hiệu ứng đổ bóng mềm
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: primaryBlue.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        borderRadius: BorderRadius.circular(100), // Phải khớp với shape của nút
      ),
      height: 56, // Chiều cao của nút
      child: MaterialButton(
        onPressed: onPressed,
        color: primaryBlue, // Màu nền của nút
        minWidth: double.infinity, // Nút chiếm toàn bộ chiều rộng
        shape: const StadiumBorder(), // Hình dạng viên thuốc (pill/stadium)
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
