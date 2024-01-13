import 'package:flutter_application_1/types/brands_enum.dart';
import 'package:flutter_application_1/types/fuel_type_enum.dart';
import 'package:flutter_application_1/types/vehicle_type_enum.dart';

class Vehicle {
  final String vehicleNo;
  final Brands vBrand;
  final VehicleType vType;
  final FuelType fType;

  const Vehicle(
      {required this.fType,
      required this.vBrand,
      required this.vType,
      required this.vehicleNo});
}
