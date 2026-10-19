import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../doctors/data/models/doctor_availability_model.dart';
import '../../../doctors/data/models/doctor_model.dart';
import '../../../doctors/presentation/cubit/doctors_cubit.dart';

class AdminCreateDoctorScreen extends StatefulWidget {
  const AdminCreateDoctorScreen({super.key});

  @override
  State<AdminCreateDoctorScreen> createState() =>
      _AdminCreateDoctorScreenState();
}

class _AdminCreateDoctorScreenState extends State<AdminCreateDoctorScreen> {
  final _nameController = TextEditingController();
  final _feeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _selectedSpecialty;
  String _selectedImage = ImageAssets.drAhmedAli;

  final List<String> _specialties = [
    'Cardiologist',
    'Dentist',
    'Orthopedic',
    'Pediatrician',
    'Dermatologist',
    'Specialist Medicine',
    'Specialist General',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _feeController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedSpecialty == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a specialty')),
        );
        return;
      }

      final feeRaw = _feeController.text.trim().replaceAll('\$', '');
      final fee = feeRaw.isEmpty ? '28.00' : feeRaw;

      final newDoctor = DoctorModel(
        name: _nameController.text.trim(),
        specialty: _selectedSpecialty!,
        image: _selectedImage,
        price: fee,
        rating: 4.8,
        reviewsCount: 1,
        isActive: true,
        availability: DoctorAvailabilityModel.defaultAvailability(),
      );

      context.read<DoctorsCubit>().addDoctor(newDoctor);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${newDoctor.name} added successfully!'),
          backgroundColor: AppColors.primary,
        ),
      );

      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'Create Doctor',
          style: TextStyle(
            color: Color(0xFF222B45),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Photo Picker Container matching Figma
              InkWell(
                onTap: () {
                  // Switch image between available assets
                  setState(() {
                    if (_selectedImage == ImageAssets.drAhmedAli) {
                      _selectedImage = ImageAssets.doctor1;
                    } else if (_selectedImage == ImageAssets.doctor1) {
                      _selectedImage = ImageAssets.doctor2;
                    } else {
                      _selectedImage = ImageAssets.drAhmedAli;
                    }
                  });
                },
                borderRadius: BorderRadius.circular(50),
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9FAFB),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFE8EDF1),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.camera_alt_outlined,
                        color: Color(0xFF8F9BB3),
                        size: 26,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Add photo',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // DOCTOR NAME
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DOCTOR NAME',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8F9BB3),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'e.g. Dr. Ahmed Ali',
                      hintStyle: const TextStyle(
                        color: Color(0xFFC5CEE0),
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF9FAFB),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Color(0xFFE8EDF1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Color(0xFFE8EDF1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: AppColors.primary),
                      ),
                    ),
                    validator: (v) => v != null && v.trim().isNotEmpty
                        ? null
                        : 'Doctor name is required',
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // SPECIALTY DROPDOWN
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'SPECIALTY',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8F9BB3),
                    ),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedSpecialty,
                    hint: const Text(
                      'Select specialty',
                      style: TextStyle(
                        color: Color(0xFFC5CEE0),
                        fontSize: 14,
                      ),
                    ),
                    items: _specialties.map((s) {
                      return DropdownMenuItem(
                        value: s,
                        child: Text(s,
                            style:
                                const TextStyle(color: Color(0xFF222B45))),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _selectedSpecialty = val;
                      });
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xFFF9FAFB),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Color(0xFFE8EDF1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Color(0xFFE8EDF1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: AppColors.primary),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // CONSULTATION FEE
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'CONSULTATION FEE',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8F9BB3),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _feeController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'e.g. \$28.00',
                      hintStyle: const TextStyle(
                        color: Color(0xFFC5CEE0),
                        fontSize: 14,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF9FAFB),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Color(0xFFE8EDF1)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Color(0xFFE8EDF1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: AppColors.primary),
                      ),
                    ),
                    validator: (v) => v != null && v.trim().isNotEmpty
                        ? null
                        : 'Consultation fee is required',
                  ),
                ],
              ),

              const SizedBox(height: 36),

              // Create Doctor Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Create Doctor',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
