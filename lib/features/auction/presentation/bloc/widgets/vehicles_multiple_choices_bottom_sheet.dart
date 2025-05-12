import 'package:flutter/material.dart';

import '../../../domain/entities/vehicle.dart';

class VehiclesMultipleChoicesBottomSheet extends StatelessWidget {
  final List<Vehicle> vehicles;

  const VehiclesMultipleChoicesBottomSheet({super.key, required this.vehicles});

  static Future<Vehicle?> showModal(BuildContext context, List<Vehicle> vehicles) {
    return showModalBottomSheet<Vehicle>(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      backgroundColor: Colors.white,
      // isScrollControlled: true, // allows full height
      builder: (context) {
        return VehiclesMultipleChoicesBottomSheet(vehicles: vehicles);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Select a Vehicle', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            itemCount: vehicles.length,
            separatorBuilder: (_, __) => Divider(height: 1),
            itemBuilder: (context, index) {
              final vehicle = vehicles[index];
              return ListTile(
                leading: Icon(Icons.directions_car),
                trailing: Text('${vehicle.similarity?.round()}%'),
                title: Text(vehicle.model ?? ''),
                subtitle: Text(vehicle.containerName ?? ''),
                onTap: () {
                  Navigator.pop(context, vehicle); // return selected vehicle
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
