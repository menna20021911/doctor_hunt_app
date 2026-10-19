import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/image_assets.dart';
import '../../../doctors/data/models/doctor_model.dart';
import '../../../doctors/presentation/cubit/doctors_cubit.dart';

class AdminEditDoctorScreen extends StatefulWidget {
  final DoctorModel doctor;

  const AdminEditDoctorScreen({super.key, required this.doctor});

  @override
  State<AdminEditDoctorScreen> createState() => _AdminEditDoctorScreenState();
}

class _AdminEditDoctorScreenState extends State<AdminEditDoctorScreen> {
  late TextEditingController _nameController;
  late TextEditingController _feeController;
  final _formKey = GlobalKey<FormState>();

  late String _selectedSpecialty;
  late String _image;
  late bool _isActive;

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
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.doctor.name);
    _feeController = TextEditingController(
      text: '\$${widget.doctor.price.replaceAll('\$', '')}',
    );
    _selectedSpecialty = _specialties.contains(widget.doctor.specialty)
        ? widget.doctor.specialty
        : _specialties.first;
    _image = widget.doctor.image;
    _isActive = widget.doctor.isActive;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _feeController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      final fee = _feeController.text.trim().replaceAll('\$', '');
      final updated = widget.doctor.copyWith(
        name: _nameController.text.trim(),
        specialty: _selectedSpecialty,
        price: fee,
        image: _image,
        isActive: _isActive,
      );

      context
          .read<DoctorsCubit>()
          .updateDoctor(widget.doctor.name, updated);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Doctor details updated successfully!'),
          backgroundColor: AppColors.primary,
        ),
      );

      Navigator.of(context).pop();
    }
  }

  void _deleteDoctor() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Doctor'),
        content: Text(
          'Are you sure you want to remove ${widget.doctor.name}? You can also deactivate them to preserve booking histories.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<DoctorsCubit>().deleteDoctor(widget.doctor.name);
              Navigator.of(context).pop(); // pop edit screen
              Navigator.of(context).pop(); // pop details screen
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEA3B3B),
            ),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
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
          'Edit Doctor',
          style: TextStyle(
            color: Color(0xFF222B45),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert_rounded,
                color: Color(0xFF222B45)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10),

              // Doctor photo with edit badge matching Figma
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      width: 90,
                      height: 90,
                      color: const Color(0xFFF4F6F8),
                      child: _image.isNotEmpty
                          ? Image.asset(
                              _image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                ImageAssets.drAhmedAli,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.person,
                              size: 50,
                              color: Color(0xFF8F9BB3),
                            ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              const Text(
                'Tap photo to change',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 28),

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
                      prefixIcon: const Icon(Icons.person_outline_rounded,
                          color: Color(0xFF8F9BB3)),
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

              const SizedBox(height: 18),

              // SPECIALTY
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
                    items: _specialties.map((s) {
                      return DropdownMenuItem(
                        value: s,
                        child: Text(s,
                            style:
                                const TextStyle(color: Color(0xFF222B45))),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setState(() => _selectedSpecialty = val);
                      }
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

              const SizedBox(height: 18),

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

              const SizedBox(height: 20),

              // Doctor Status Toggle matching Figma
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFFE8EDF1)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: _isActive
                            ? const Color(0xFFE8F9F1)
                            : const Color(0xFFFFEEEE),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isActive
                            ? Icons.check_circle_outline_rounded
                            : Icons.cancel_outlined,
                        color: _isActive
                            ? AppColors.primary
                            : const Color(0xFFEA3B3B),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Doctor Status',
                            style: TextStyle(
                              color: Color(0xFF222B45),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _isActive ? 'Active & Available' : 'Inactive (Hidden)',
                            style: TextStyle(
                              color: _isActive
                                  ? AppColors.primary
                                  : const Color(0xFF8F9BB3),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Switch.adaptive(
                      value: _isActive,
                      activeTrackColor: AppColors.primary,
                      onChanged: (val) {
                        setState(() {
                          _isActive = val;
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Save Changes Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _saveChanges,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Delete Doctor Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton(
                  onPressed: _deleteDoctor,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFFD1D1)),
                    backgroundColor: const Color(0xFFFFFAFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Delete Doctor',
                    style: TextStyle(
                      color: Color(0xFFEA3B3B),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
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
