import 'package:flutter_application_1/types/vehicle.dart';

class VehicleList {
  static List<Vehicle>? _carList = [];
  static List<Vehicle>? _bikeList = [];

  static void removeCarWithNo(String vNo) {
    _carList!.removeWhere((element) => element.vehicleNo == vNo);
  }

  static void removeBikeWithNo(String vNo) {
    _bikeList!.removeWhere((element) => element.vehicleNo == vNo);
  }

  static void addToCarList(Vehicle _vehicle) {
    _carList!.add(_vehicle);

    print("vehicleList.length: ${_carList!.length};");
  }

  static List<Vehicle>? getCarList() => _carList;
  static List<Vehicle>? getBikeList() => _bikeList;

  static void addToBikeList(Vehicle _vehicle) {
    _bikeList!.add(_vehicle);

    print("vehicleList.length: ${_bikeList!.length};");
  }
}
