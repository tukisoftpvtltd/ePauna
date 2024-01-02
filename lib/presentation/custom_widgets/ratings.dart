import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ePauna/data/repository/add_ratings.dart';

class CustomRatings extends StatefulWidget {
  double rate;
  double size;
  dynamic sId;
  CustomRatings({super.key, this.rate = 0.0, this.size = 15, this.sId});

  @override
  State<CustomRatings> createState() => _CustomRatingsState();
}

class _CustomRatingsState extends State<CustomRatings> {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: widget.rate.toDouble(),
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: false,
      itemCount: 5,
      itemSize: widget.size,
      itemBuilder: (context, _) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: Icon(
            CupertinoIcons.star_fill,
            color: Colors.amber,
            size: 15,
          ),
        );
      },
      onRatingUpdate: (double value) async {
        setState(() {
          widget.rate = value;
          print(value);
        });
        await AddRatingsRepository()
            .addRatings(widget.sId, widget.rate.toInt());
      },
    );
  }
}
