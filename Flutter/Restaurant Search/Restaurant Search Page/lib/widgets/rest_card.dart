import 'package:flutter/material.dart';

class RestCard extends StatelessWidget {
  final Map cardDetails;
  const RestCard({super.key, required this.cardDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Colors.red.shade200,
            Colors.red.shade50
          ], // Define your gradient colors
        ),
        shape: BoxShape.rectangle,
      ),
      height: MediaQuery.of(context).size.height * (1 / 3),
      width: MediaQuery.of(context).size.width - 10,
      child: Row(
        children: [
          Container(
              height: MediaQuery.of(context).size.height * (1 / 5),
              width: MediaQuery.of(context).size.width * (1 / 2),
              decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              alignment: Alignment.center,
              child: ClipRect(
                child: Image.network(cardDetails["primary_image"],
                    fit: BoxFit.cover),
              )),
          Container(
            height: double.infinity,
            width: 2,
            decoration: const BoxDecoration(color: Colors.black),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  cardDetails["name"],
                  style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.black87),
                ),
                Text(
                  "Rating: ${cardDetails["rating"].toString()}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 15),
                ),
                Text(
                  "Discount: ${cardDetails["discount"].toString()}%",
                  style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: Colors.redAccent),
                ),
                Container(
                  width: 150,
                  child: Text(
                    "Food: ${cardDetails["tags"]}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  "Distance: ${cardDetails["distance"].toString()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
