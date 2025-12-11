// lib/presentation/auth/register_page.dart

import 'package:flutter/material.dart';
import 'package:btl_magicenglish/features/auth/presentation/pages/register_success_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers để quản lý dữ liệu trong các trường text
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Biến trạng thái để ẩn/hiện mật khẩu
  bool _isPasswordObscured = true;
  bool _isConfirmPasswordObscured = true;

  @override
  void dispose() {
    // Giải phóng controllers khi widget bị hủy để tránh rò rỉ bộ nhớ
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Hàm xử lý sự kiện khi nhấn nút "Register"
  void _onRegisterPressed() {
    // TODO: Thêm logic kiểm tra (validation) và gọi API đăng ký ở đây
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterSuccessPage()));
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF4A90E2); // Màu xanh dương chính
    const Color lightBlueBackground = Color(0xFFF3F6FF); // Màu nền
    const Color darkText = Color(0xFF1A252F);
    const Color greyText = Color(0xFF5A6B7B);

    return Scaffold(
      backgroundColor: lightBlueBackground,
      appBar: AppBar(
        // AppBar trong suốt để nút back vẫn hoạt động trên nền
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Center(
          // Center để căn giữa nội dung
          child: ConstrainedBox(
            // Giới hạn chiều rộng tối đa để trông đẹp trên web/tablet
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  // Phần Logo
                  _buildBrandLogo(),
                  const SizedBox(height: 12),
                  // Tiêu đề
                  const Text(
                    "Register",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: primaryBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Form Fields
                  // 1. Email
                  _buildTextField(
                    label: "Email",
                    controller: _emailController,
                    hintText: "abcabc@gmail.com",
                    prefixIcon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  // 2. Mật khẩu
                  _buildTextField(
                    label: "Password",
                    controller: _passwordController,
                    prefixIcon: Icons.lock_outline,
                    isObscured: _isPasswordObscured,
                    onToggleVisibility: () {
                      setState(() {
                        _isPasswordObscured = !_isPasswordObscured;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  // 3. Xác nhận mật khẩu
                  _buildTextField(
                    label: "Confirm password",
                    controller: _confirmPasswordController,
                    prefixIcon: Icons.lock_outline,
                    isObscured: _isConfirmPasswordObscured,
                    onToggleVisibility: () {
                      setState(() {
                        _isConfirmPasswordObscured =
                        !_isConfirmPasswordObscured;
                      });
                    },
                  ),
                  const SizedBox(height: 32),

                  // Nút Đăng ký
                  _buildRegisterButton(),
                  const SizedBox(height: 40), // Khoảng trống ở dưới cùng
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // --- WIDGETS CON ---

  // Widget xây dựng Logo
  Widget _buildBrandLogo() {
    return RichText(
      textAlign: TextAlign.center,
      text: const TextSpan(
        style: TextStyle(
          fontFamily: 'Roboto', // hoặc 'Inter'
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: "MAGIC",
            style: TextStyle(color: Color(0xFF4A90E2)),
          ),
          TextSpan(
            text: "ENGLISH",
            style: TextStyle(color: Color(0xFF1A252F)),
          ),
        ],
      ),
    );
  }

  // Widget xây dựng một trường nhập liệu (tái sử dụng)
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData prefixIcon,
    String? hintText,
    TextInputType? keyboardType,
    bool isObscured = false,
    VoidCallback? onToggleVisibility,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF5A6B7B),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isObscured,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(prefixIcon, color: Colors.grey),
            suffixIcon: onToggleVisibility != null
                ? IconButton(
              icon: Icon(
                isObscured ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: onToggleVisibility,
            )
                : null,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide:
              const BorderSide(color: Color(0xFF4A90E2), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  // Widget xây dựng nút đăng ký
  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: _onRegisterPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4A90E2), // Màu nền chính
        foregroundColor: Colors.white, // Màu chữ
        minimumSize: const Size(double.infinity, 52), // Chiều cao
        shape: const StadiumBorder(), // Bo tròn dạng viên thuốc
        elevation: 4, // Đổ bóng
        shadowColor: const Color(0xFF4A90E2).withOpacity(0.4),
      ),
      child: const Text(
        "Register",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
