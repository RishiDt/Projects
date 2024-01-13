import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/rest_card.dart';

class RestList extends StatelessWidget {
  List<dynamic>? restList;
  RestList({super.key, required this.restList});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: restList!.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            RestCard(cardDetails: restList![index]),
            SizedBox(
              height: MediaQuery.of(context).size.height * (1 / 20),
              width: MediaQuery.of(context).size.width - 10,
            ),
          ],
        );
      },
    );
  }
}
