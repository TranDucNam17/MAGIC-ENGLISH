// lib/presentation/settings/account_settings_page.dart

import 'package:flutter/material.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  State<AccountSettingsPage> createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  // Controllers để quản lý dữ liệu trong các trường text
  final _nameController = TextEditingController(text: "Username");
  final _emailController = TextEditingController(text: "username@email.com");
  final _phoneController = TextEditingController(text: "0123456789");

  bool _isEditing = false; // Trạng thái để bật/tắt chế độ chỉnh sửa

  @override
  void dispose() {
    // Giải phóng controllers khi widget bị hủy
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Hàm xử lý sự kiện khi nhấn nút "Save Changes"
  void _onSaveChanges() {
    // TODO: Thêm logic kiểm tra (validation) và gọi API để lưu thay đổi
    print("Saving changes...");
    setState(() {
      _isEditing = false; // Tắt chế độ chỉnh sửa sau khi lưu
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Your changes have been saved.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Định nghĩa các màu sắc và style để nhất quán với ProfilePage
    const Color primaryBlue = Color(0xFF4A90E2);
    const Color lightBackground = Color(0xFFF7F9FC);
    const Color darkText = Color(0xFF1A252F);

    return Scaffold(
      backgroundColor: lightBackground,
      // 1. AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 2.0,
        shadowColor: Colors.grey.withOpacity(0.2),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Account Settings',
          style: TextStyle(
              color: darkText, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
        // Nút Edit/Cancel ở góc phải
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
            },
            child: Text(
              _isEditing ? "Cancel" : "Edit",
              style: const TextStyle(
                color: primaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          // Center và ConstrainedBox để tối ưu giao diện trên màn hình lớn
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: SingleChildScrollView(
              padding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // --- CÁC TRƯỜNG THÔNG TIN ---
                  _buildTextField(
                    label: "Full Name",
                    controller: _nameController,
                    icon: Icons.person_outline,
                    isEditable: _isEditing,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: "Email Address",
                    controller: _emailController,
                    icon: Icons.mail_outline,
                    isEditable: _isEditing,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  _buildTextField(
                    label: "Phone Number",
                    controller: _phoneController,
                    icon: Icons.phone_outlined,
                    isEditable: _isEditing,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 32),

                  // Nút thay đổi mật khẩu
                  _buildActionButton(
                    text: "Change Password",
                    onTap: () {
                      // TODO: Điều hướng đến trang thay đổi mật khẩu
                      print("Navigating to Change Password page...");
                    },
                    icon: Icons.lock_outline,
                  ),
                  const SizedBox(height: 12),

                  // Nút xóa tài khoản
                  _buildActionButton(
                    text: "Delete Account",
                    onTap: () {
                      // TODO: Hiển thị dialog xác nhận xóa tài khoản
                      print("Showing delete account confirmation...");
                    },
                    icon: Icons.delete_outline,
                    isDestructive: true, // Style màu đỏ cho hành động nguy hiểm
                  ),
                  const SizedBox(height: 32),

                  // Nút "Save Changes" chỉ hiển thị khi đang ở chế độ chỉnh sửa
                  if (_isEditing)
                    ElevatedButton(
                      onPressed: _onSaveChanges,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBlue,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        shadowColor: primaryBlue.withOpacity(0.4),
                      ),
                      child: const Text(
                        "Save Changes",
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

  // --- WIDGETS CON TÁI SỬ DỤNG ---

  // Widget xây dựng một trường nhập liệu có thể chỉnh sửa
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool isEditable = false,
    TextInputType? keyboardType,
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
          enabled: isEditable, // Chỉ cho phép sửa khi isEditable = true
          keyboardType: keyboardType,
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.grey),
            filled: true,
            // Thay đổi màu nền dựa trên trạng thái chỉnh sửa
            fillColor: isEditable ? Colors.white : Colors.grey.shade100,
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
            // Style khi bị vô hiệu hóa
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
          ),
        ),
      ],
    );
  }

  // Widget xây dựng một nút hành động trong danh sách
  Widget _buildActionButton({
    required String text,
    required VoidCallback onTap,
    required IconData icon,
    bool isDestructive = false,
  }) {
    final color = isDestructive ? Colors.red.shade700 : const Color(0xFF1A252F);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Row(
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
              ),
              Icon(Icons.chevron_right, color: color),
            ],
          ),
        ),
      ),
    );
  }
}
