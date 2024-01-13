import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/local_repo/repo.dart';
import 'package:flutter_application_1/utility/get_address_from_location.dart';
import 'package:flutter_application_1/utility/search_food.dart';
import 'package:flutter_application_1/utility/search_rest.dart';
import 'package:flutter_application_1/widgets/rest_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic>? restList;
  TextEditingController searchController = TextEditingController();
  String? keyword;
  List<dynamic>? mapList;
  String? _currentLocation;

  String? foodSelection;

  @override
  Widget build(BuildContext context) {
    print("mapList in build is $mapList and keyword $keyword");
    return FutureBuilder<List<dynamic>>(
      future: LocalRepo().getRestaurants(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the Future to complete
          return Scaffold(
              body: Center(
            child: CircularProgressIndicator(),
          ));
        } else if (snapshot.hasError) {
          // Show an error message if the Future completes with an error
          return Text('Error: ${snapshot.error}');
        } else {
          print("mapList in fbuilder is $mapList");
          // Build the widget tree based on the state of the Future
          return Scaffold(
              bottomNavigationBar: ConvexAppBar(
                activeColor: Colors.red.shade200,
                backgroundColor: Colors.red.shade100,
                color: Colors.black,
                items: const [
                  TabItem(icon: Icons.home, title: 'Home'),
                  TabItem(icon: Icons.ondemand_video_outlined, title: 'Video'),
                  TabItem(icon: Icons.document_scanner, title: 'Scan'),
                  TabItem(icon: Icons.bookmark, title: 'Saved'),
                  TabItem(icon: Icons.people, title: 'Profile'),
                ],
                onTap: (int i) => print('click index=$i'),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top),
                    child: TextButton(
                        onPressed: () {
                          getAddress().then((value) {
                            setState(() {
                              _currentLocation != null
                                  ? _currentLocation = null
                                  : _currentLocation = value;
                            });
                          });
                        },
                        child: Text(_currentLocation == null
                            ? "click to get location"
                            : _currentLocation!)),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        InkResponse(
                          onTap: () {
                            setState(() {
                              foodSelection = "all";
                              mapList = null;
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                              color: foodSelection == "all"
                                  ? Colors.red
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text("All"),
                          ),
                        ),
                        InkResponse(
                          onTap: () {
                            setState(() {
                              foodSelection = "Burger";
                              mapList = searchFood(snapshot.data!, "Burger");
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                              color: foodSelection == "Burger"
                                  ? Colors.red
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset('assets/images/burger.png'),
                          ),
                        ),
                        InkResponse(
                          onTap: () {
                            setState(() {
                              foodSelection = "Chicken";
                              mapList = searchFood(snapshot.data!, "Chicken");
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                              color: foodSelection == "Chicken"
                                  ? Colors.red
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset('assets/images/chicken.png'),
                          ),
                        ),
                        InkResponse(
                          onTap: () {
                            setState(() {
                              foodSelection = "Coffee";
                              mapList = searchFood(snapshot.data!, "Coffee");
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                              color: foodSelection == "Coffee"
                                  ? Colors.red
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset('assets/images/coffee.png'),
                          ),
                        ),
                        InkResponse(
                          onTap: () {
                            setState(() {
                              foodSelection = "Dosa";
                              mapList = searchFood(snapshot.data!, "Dosa");
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                              color: foodSelection == "Dosa"
                                  ? Colors.red
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset('assets/images/dosa.png'),
                          ),
                        ),
                        InkResponse(
                          onTap: () {
                            setState(() {
                              foodSelection = "Fries";
                              mapList = searchFood(snapshot.data!, "Fries");
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                              color: foodSelection == "Fries"
                                  ? Colors.red
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset('assets/images/fries.png'),
                          ),
                        ),
                        InkResponse(
                          onTap: () {
                            setState(() {
                              foodSelection = "Snacks";
                              mapList = searchFood(snapshot.data!, "Snacks");
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                              color: foodSelection == "Snacks"
                                  ? Colors.red
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset('assets/images/snack.png'),
                          ),
                        ),
                        InkResponse(
                          onTap: () {
                            setState(() {
                              foodSelection = "Upma";
                              mapList = searchFood(snapshot.data!, "Upma");
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 60,
                            decoration: BoxDecoration(
                              color: foodSelection == "Upma"
                                  ? Colors.red
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset('assets/images/upma.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        keyword = value;
                        mapList = searchRest(snapshot.data!, keyword);
                        print("maplist is :$mapList");
                      });
                    },
                  ),
                  Expanded(
                    child: RestList(
                      restList: mapList == null ? snapshot.data! : mapList,
                    ),
                  )
                ],
              ));
        }
      },
    );
  }
}
