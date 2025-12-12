// lib/presentation/premium/update_to_premium_page.dart

import 'package:flutter/material.dart';

/// Một màn hình giới thiệu và mời người dùng nâng cấp lên gói Premium.
/// Hiển thị các lợi ích của gói cao cấp và một nút kêu gọi hành động rõ ràng.
class UpdateToPremiumPage extends StatelessWidget {
  const UpdateToPremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    // --- Hệ thống màu sắc nhất quán ---
    const Color primaryBlue = Color(0xFF3B82F6);
    const Color lightBackground = Color(0xFFF3F5F9);
    const Color darkText = Color(0xFF1A252F);
    const Color greyText = Color(0xFF5A6B7B);
    const Color goldColor = Color(0xFFFFD700);

    return Scaffold(
      backgroundColor: lightBackground,
      // 1. AppBar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: darkText),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Magic English Premium',
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      // 2. Body
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              children: [
                // Phần nội dung có thể cuộn
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // --- Header ---
                        _buildHeader(),
                        const SizedBox(height: 24),

                        // --- Danh sách lợi ích ---
                        _buildBenefitItem(
                          icon: Icons.auto_awesome,
                          iconColor: primaryBlue,
                          title: 'Unlimited AI Assistant',
                          description: 'Get instant feedback and practice conversations without limits.',
                        ),
                        _buildBenefitItem(
                          icon: Icons.menu_book,
                          iconColor: Colors.green,
                          title: 'Advanced Grammar Lessons',
                          description: 'Unlock exclusive lessons for B2, C1, and C2 levels.',
                        ),
                        _buildBenefitItem(
                          icon: Icons.ad_units_outlined,
                          iconColor: Colors.redAccent,
                          title: 'Ad-Free Experience',
                          description: 'Focus on your learning without any interruptions.',
                        ),
                        _buildBenefitItem(
                          icon: Icons.analytics_outlined,
                          iconColor: Colors.purple,
                          title: 'In-depth Progress Tracking',
                          description: 'See detailed reports on your vocabulary and skill improvements.',
                        ),
                        _buildBenefitItem(
                          icon: Icons.star_border_rounded,
                          iconColor: goldColor,
                          title: 'Early Access to New Features',
                          description: 'Be the first to try new tools and lessons.',
                        ),
                      ],
                    ),
                  ),
                ),
                // --- Phần nút bấm ở dưới cùng ---
                _buildBottomBar(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget cho phần Header
  Widget _buildHeader() {
    return const Column(
      children: [
        Icon(
          Icons.workspace_premium_rounded,
          size: 80,
          color: Color(0xFF3B82F6),
        ),
        SizedBox(height: 16),
        Text(
          'Go Premium',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A252F),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Unlock your full potential and learn faster with exclusive features.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF5A6B7B),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  // Widget cho một mục lợi ích
  Widget _buildBenefitItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A252F),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF5A6B7B),
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget cho thanh thanh toán dưới cùng
  Widget _buildBottomBar(BuildContext context) {
    const Color primaryBlue = Color(0xFF3B82F6);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -10),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "\$9.99",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A252F),
                ),
              ),
              SizedBox(width: 8),
              Text(
                "/ month",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF5A6B7B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement payment logic
              print("Upgrade Now button pressed!");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              shadowColor: primaryBlue.withOpacity(0.4),
            ),
            child: const Text(
              'Upgrade Now',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
