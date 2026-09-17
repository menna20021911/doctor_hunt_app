import 'package:flutter/material.dart';

import '../../../../generated/app_colore.dart';
import '../../../../generated/app_text.dart';
import '../../../../generated/image_assets.dart';
import '../../../../generated/style_atom.dart';
import '../widgets/role_card_widget.dart';
import 'Home_screen.dart';

class ChoseRoleScreen extends StatefulWidget {
  const ChoseRoleScreen({super.key, this.onContinue});

  final ValueChanged<UserRole>? onContinue;

  @override
  State<ChoseRoleScreen> createState() => _ChoseRoleScreenState();
}

class _ChoseRoleScreenState extends State<ChoseRoleScreen> {
  UserRole _selectedRole = UserRole.patient;

  void _continue() {
    if (widget.onContinue != null) {
      widget.onContinue!(_selectedRole);
      return;
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.screenTopGlow,
                AppColors.white,
                AppColors.mintGlow,
              ],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final contentWidth =
                    (constraints.maxWidth * .86).clamp(300.0, 390.0).toDouble();
                final logoWidth =
                    (constraints.maxWidth * .45).clamp(160.0, 200.0).toDouble();
                return Center(
                  child: SizedBox(
                    width: contentWidth,
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(vertical: 34),
                      child: Column(
                        children: [
                          Image.asset(
                            ImageAssets.logo,
                            width: logoWidth,
                            semanticLabel: AppText.appName,
                          ),
                          const SizedBox(height: 52),
                          const Text(
                            AppText.chooseYourRole,
                            style: AppTextStyles.roleTitle,
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            AppText.roleDescription,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.description,
                          ),
                          const SizedBox(height: 31),
                          RoleCardWidget(
                            role: UserRole.patient,
                            isSelected: _selectedRole == UserRole.patient,
                            onTap: () => setState(
                                () => _selectedRole = UserRole.patient),
                          ),
                          const SizedBox(height: 14),
                          RoleCardWidget(
                            role: UserRole.admin,
                            isSelected: _selectedRole == UserRole.admin,
                            onTap: () =>
                                setState(() => _selectedRole = UserRole.admin),
                          ),
                          const SizedBox(height: 116),
                          SizedBox(
                            height: 54,
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: _continue,
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.primary,
                                foregroundColor: AppColors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                AppText.continueButton,
                                style: AppTextStyles.button,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
}