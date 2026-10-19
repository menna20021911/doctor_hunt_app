import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../doctors/data/models/doctor_model.dart';
import '../../../doctors/presentation/cubit/doctors_cubit.dart';
import '../widgets/admin_app_bar.dart';
import '../widgets/admin_doctor_card.dart';
import '../widgets/admin_stat_card.dart';
import 'admin_create_doctor_screen.dart';
import 'admin_doctor_details_screen.dart';

class AdminDoctorsScreen extends StatefulWidget {
  const AdminDoctorsScreen({super.key});

  @override
  State<AdminDoctorsScreen> createState() => _AdminDoctorsScreenState();
}

class _AdminDoctorsScreenState extends State<AdminDoctorsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedSpecialty = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final allDoctors = context.watch<DoctorsCubit>().state;
    final activeCount = allDoctors.where((d) => d.isActive).length;
    final totalCount = allDoctors.length;

    // Filter by search query
    final query = _searchController.text.trim().toLowerCase();
    var filtered = allDoctors.where((d) {
      final matchesQuery = query.isEmpty ||
          d.name.toLowerCase().contains(query) ||
          d.specialty.toLowerCase().contains(query);
      final matchesSpecialty = _selectedSpecialty == 'All' ||
          d.specialty.toLowerCase().contains(_selectedSpecialty.toLowerCase());
      return matchesQuery && matchesSpecialty;
    }).toList();

    // Specialty filter list
    final specialties = [
      'All',
      'Cardiology',
      'Orthopedic',
      'Dentist',
      'Pediatrician',
      'Dermatologist',
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AdminAppBar(title: 'Doctors'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AdminCreateDoctorScreen(),
            ),
          );
        },
        backgroundColor: AppColors.primary,
        elevation: 3,
        icon: const Icon(Icons.add, color: Colors.white, size: 20),
        label: const Text(
          'Add Doctor',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats Cards
                  Row(
                    children: [
                      Expanded(
                        child: AdminStatCard(
                          label: 'Active Doctors',
                          value: '$activeCount',
                          valueColor: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: AdminStatCard(
                          label: 'Total Doctors',
                          value: '$totalCount',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Search Bar
                  TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search doctors...',
                      hintStyle: const TextStyle(
                        color: Color(0xFF8F9BB3),
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Color(0xFF8F9BB3),
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, size: 18),
                              onPressed: () {
                                _searchController.clear();
                                setState(() {});
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: const Color(0xFFF9FAFB),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
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

                  const SizedBox(height: 14),

                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: specialties.map((spec) {
                        final isSelected = _selectedSpecialty == spec;
                        final count = spec == 'All'
                            ? allDoctors.length
                            : allDoctors
                                .where((d) => d.specialty
                                    .toLowerCase()
                                    .contains(spec.toLowerCase()))
                                .length;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(
                              '$spec ($count)',
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : const Color(0xFF677294),
                                fontSize: 12,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                            selected: isSelected,
                            onSelected: (selected) {
                              if (selected) {
                                setState(() => _selectedSpecialty = spec);
                              }
                            },
                            selectedColor: AppColors.primary,
                            backgroundColor: const Color(0xFFF9FAFB),
                            side: BorderSide(
                              color: isSelected
                                  ? AppColors.primary
                                  : const Color(0xFFE8EDF1),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            showCheckmark: false,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Doctors List or Empty State
          if (filtered.isEmpty)
            SliverFillRemaining(
              hasScrollBody: false,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE8F9F1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.medical_services_outlined,
                          size: 40,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'No Doctors Found',
                        style: TextStyle(
                          color: Color(0xFF222B45),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'There are currently no doctors matching your search. Add your first doctor to get started.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF8F9BB3),
                          fontSize: 13,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AdminCreateDoctorScreen(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 12),
                          elevation: 0,
                        ),
                        icon: const Icon(Icons.add,
                            color: Colors.white, size: 18),
                        label: const Text(
                          'Add Doctor',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final doc = filtered[index];
                    return AdminDoctorCard(
                      doctor: doc,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                AdminDoctorDetailsScreen(doctor: doc),
                          ),
                        );
                      },
                    );
                  },
                  childCount: filtered.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
