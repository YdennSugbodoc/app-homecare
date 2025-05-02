import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:homecare_app/screens/customer/services_select.dart';

enum ViewMode { grid2, list, grid1 }

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  // String selectedCategory = 'All';

  Set<String> selectedCategories = {'All'};
  ViewMode _currentView = ViewMode.grid2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 59, 106, 207),
        ),
        centerTitle: true,
        title: const Text(
          'Services',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 59, 106, 207),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Symbols.event_available),
            onPressed: () {
              // Optional action
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildFilterAndCategories(),
            const SizedBox(height: 0),
            _buildLayoutSwitcher(),
            const SizedBox(height: 0),
            _buildServiceCards(),
          ],
        ),
      ),
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

  Widget _buildFilterAndCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 35,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              // Tappable filter icon chip
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () {
                    // Add filter functionality if needed
                  },
                  child: Chip(
                    backgroundColor: Colors.white,
                    label: const Icon(
                      Icons.tune_outlined,
                      color: Color.fromARGB(255, 53, 97, 190),
                      size: 15,
                    ),
                    side: const BorderSide(
                      color: Color.fromARGB(255, 53, 97, 190),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              _buildCategoryChip('All'),
              _buildCategoryChip('Health'),
              _buildCategoryChip('Cleaning'),
              _buildCategoryChip('Transport'),
              _buildCategoryChip('Food'),
              _buildCategoryChip('Others'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryChip(String label) {
    final bool isSelected = selectedCategories.contains(label);

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: RawChip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                color:
                    isSelected
                        ? Colors.white
                        : const Color.fromARGB(255, 53, 97, 190),
              ),
            ),
            if (isSelected) ...[
              // ✅ Show check for *any* selected label including 'All'
              const SizedBox(width: 4),
              const Icon(Icons.check, size: 16, color: Colors.white),
            ],
          ],
        ),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            if (label == 'All') {
              selectedCategories = {'All'};
            } else {
              selectedCategories.remove('All');
              if (selected) {
                selectedCategories.add(label);
              } else {
                selectedCategories.remove(label);
                if (selectedCategories.isEmpty) {
                  selectedCategories = {'All'};
                }
              }
            }
          });
        },
        selectedColor: const Color.fromARGB(255, 53, 97, 190),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Color.fromARGB(255, 53, 97, 190)),
        ),
        showCheckmark: false, // disables default left checkmark
      ),
    );
  }

  //
  //Widget _buildCategoryChip(String label) {
  //   final bool isSelected = selectedCategory == label;

  //   return Padding(
  //     padding: const EdgeInsets.only(right: 8),
  //     child: ChoiceChip(
  //       label: Text(label),
  //       selected: isSelected,
  //       onSelected: (selected) {
  //         setState(() {
  //           selectedCategory = label;
  //         });
  //       },
  //       labelStyle: TextStyle(
  //         color:
  //             isSelected
  //                 ? Colors.white
  //                 : const Color.fromARGB(255, 53, 97, 190),
  //       ),
  //       selectedColor: const Color.fromARGB(255, 53, 97, 190),
  //       backgroundColor: Colors.white,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(8),
  //         side: const BorderSide(color: Color.fromARGB(255, 53, 97, 190)),
  //       ),
  //     ),
  //   );
  // }

  //Scrollable List of Services
  Widget _buildLayoutSwitcher() {
    IconData layoutIcon;
    switch (_currentView) {
      case ViewMode.grid2:
        layoutIcon = Icons.grid_view;
        break;
      case ViewMode.list:
        layoutIcon = Icons.view_list;
        break;
      case ViewMode.grid1:
        layoutIcon = Icons.view_module;
        break;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PopupMenuButton<ViewMode>(
          icon: Icon(layoutIcon),
          onSelected: (ViewMode mode) {
            setState(() {
              _currentView = mode;
            });
          },
          itemBuilder:
              (context) => [
                const PopupMenuItem(
                  value: ViewMode.grid2,
                  child: Row(
                    children: [
                      Icon(Icons.grid_view),
                      SizedBox(width: 8),
                      Text('Card'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: ViewMode.list,
                  child: Row(
                    children: [
                      Icon(Icons.view_list_outlined),
                      SizedBox(width: 8),
                      Text('List'),
                    ],
                  ),
                ),
                // const PopupMenuItem(
                //   value: ViewMode.grid1,
                //   child: Row(
                //     children: [
                //       Icon(Icons.view_module),
                //       SizedBox(width: 8),
                //       Text('Grid 1'),
                //     ],
                //   ),
                // ),
              ],
        ),
      ],
    );
  }

  Widget _buildServiceCards() {
    final services = [
      {
        'image': 'https://cdn.visitingangels.com/honeimages/caregiver-17.jpg',
        'title': 'Massage Therapy',
        'location': 'Cebu City',
        'duration': '30 min',
        'price': '₱ 1,500',
      },
      {
        'image':
            'https://cdn.visitingangels.com/images/newton-in-home-dementia-care-for%20senior.jpg',
        'title': 'Psychiatric Therapy',
        'location': 'Mandaue City',
        'duration': '45 min',
        'price': '₱ 1,250',
      },
    ];

    return _currentView == ViewMode.list
        ? Column(
          children: services.map((service) => _buildListCard(service)).toList(),
        )
        : GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _currentView == ViewMode.grid2 ? 2 : 1,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: _currentView == ViewMode.grid2 ? 0.65 : 2.5,
          ),
          itemCount: services.length,
          itemBuilder: (context, index) {
            return _buildGridCard(services[index]);
          },
        );
  }

  Widget _buildListCard(Map service) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                service['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.local_offer_outlined,
                    size: 16,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${service['price']}  •  ${service['duration']}',
                    style: const TextStyle(fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Colors.blueGrey,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${service['distance']} ~ (approximate) ${service['arrival']} arrival',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGridCard(Map service) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0), // optional
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.network(
                  service['image'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    service['location'],
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        service['duration'],
                        style: const TextStyle(fontSize: 12),
                      ),
                      Text(
                        service['price'],
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final enrichedService = {
                          ...service, // include all existing keys
                          'facilities': [
                            {
                              'name': 'Thai Massage Center',
                              'price': '₱1500.00',
                              'duration': '30 mins',
                              'distance': '3.1 km',
                              'arrival': '15 minutes',
                            },
                            {
                              'name': 'Muscle Relief Soothing Center',
                              'price': '₱1750.00',
                              'duration': '1 hour',
                              'distance': '4.6 km',
                              'arrival': '25 minutes',
                            },
                            {
                              'name': 'K-Massage Club',
                              'price': '₱1550.00',
                              'duration': '45 mins',
                              'distance': '5.3 km',
                              'arrival': '30 minutes',
                            },
                            {
                              'name': 'Physio Muscle Relax Spa',
                              'price': '₱1850.00',
                              'duration': '1 hour',
                              'distance': '5.8 km',
                              'arrival': '45 minutes',
                            },
                          ],
                        };

                        _showViewNearestFacilities(context, enrichedService);
                      },
                      // ... keep the style and child as-is
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 53, 97, 190),
                        minimumSize: const Size.fromHeight(35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Book',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showViewNearestFacilities(BuildContext context, Map service) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.85,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        service['image'],
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 206, 223, 255),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Text(
                              'Home Care',
                              style: TextStyle(
                                fontSize: 10,
                                color: Color.fromARGB(255, 53, 97, 190),
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            service['title'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 53, 97, 190),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.local_offer,
                                color: Color.fromARGB(255, 53, 97, 190),
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                service['price'] + ' • ' + service['duration'],
                                style: const TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 8),
                const Text(
                  'Nearby Facilities',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView(
                    children:
                        (service['facilities'] != null &&
                                    service['facilities'] is List
                                ? service['facilities']
                                : [] // Fallback to empty list if null or invalid type
                                )
                            .map<Widget>((facility) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        final selectedFacility = {
                                          'name':
                                              facility['name'] ??
                                              'Unnamed Facility',
                                          'services': [
                                            {
                                              'service_name':
                                                  'Full Body Massage',
                                              'service_description':
                                                  'A relaxing full body massage for 60 minutes.',
                                            },
                                            {
                                              'service_name':
                                                  'Foot Reflexology',
                                              'service_description':
                                                  'A 30-minute foot massage to stimulate circulation.',
                                            },
                                          ],
                                        };

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) =>
                                                    ServicesSelectScreen(
                                                      facility:
                                                          selectedFacility,
                                                    ),
                                          ),
                                        );
                                      },

                                      child: Text(
                                        facility['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.local_offer,
                                          color: Colors.grey,
                                          size: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${facility['price']} • ${facility['duration']}',
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.navigation_outlined,
                                          color: Colors.grey,
                                          size: 14,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${facility['distance']} ~ (approximate) ${facility['arrival']} arrival',
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            })
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
