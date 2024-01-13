import '../data_source/client.dart';

class LocalRepo {
  static List<dynamic>? RestList;

  Future<List<dynamic>> getRestaurants() async {
    //fetches restaurant list from server
    if (RestList == null) {
      ApiClient apiClient = ApiClient();
      Map response = await apiClient.post(
        '/get_resturants',
        bodyParams: {"lat": 25.22, "lng": 45.32},
      );
      RestList = response["data"];
      print(response["data"]);
    }
    return RestList!;
  }
}
