// import 'package:flutter/material.dart';

// class Figma extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Android Test Case 1'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: () {
//               // Ask to edit
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.share),
//             onPressed: () {
//               // Share
//             },
//           ),
//         ],
//       ),
//       body: ListView(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               'Nearby Restaurants',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               CategoryItem(
//                 icon: Icons.fastfood,
//                 label: 'All',
//                 color: Colors.blue,
//               ),
//               CategoryItem(
//                 icon: Icons.bakery_dining,
//                 label: 'Burger',
//                 color: Colors.red,
//               ),
//               CategoryItem(
//                 icon: Icons.emoji_food_beverage,
//                 label: 'Salad',
//                 color: Colors.green,
//               ),
//               CategoryItem(
//                 icon: Icons.local_dining,
//                 label: 'Chicken',
//                 color: Colors.yellow,
//               ),
//             ],
//           ),
//           SizedBox(height: 16),
//           RestaurantItem(
//             name: 'Res1',
//             image: 'assets/res1.jpg',
//             rating: 4.5,
//           ),
//           RestaurantItem(
//             name: 'Res2',
//             image: 'assets/res1.jpg',
//             rating: 4.0,
//           ),
//           RestaurantItem(
//             name: 'Res1',
//             image: 'assets/res1.jpg',
//             rating: 4.5,
//           ),
//           RestaurantItem(
//             name: 'Res1',
//             image: 'assets/res1.jpg',
//             rating: 4.5,
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bookmark),
//             label: 'Bookmark',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//       ),
//     );
//   }
// }

// class CategoryItem extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;

//   const CategoryItem({
//     Key? key,
//     required this.icon,
//     required this.label,
//     required this.color,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CircleAvatar(
//           backgroundColor: color,
//           child: Icon(icon, color: Colors.white),
//         ),
//         SizedBox(height: 4),
//         Text(label),
//       ],
//     );
//   }
// }

// class RestaurantItem extends StatelessWidget {
//   final String name;
//   final String image;
//   final double rating;

//   const RestaurantItem({
//     Key? key,
//     required this.name,
//     required this.image,
//     required this.rating,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         children: [
//           Expanded(
//             flex: 2,
//             child: Image.asset(image, fit: BoxFit.cover),
//           ),
//           SizedBox(width: 8),
//           Expanded(
//             flex: 3,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   name,
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 4),
//                 Row(
//                   children: List.generate(
//                     5,
//                     (index) => Icon(
//                       index < rating ? Icons.star : Icons.star_border,
//                       color: Colors.amber,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
