import 'package:flutter/material.dart';
import '../../../data/urls/urls.dart';
import '../../../data/models/model.dart';
import '../../../logic/services/services.dart';
import '../../custom_widgets/serviceCard.dart';
import '../hotel_desc/hotel_description.dart';

class NewlyAdded extends StatefulWidget {
  const NewlyAdded({super.key});

  @override
  State<NewlyAdded> createState() => _NewlyAddedState();
}

class _NewlyAddedState extends State<NewlyAdded> {
  List<Model> newlyAdded = <Model>[];
  Services services = Services();
  bool isLoaded_a = false;
  double baseWidth = 428;

  @override
  void initState() {
    super.initState();
    services.getHotels(apiUrl: newlyadded()).then((value) {
      setState(() {
        newlyAdded = value!;
        isLoaded_a = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Visibility(
      visible: isLoaded_a,
      child: SizedBox(
        height: ffem * 265,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: newlyAdded.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => hotelDiscription(
                        rest_ID: newlyAdded[index].sid,
                        category: newlyAdded[index].categoryName ?? 'N/A',
                      ),
                    ));
              },
              child: ServiceCard(
                  ratings: newlyAdded[index].averageRating,
                  image:
                      '${baseUrl + "ServiceProviderProfile/" + newlyAdded[index].logo!}',
                  index: index,
                  location: newlyAdded[index].address ?? 'N/A',
                  title: newlyAdded[index].fullName ?? 'N/A',
                  ffem: ffem,
                  category: newlyAdded[index].categoryName,
                  maxPrice: newlyAdded[index].max,
                  minPrice: newlyAdded[index].min),
            );
          },
        ),
      ),
      replacement: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
