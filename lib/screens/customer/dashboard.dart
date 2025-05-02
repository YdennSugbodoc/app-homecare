import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:homecare_app/screens/customer/services.dart';
import 'package:homecare_app/screens/customer/medications.dart';
import 'package:homecare_app/screens/customer/supplies.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6A76E6), // Background matches blue
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Blue Section
              Container(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopHeader(context),
                    const SizedBox(height: 16),
                    _buildHeader(context),
                    const SizedBox(height: 16),
                    _buildSearchBar(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),

              // Bottom White Section with top radius
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildQuickActions(),
                      const SizedBox(height: 24),
                      _buildCareTeamSection(),
                      const SizedBox(height: 24),
                      _buildPrescriptionsSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 0 ? Icons.home : Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 1 ? Icons.person : Icons.person_outline,
            ),
            label: 'Doctors',
          ),
          BottomNavigationBarItem(
            icon: Icon(_currentIndex == 2 ? Icons.event : Icons.event_outlined),
            label: 'Activities',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _currentIndex == 3 ? Icons.payment : Icons.payment_outlined,
            ),
            label: 'Payments',
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'SUGBODOC',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 24,
          backgroundImage: AssetImage('assets/pictures/avatar.jpg'),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Hello Jane,',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 247, 247, 247),
              ),
            ),
            Text(
              'How are you feeling today?',
              style: TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 247, 247, 247),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search here...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.medical_services_outlined, 'label': 'Services'},
      {'icon': Icons.calendar_today_outlined, 'label': 'Calendar'},
      {'icon': Icons.folder_outlined, 'label': 'Records'},
      {'icon': Icons.insert_drive_file_outlined, 'label': 'Files'},
      {'icon': Icons.medication_outlined, 'label': 'Medications'},
      {'icon': Symbols.stethoscope, 'label': 'Supplies'},
      {'icon': Icons.analytics_outlined, 'label': 'Diagnosis'},
      {'icon': Icons.grid_view_outlined, 'label': 'View All'},
    ];

    return Center(
      // Center the quick actions
      child: Wrap(
        spacing: 1,
        runSpacing: 16,
        children:
            actions.map((action) {
              return GestureDetector(
                onTap: () {
                  if (action['label'] == 'View All') {
                    _showViewAllQuickActions(context);
                  } else if (action['label'] == 'Services') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ServicesScreen()),
                    );
                  } else if (action['label'] == 'Calendar') {
                  } else if (action['label'] == 'Records') {
                  } else if (action['label'] == 'Files') {
                  } else if (action['label'] == 'Medications') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicationScreen(),
                      ),
                    );
                  } else if (action['label'] == 'Supplies') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SuppliesScreen()),
                    );
                  } else if (action['label'] == 'Diagnosis') {}
                },
                child: SizedBox(
                  width: 80,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.deepPurple.shade100,
                        child: Icon(
                          action['icon'] as IconData,
                          color: Colors.deepPurple,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        (action['label'] as String?) ?? '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  void _showViewAllQuickActions(BuildContext context) {
    final actions = [
      {'icon': Icons.medical_services_outlined, 'label': 'Services'},
      {'icon': Icons.calendar_today_outlined, 'label': 'Calendar'},
      {'icon': Icons.folder_outlined, 'label': 'Records'},
      {'icon': Icons.insert_drive_file_outlined, 'label': 'Files'},
      {'icon': Icons.medication_outlined, 'label': 'Medications'}, // pill
      {'icon': Symbols.stethoscope, 'label': 'Supplies'}, // stethoscope
      {'icon': Icons.analytics_outlined, 'label': 'Diagnosis'},
      {'icon': Icons.vaccines_outlined, 'label': 'Immunization'},
      {'icon': Icons.image_outlined, 'label': 'Medical Images'},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 10,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const Text(
                  'All Quick Actions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.69,
                        ),
                    itemCount: actions.length,
                    itemBuilder: (context, index) {
                      final action = actions[index];
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.deepPurple.shade100,
                            child: Icon(
                              action['icon'] as IconData,
                              color: Colors.deepPurple,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            action['label'] as String,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCareTeamSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Care Team'),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              return Container(
                width: 250,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius:
                          8, // Adjusted to make the shadow more prominent
                      offset: const Offset(0, 4), // Adjust the shadow's offset
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage(
                        'assets/pictures/avatar1.jpg',
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Demo Doctor, MD',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Consultant Physician',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              27,
                              30,
                              187,
                            ),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Text('Book'),
                        ),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color.fromARGB(
                              255,
                              27,
                              30,
                              187,
                            ),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 27, 30, 187),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Text('Profile'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            clipBehavior:
                Clip.none, // Allow shadow to extend outside of the card's container
          ),
        ),
      ],
    );
  }

  Widget _buildPrescriptionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Prescriptions'),
        const SizedBox(height: 8),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: const Center(child: Text('No prescriptions available.')),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            // _showViewAllModal(title);
          },
          child: const Text('View All'),
        ),
      ],
    );
  }
}
