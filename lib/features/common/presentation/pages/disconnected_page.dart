import 'package:flutter/material.dart';
class DisconnectedPage extends StatelessWidget {
  /// Callback được gọi khi người dùng nhấn nút "Retry".
  /// Thường sẽ là một hàm để thử gọi lại API hoặc kiểm tra kết nối mạng.
  final VoidCallback onRetry;

  const DisconnectedPage({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    // --- Hệ thống màu sắc nhất quán với các giao diện trước ---
    const Color primaryBlue = Color(0xFF3B82F6); // Giống màu trong AccountSettings
    const Color lightBackground = Color(0xFFF3F5F9); // Nền xám xanh nhạt
    const Color darkText = Color(0xFF1A252F);
    const Color greyText = Color(0xFF5A6B7B);

    return Scaffold(
      backgroundColor: lightBackground,
      body: SafeArea(
        child: Center(
          // Giới hạn chiều rộng để tối ưu cho web
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Biểu tượng lớn, trực quan
                  Icon(
                    Icons.wifi_off_rounded,
                    size: 100,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 24),

                  // 2. Tiêu đề thông báo lỗi
                  const Text(
                    'No Internet Connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: darkText,
                      fontFamily: 'Roboto', // Hoặc 'Inter'
                    ),
                  ),
                  const SizedBox(height: 12),

                  // 3. Mô tả ngắn gọn, thân thiện
                  const Text(
                    'Please check your internet connection and try again. Magic English needs the internet to work its magic!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: greyText,
                      fontFamily: 'Roboto',
                      height: 1.5, // Tăng khoảng cách giữa các dòng cho dễ đọc
                    ),
                  ),
                  const SizedBox(height: 40),

                  // 4. Nút hành động chính "Retry"
                  ElevatedButton(
                    onPressed: onRetry,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25), //
                      ),
                      elevation: 4,
                      shadowColor: primaryBlue.withOpacity(0.4),
                    ),
                    child: const Text(
                      'Retry',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
