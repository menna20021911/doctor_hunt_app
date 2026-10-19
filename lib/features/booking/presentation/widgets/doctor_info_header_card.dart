import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class DoctorInfoHeaderCard extends StatefulWidget {
  final String imagePath;
  final String name;
  final String specialty;
  final String rating;
  final bool initialIsFavorite;

  const DoctorInfoHeaderCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.specialty,
    required this.rating,
    this.initialIsFavorite = false,
  });

  @override
  State<DoctorInfoHeaderCard> createState() => _DoctorInfoHeaderCardState();
}

class _DoctorInfoHeaderCardState extends State<DoctorInfoHeaderCard> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.initialIsFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              widget.imagePath,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: AppTextStyles.doctorName),
                const SizedBox(height: 4),
                Text(widget.specialty, style: AppTextStyles.doctorSpecialty),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.rating, size: 14),
                    const SizedBox(width: 4),
                    Text(widget.rating, style: AppTextStyles.doctorMeta),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? AppColors.selectedHeart : AppColors.favorite,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }
}
