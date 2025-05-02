import 'package:flutter/material.dart';

class ServicesSelectScreen extends StatelessWidget {
  final Map facility;

  const ServicesSelectScreen({Key? key, required this.facility})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(facility['name'] ?? 'Facility')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Available Services in ${facility['title']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children:
                    (facility['services'] != null &&
                                facility['services'] is List
                            ? (facility['services'] as List)
                            : [])
                        .map<Widget>((service) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  service['service_name'] ?? 'Unnamed Service',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  service['service_description'] ??
                                      'No description provided',
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
  }
}
