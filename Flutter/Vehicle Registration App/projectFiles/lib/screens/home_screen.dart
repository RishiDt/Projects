import 'package:flutter/material.dart';
import 'package:flutter_application_1/datastore/vehicle_list.dart';
import 'package:flutter_application_1/screens/add_vehicle_screen.dart';
import 'package:flutter_application_1/widgets/vehicle_card_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2, // Number of tabs
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Vehicle Details'),
            bottom: const TabBar(
              tabs: [
                Tab(
                    child: Text(
                  "Cars",
                  style: TextStyle(fontSize: 25),
                )),
                Tab(
                  child: Text(
                    "Bikes",
                    style: TextStyle(fontSize: 25),
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              vehicleCardList(
                vehicles: VehicleList.getCarList(),
              ),
              vehicleCardList(
                vehicles: VehicleList.getBikeList(),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddVehicleScreen()),
              );
            },
            tooltip: 'Add Vehicle',
            child: Icon(Icons.add),
          ),
        ));
  }
}
