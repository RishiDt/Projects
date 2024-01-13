import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/datastore/vehicle_list.dart';
import 'package:flutter_application_1/types/vehicle_type_enum.dart';

import '../screens/home_screen.dart';
import '../types/vehicle.dart';

class vehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  const vehicleCard({super.key, required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Card(
        elevation: 10,
        surfaceTintColor: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(color: Colors.red),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Vehicle No: ${vehicle.vehicleNo.toUpperCase()}",
                      style: TextStyle(fontSize: 25),
                    ),
                    IconButton(
                        onPressed: () {
                          if (vehicle.vType == VehicleType.car) {
                            VehicleList.removeCarWithNo(vehicle.vehicleNo);
                          }
                          VehicleList.removeBikeWithNo(vehicle.vehicleNo);

                          showTextToast(
                            text: 'vehicle removed',
                            context: context,
                          );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        icon: Icon(
                          Icons.delete,
                        ))
                  ],
                )),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "1. Brand: \"${vehicle.vBrand.name.toUpperCase()}\"",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "2. Fuel Type: \"${vehicle.fType.label}\"",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "3. Vehicle Type: \"${vehicle.vType.typeText}\"",
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
