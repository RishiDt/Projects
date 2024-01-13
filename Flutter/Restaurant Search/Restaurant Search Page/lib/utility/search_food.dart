List<dynamic> searchFood(List<dynamic> mapList, keyword) {
  List<dynamic> result =
      mapList.where((map) => map['tags'].contains(keyword)).toList();

  print(result);
  return result;
}
