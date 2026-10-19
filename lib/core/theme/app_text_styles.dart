import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

abstract final class AppTextStyles {
  static const title = TextStyle(fontSize: 24, height: 1.25, fontWeight: FontWeight.w700, color: AppColors.title);
  static const description = TextStyle(fontSize: 12, height: 1.7, color: AppColors.body);
  static const button = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
  static const skip = TextStyle(fontSize: 12, color: AppColors.body);
  static const roleTitle = TextStyle(fontSize: 28, height: 1.2, fontWeight: FontWeight.w400, color: AppColors.title);
  static const roleName = TextStyle(fontSize: 20, height: 1.2, fontWeight: FontWeight.w600, color: AppColors.title);
  static const roleDescription = TextStyle(fontSize: 14, height: 1.4, color: AppColors.body);
  static const homeGreeting = TextStyle(fontSize: 13, height: 1.2, color: AppColors.white);
  static const homeTitle = TextStyle(fontSize: 22, height: 1.2, fontWeight: FontWeight.w700, color: AppColors.white);
  static const sectionTitle = TextStyle(fontSize: 17, height: 1.2, fontWeight: FontWeight.w700, color: AppColors.title);
  static const seeAll = TextStyle(fontSize: 10, color: AppColors.body);
  static const doctorName = TextStyle(fontSize: 13, height: 1.2, fontWeight: FontWeight.w700, color: AppColors.title);
  static const doctorSpecialty = TextStyle(fontSize: 10, height: 1.25, color: AppColors.body);
  static const doctorMeta = TextStyle(fontSize: 9, height: 1.2, color: AppColors.body);
  static const liveBadge = TextStyle(fontSize: 7, fontWeight: FontWeight.w700, color: AppColors.white);
  static const featurePrice = TextStyle(fontSize: 8, color: AppColors.primary);
  static const slotTime = TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary);
  static const slotTimeSelected = TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.white);
  static const slotHeader = TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.title);
  static const emptyStateText = TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.body);

  // Auth screens
  static const authTitle = TextStyle(fontSize: 26, height: 1.25, fontWeight: FontWeight.w700, color: AppColors.title);
  static const authSubtitle = TextStyle(fontSize: 13, height: 1.5, color: AppColors.body);
  static const authField = TextStyle(fontSize: 14, color: AppColors.title);
  static const authHint = TextStyle(fontSize: 13, color: AppColors.body);
  static const authLink = TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.primary);
  static const authSmall = TextStyle(fontSize: 11, color: AppColors.body);
  static const googleLabel = TextStyle(fontSize: 14, color: AppColors.title);
  static const sheetTitle = TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.title);
  static const sheetDesc = TextStyle(fontSize: 12, height: 1.5, color: AppColors.body);
  static const otpDigit = TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: AppColors.primary);
}
