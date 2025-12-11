// lib/presentation/dashboard/profile_page.dart

import 'package:btl_magicenglish/features/settings/presentation/pages/account_settings_page.dart';
import 'package:flutter/material.dart';

// SỬA: Biến ProfilePage thành một StatelessWidget không chứa Scaffold
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // Placeholder function for navigation
  void _navigateTo(BuildContext context, String page) {
    // TODO: Implement navigation logic
    print("Navigating to $page");
  }

  @override
  Widget build(BuildContext context) {
    // Định nghĩa các màu sắc và style để dễ quản lý
    const Color primaryBlue = Color(0xFF4A90E2);
    const Color darkText = Color(0xFF1A252F);

    // SỬA: Bỏ Scaffold, trả về trực tiếp nội dung chính của trang
    return SafeArea(
      child: Center(
        // Center và ConstrainedBox để tối ưu giao diện trên màn hình lớn
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              children: [
                // --- CÁC PHẦN CỦA GIAO DIỆN (Nội dung bên trong không đổi) ---
                _buildAvatarSection(context),
                const SizedBox(height: 20),
                _buildStatsGrid(context),
                const SizedBox(height: 20),
                _buildMenuList(context),
                const SizedBox(height: 20),
                _buildPremiumButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- CÁC WIDGET CON CHO TỪNG PHẦN (Giữ nguyên không thay đổi) ---

  // Section 1: Avatar và thông tin cơ bản
  Widget _buildAvatarSection(BuildContext context) {
    const Color primaryBlue = Color(0xFF4A90E2);
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            const CircleAvatar(
              radius: 48,
              backgroundColor: primaryBlue,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 14,
                  backgroundColor: primaryBlue,
                  child: Icon(Icons.edit, color: Colors.white, size: 16),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        const Text(
          "Username",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        const Text(
          "username@email.com",
          style: TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.local_fire_department, color: Colors.orange, size: 16),
              SizedBox(width: 4),
              Text(
                "12-days streak",
                style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Section 2: Lưới thống kê
  Widget _buildStatsGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _StatCard(label: "Words learned", value: "120")),
            const SizedBox(width: 8),
            Expanded(child: _StatCard(label: "Grammar level", value: "B2")),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _StatCard(label: "Daily streak", value: "12 days")),
            const SizedBox(width: 8),
            Expanded(child: _StatCard(label: "Achievements", value: "8")),
          ],
        ),
      ],
    );
  }

  // Section 3: Danh sách menu
  Widget _buildMenuList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
          )
        ],
      ),
      child: Column(
        children: [
          _MenuItem(
              icon: Icons.person_outline,
              title: "Account Settings",
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AccountSettingsPage()));
              }),
          _MenuItem(icon: Icons.show_chart, title: "Learning Progress", onTap: () => _navigateTo(context, "Progress")),
          _MenuItem(icon: Icons.emoji_events_outlined, title: "Achievement", onTap: () => _navigateTo(context, "Achievement")),
          _MenuItem(icon: Icons.lock_outline, title: "Privacy & Security", onTap: () => _navigateTo(context, "Privacy")),
          _MenuItem(icon: Icons.settings_outlined, title: "Settings", hasDivider: false, onTap: () => _navigateTo(context, "Settings")),
        ],
      ),
    );
  }

  // Section 4: Nút Update to Premium
  Widget _buildPremiumButton(BuildContext context) {
    const Color primaryBlue = Color(0xFF4A90E2);
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 48),
        shape: const StadiumBorder(),
        elevation: 4,
        shadowColor: primaryBlue.withOpacity(0.4),
      ),
      child: const Text(
        "Update to Premium",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// --- WIDGETS CON TÁI SỬ DỤNG (Giữ nguyên) ---

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool hasDivider;

  const _MenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.hasDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              child: Row(
                children: [
                  Icon(icon, color: Colors.grey[600]),
                  const SizedBox(width: 16),
                  Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
            if (hasDivider)
              Divider(height: 1, thickness: 1, indent: 16, color: Colors.grey[100]),
          ],
        ),
      ),
    );
  }
}
