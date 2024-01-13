import 'package:flutter/material.dart';
import 'package:flutter_application_1/types/vehicle.dart';
import 'package:flutter_application_1/widgets/vehicle_card.dart';

class vehicleCardList extends StatefulWidget {
  final List<Vehicle>? vehicles;

  const vehicleCardList({super.key, required this.vehicles});

  @override
  State<vehicleCardList> createState() => _vehicleCardList(vehicles: vehicles);
}

class _vehicleCardList extends State<vehicleCardList> {
  List<Vehicle>? vehicles;
  late int _items;
  late bool _isEmpty;

  void getVehicleListDetails() {
    if (vehicles == null) {
      _items = 0;
      _isEmpty = true;
    } else {
      if (vehicles!.isEmpty && vehicles!.length == 0) {
        _isEmpty = true;
        _items = 0;
      } else {
        _items = vehicles!.length;
        _isEmpty = false;
      }
    }
    print("_isEmpty is $_isEmpty");
    print("_items is $_items");
  }

  _vehicleCardList({required this.vehicles});

  @override
  Widget build(BuildContext context) {
    getVehicleListDetails();
    if (_isEmpty) {
      print("i am in itemBuilder of listview & list is empty");
      return Center(
        child: Text(
          "No vehicles added",
          style: TextStyle(fontSize: 18),
        ),
      );
    }
    return ListView.builder(
      itemCount: _items,
      itemBuilder: (context, index) {
        return vehicleCard(
          vehicle: vehicles![index],
        );
      },
    );
  }
}
