import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/localization/locale_cubit.dart';
import '../../../../core/widgets/app_bottom_nav_bar.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../../../profile/presentation/cubit/profile_cubit.dart';
import '../../../profile/presentation/cubit/profile_state.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../widgets/change_password_sheet.dart';
import 'privacy_policy_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          context.tr('logout_dialog_title'),
          style: const TextStyle(
            color: AppColors.title,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          context.tr('logout_dialog_desc'),
          style: const TextStyle(
            color: AppColors.body,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              context.tr('cancel'),
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: Text(
              context.tr('ok'),
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguageSelector() {
    final currentLocale = context.read<LocaleCubit>().state.languageCode;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              context.tr('select_language'),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.title,
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('English'),
              trailing: currentLocale == 'en'
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                context.read<LocaleCubit>().setLocale(const Locale('en'));
                Navigator.pop(bottomSheetContext);
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('العربية'),
              trailing: currentLocale == 'ar'
                  ? const Icon(Icons.check, color: AppColors.primary)
                  : null,
              onTap: () {
                context.read<LocaleCubit>().setLocale(const Locale('ar'));
                Navigator.pop(bottomSheetContext);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Bottom subtle mint glow gradient matching Figma
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 220,
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      AppColors.mintGlow.withValues(alpha: 0.6),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  // Title "Settings"
                  Text(
                    context.tr('settings'),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.title,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // User Profile Card
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, profile) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const ProfileScreen(),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFE5E7EB),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              // Circular Avatar
                              ClipOval(
                                child: Image.asset(
                                  profile.image,
                                  width: 54,
                                  height: 54,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 14),

                              // Name & Email
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      profile.name,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.title,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      profile.email,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: AppColors.body,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Trailing arrow (auto-mirrored in RTL)
                              const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 16,
                                color: AppColors.body,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Section: Account settings
                  Text(
                    context.tr('account_settings'),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.body,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Change Password Row
                  _buildSettingTile(
                    icon: Icons.lock_outline_rounded,
                    iconColor: const Color(0xFFF15B5D),
                    iconBgColor: const Color(0xFFFEECEC),
                    title: context.tr('change_password'),
                    onTap: () => ChangePasswordSheet.show(context),
                  ),

                  const SizedBox(height: 10),

                  // Notifications Row
                  _buildSettingTile(
                    icon: Icons.notifications_none_rounded,
                    iconColor: AppColors.primary,
                    iconBgColor: const Color(0xFFE8F8F3),
                    title: context.tr('notifications'),
                    trailing: Switch.adaptive(
                      value: _notificationsEnabled,
                      activeTrackColor: AppColors.primary,
                      onChanged: (val) {
                        setState(() => _notificationsEnabled = val);
                      },
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Privacy Policy Row
                  _buildSettingTile(
                    icon: Icons.privacy_tip_outlined,
                    iconColor: const Color(0xFFFF9800),
                    iconBgColor: const Color(0xFFFFF4EC),
                    title: context.tr('privacy_policy'),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PrivacyPolicyScreen(),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // Section: More options
                  Text(
                    context.tr('more_options'),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.body,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Languages Row
                  _buildOptionRow(
                    title: context.tr('languages'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          context.tr('current_language'),
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.body,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 14,
                          color: AppColors.body,
                        ),
                      ],
                    ),
                    onTap: _showLanguageSelector,
                  ),

                  const SizedBox(height: 10),

                  // Build version Row
                  _buildOptionRow(
                    title: context.tr('build_version'),
                    trailing: const Text(
                      'v1.0.0',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.body,
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Logout Button
                  InkWell(
                    onTap: _showLogoutDialog,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      height: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBFB),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFFEECEC),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.logout_rounded,
                            color: Color(0xFFF15B5D),
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            context.tr('logout'),
                            style: const TextStyle(
                              color: Color(0xFFF15B5D),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }

  Widget _buildSettingTile({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.title,
                ),
              ),
            ),
            trailing ??
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 14,
                  color: AppColors.body,
                ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionRow({
    required String title,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.title,
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
