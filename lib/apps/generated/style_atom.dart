import 'package:flutter/material.dart';

import 'app_colore.dart';

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
}
