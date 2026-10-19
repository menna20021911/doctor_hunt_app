import 'package:equatable/equatable.dart';

class DoctorAvailabilityModel extends Equatable {
  final Map<String, bool> workingDays;
  final String startTime;
  final String endTime;
  final String slotDuration;

  const DoctorAvailabilityModel({
    required this.workingDays,
    this.startTime = '09:00 AM',
    this.endTime = '05:00 PM',
    this.slotDuration = '30 Minutes',
  });

  static DoctorAvailabilityModel defaultAvailability() {
    return const DoctorAvailabilityModel(
      workingDays: {
        'Monday': true,
        'Tuesday': true,
        'Wednesday': true,
        'Thursday': true,
        'Friday': true,
        'Saturday': false,
        'Sunday': false,
      },
      startTime: '09:00 AM',
      endTime: '05:00 PM',
      slotDuration: '30 Minutes',
    );
  }

  int get enabledDaysCount =>
      workingDays.values.where((enabled) => enabled).length;

  DoctorAvailabilityModel copyWith({
    Map<String, bool>? workingDays,
    String? startTime,
    String? endTime,
    String? slotDuration,
  }) {
    return DoctorAvailabilityModel(
      workingDays: workingDays ?? Map<String, bool>.from(this.workingDays),
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      slotDuration: slotDuration ?? this.slotDuration,
    );
  }

  @override
  List<Object?> get props => [
        workingDays,
        startTime,
        endTime,
        slotDuration,
      ];
}
