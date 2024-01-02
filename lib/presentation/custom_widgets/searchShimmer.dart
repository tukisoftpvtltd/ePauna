import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SearchShimmer extends StatelessWidget {
  const SearchShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 186,
      width: double.infinity,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Shimmer.fromColors(
                    baseColor:
                        Colors.grey.shade300, // Color of the skeleton loader
                    highlightColor: Colors
                        .grey.shade100, // Color of the animated shimmer effect
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.yellow,
                      ),
                      height: 140,
                      width: 250,
                      child: const Text(" "),
                    )),
              ),
            );
          }),
    );
  }
}
