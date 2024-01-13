enum Brands {
  toyota(name: "toyota"),
  mitsubishi(name: "mitsubishi"),
  bmw(name: "bmw"),
  yamaha(name: "yamaha"),
  kawasaki(name: "kawasaki"),
  suzuki(name: "suzuki"),
  honda(name: "honda"),
  none(name: "none");

  const Brands({required this.name});
  final String name;
}
