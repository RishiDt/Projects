import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/datastore/vehicle_list.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/types/fuel_type_enum.dart';
import 'package:flutter_application_1/types/vehicle.dart';
import 'package:flutter_application_1/types/vehicle_type_enum.dart';

import '../types/brands_enum.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<AddVehicleScreen> {
  final TextEditingController vntecontroller = TextEditingController();
  late String evNo;
  late VehicleType svType;
  late Brands sBrand;
  late FuelType sfType;

  final _formKey = GlobalKey<FormState>();
  final RegExp regEx = RegExp("\^[a-zA-Z]{2}[0-9]{2}[a-zA-Z]{2}[0-9]{4}\$");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Add Vehicle"),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "1. Vehicle Number",
                      style: TextStyle(fontSize: 20),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter No',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "please enter number";
                        }
                        if (!regEx.hasMatch(value)) {
                          return "vehicle number should be in formate like \"MH32AB0101\"";
                        }
                        evNo = value;
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "2. Vehicle Type",
                      style: TextStyle(fontSize: 20),
                    ),
                    DropdownMenu(
                        label: const Text("select one"),
                        onSelected: (value) {
                          setState(() {
                            svType = value as VehicleType;
                          });
                        },
                        dropdownMenuEntries: VehicleType.values
                            .map((VehicleType type) => DropdownMenuEntry(
                                value: type, label: type.typeText))
                            .toList())
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "3. Brand",
                      style: TextStyle(fontSize: 20),
                    ),
                    DropdownMenu(
                        label: Text("select one"),
                        onSelected: (value) {
                          sBrand = value!;
                        },
                        dropdownMenuEntries: Brands.values
                            .map((Brands value) => DropdownMenuEntry(
                                value: value, label: value.name))
                            .toList())
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "4. Fuel Type",
                      style: TextStyle(fontSize: 20),
                    ),
                    DropdownMenu(
                        onSelected: (value) {
                          sfType = value!;
                        },
                        label: Text("select one"),
                        dropdownMenuEntries: FuelType.values
                            .map((FuelType type) => DropdownMenuEntry(
                                value: type, label: type.label))
                            .toList())
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          print("evNo $evNo");
                          print("svtype $svType");
                          print("sbrand $sBrand");
                          print("sftype $sfType");
                          if (svType == VehicleType.car) {
                            VehicleList.addToCarList(Vehicle(
                                fType: sfType,
                                vBrand: sBrand,
                                vType: svType,
                                vehicleNo: evNo));
                          } else {
                            VehicleList.addToBikeList(Vehicle(
                                fType: sfType,
                                vBrand: sBrand,
                                vType: svType,
                                vehicleNo: evNo));
                          }

                          showTextToast(
                            text: 'New vehicle added',
                            context: context,
                          );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  )),
            ],
          ),
        ));
  }
}
