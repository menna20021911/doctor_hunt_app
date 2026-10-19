import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../doctors/data/models/doctor_availability_model.dart';
import '../../../doctors/data/models/doctor_model.dart';
import '../../../doctors/presentation/cubit/doctors_cubit.dart';
import '../cubit/admin_cubit.dart';

class AdminDoctorAvailabilityScreen extends StatefulWidget {
  final DoctorModel doctor;

  const AdminDoctorAvailabilityScreen({super.key, required this.doctor});

  @override
  State<AdminDoctorAvailabilityScreen> createState() =>
      _AdminDoctorAvailabilityScreenState();
}

class _AdminDoctorAvailabilityScreenState
    extends State<AdminDoctorAvailabilityScreen> {
  late Map<String, bool> _workingDays;
  late String _startTime;
  late String _endTime;
  late String _slotDuration;

  final List<String> _daysOrder = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final List<String> _slotDurationOptions = [
    '15 Minutes',
    '30 Minutes',
    '45 Minutes',
    '60 Minutes',
  ];

  final List<String> _timeOptions = [
    '08:00 AM',
    '08:30 AM',
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '01:00 PM',
    '02:00 PM',
    '05:00 PM',
    '06:00 PM',
    '08:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    final avail = widget.doctor.availability ??
        DoctorAvailabilityModel.defaultAvailability();
    _workingDays = Map<String, bool>.from(avail.workingDays);
    _startTime = avail.startTime;
    _endTime = avail.endTime;
    _slotDuration = avail.slotDuration;
  }

  void _save() {
    final newAvailability = DoctorAvailabilityModel(
      workingDays: _workingDays,
      startTime: _startTime,
      endTime: _endTime,
      slotDuration: _slotDuration,
    );

    context
        .read<DoctorsCubit>()
        .updateDoctorAvailability(widget.doctor.name, newAvailability);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Doctor availability schedule updated successfully!'),
        backgroundColor: AppColors.primary,
      ),
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final clinicLocation =
        context.watch<AdminCubit>().state.clinicLocation;
    final enabledDays =
        _workingDays.values.where((enabled) => enabled).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF222B45),
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Doctor Availability',
          style: TextStyle(
            color: Color(0xFF222B45),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            // Doctor Context Card
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8EDF1)),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 50,
                      height: 50,
                      color: const Color(0xFFF4F6F8),
                      child: widget.doctor.image.isNotEmpty
                          ? Image.asset(
                              widget.doctor.image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                ImageAssets.drAhmedAli,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(Icons.person, color: Color(0xFF8F9BB3)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctor.name,
                          style: const TextStyle(
                            color: Color(0xFF222B45),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '${widget.doctor.specialty} · $clinicLocation',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color(0xFF8F9BB3),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: widget.doctor.isActive
                          ? const Color(0xFFE8F9F1)
                          : const Color(0xFFFFEEEE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.doctor.isActive ? '• Active' : '• Inactive',
                      style: TextStyle(
                        color: widget.doctor.isActive
                            ? AppColors.primary
                            : const Color(0xFFEA3B3B),
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Section 1: Working Days
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8EDF1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Working Days',
                        style: TextStyle(
                          color: Color(0xFF222B45),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '$enabledDays days enabled',
                        style: const TextStyle(
                          color: Color(0xFF8F9BB3),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ..._daysOrder.map((day) {
                    final isEnabled = _workingDays[day] ?? false;
                    return Container(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Color(0xFFF2F4F7),
                            width: 0.8,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            size: 16,
                            color: isEnabled
                                ? AppColors.primary
                                : const Color(0xFFC5CEE0),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              day,
                              style: TextStyle(
                                color: isEnabled
                                    ? const Color(0xFF222B45)
                                    : const Color(0xFF8F9BB3),
                                fontSize: 14,
                                fontWeight: isEnabled
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                          Switch.adaptive(
                            value: isEnabled,
                            activeTrackColor: AppColors.primary,
                            onChanged: (val) {
                              setState(() {
                                _workingDays[day] = val;
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Section 2: Working Hours
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE8EDF1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Working Hours',
                    style: TextStyle(
                      color: Color(0xFF222B45),
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // START TIME & END TIME side by side
                  Row(
                    children: [
                      // START TIME
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'START TIME',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF8F9BB3),
                              ),
                            ),
                            const SizedBox(height: 6),
                            DropdownButtonFormField<String>(
                              initialValue: _timeOptions.contains(_startTime)
                                  ? _startTime
                                  : _timeOptions.first,
                              isDense: true,
                              items: _timeOptions.map((t) {
                                return DropdownMenuItem(
                                  value: t,
                                  child: Text(t,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF222B45))),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _startTime = val);
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.access_time_rounded,
                                  size: 16,
                                  color: Color(0xFF8F9BB3),
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF9FAFB),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFE8EDF1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFE8EDF1)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),

                      // END TIME
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'END TIME',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF8F9BB3),
                              ),
                            ),
                            const SizedBox(height: 6),
                            DropdownButtonFormField<String>(
                              initialValue: _timeOptions.contains(_endTime)
                                  ? _endTime
                                  : _timeOptions[6], // 05:00 PM
                              isDense: true,
                              items: _timeOptions.map((t) {
                                return DropdownMenuItem(
                                  value: t,
                                  child: Text(t,
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: Color(0xFF222B45))),
                                );
                              }).toList(),
                              onChanged: (val) {
                                if (val != null) {
                                  setState(() => _endTime = val);
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.access_time_rounded,
                                  size: 16,
                                  color: Color(0xFF8F9BB3),
                                ),
                                filled: true,
                                fillColor: const Color(0xFFF9FAFB),
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFE8EDF1)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Color(0xFFE8EDF1)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // SLOT DURATION
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SLOT DURATION',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8F9BB3),
                        ),
                      ),
                      const SizedBox(height: 6),
                      DropdownButtonFormField<String>(
                        initialValue: _slotDurationOptions.contains(_slotDuration)
                            ? _slotDuration
                            : _slotDurationOptions[1], // 30 Minutes
                        items: _slotDurationOptions.map((dur) {
                          return DropdownMenuItem(
                            value: dur,
                            child: Text(dur,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF222B45))),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _slotDuration = val);
                          }
                        },
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.timer_outlined,
                            size: 16,
                            color: Color(0xFF8F9BB3),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF9FAFB),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFFE8EDF1)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                const BorderSide(color: Color(0xFFE8EDF1)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // Save Availability Button matching Figma
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                icon: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 20),
                label: const Text(
                  'Save Availability',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
