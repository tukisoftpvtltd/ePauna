import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ePauna/presentation/app_data/colors.dart';
import '../../bargain/colors.dart';
import '../../bloc/bargain/bloc/bargain_bloc.dart';

int CatIndex = 0;
int BedIndex = 0;

class CategoryIcon extends StatefulWidget {
  TextEditingController controller;
  CategoryIcon({super.key, required this.controller});
  @override
  _CategoryIconState createState() => _CategoryIconState();
}

class _CategoryIconState extends State<CategoryIcon> {
  int selectedButtonIndex = -1;

  void selectButton(int index) {
    CatIndex = index;
    print(CatIndex);
    print(BedIndex);
    setState(() {
      selectedButtonIndex = index;
      if (CatIndex == 0 && BedIndex == 0) {
        widget.controller.text = "1100";
      }
      if (CatIndex == 1 && BedIndex == 0) {
        widget.controller.text = "1500";
      }
      if (CatIndex == 2 && BedIndex == 0) {
        widget.controller.text = "2000";
      }
      if (CatIndex == 0 && BedIndex == 1) {
        widget.controller.text = "2500";
      }
      if (CatIndex == 1 && BedIndex == 1) {
        widget.controller.text = "3000";
      }
      if (CatIndex == 2 && BedIndex == 1) {
        widget.controller.text = "4000";
      }
      if (CatIndex == 0 && BedIndex == 2) {
        widget.controller.text = "4200";
      }
      if (CatIndex == 1 && BedIndex == 2) {
        widget.controller.text = "6000";
      }
      if (CatIndex == 2 && BedIndex == 2) {
        widget.controller.text = "8000";
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectButton(0);

    BlocProvider.of<BargainBloc>(context).add(getHotelCategory(0));
    isSelected = !isSelected;
  }

  bool isSelected = false;
  ElevatedButton buildButton(int index, Widget Column) {
    return ElevatedButton(
      onPressed: () {
        selectButton(index);

        BlocProvider.of<BargainBloc>(context).add(getHotelCategory(index));
        isSelected = !isSelected;
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.elliptical(12, 12),
          ),
          side: BorderSide(color: Colors.blue),
        ),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        minimumSize: Size(45, 40),
        backgroundColor: selectedButtonIndex == index
            ? PrimaryColors.primaryblue
            : whiteColor,
      ),
      child: Column,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildButton(
          0,
          Column(
            children: [
              Icon(
                Icons.villa_outlined,
                color: selectedButtonIndex == 0
                    ? whiteColor
                    : PrimaryColors.primaryblue,
              ),
              Text(
                'Normal',
                style: TextStyle(
                  fontSize: 10,
                  color: selectedButtonIndex == 0
                      ? whiteColor
                      : PrimaryColors.primaryblue,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 10),
        buildButton(
            1,
            Column(
              children: [
                Icon(
                  Icons.castle_outlined,
                  color: selectedButtonIndex == 1
                      ? whiteColor
                      : PrimaryColors.primaryblue,
                ),
                Text(
                  'Budget',
                  style: TextStyle(
                    fontSize: 10,
                    color: selectedButtonIndex == 1
                        ? whiteColor
                        : PrimaryColors.primaryblue,
                  ),
                ),
              ],
            )),
        SizedBox(width: 10),
        buildButton(
          2,
          Column(
            children: [
              Icon(
                Icons.synagogue_outlined,
                color: selectedButtonIndex == 2
                    ? whiteColor
                    : PrimaryColors.primaryblue,
              ),
              Text(
                'Star',
                style: TextStyle(
                  fontSize: 10,
                  color: selectedButtonIndex == 2
                      ? whiteColor
                      : PrimaryColors.primaryblue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BedCategory extends StatefulWidget {
  TextEditingController controller;
  BedCategory({super.key, required this.controller});
  @override
  _BedCategoryState createState() => _BedCategoryState();
}

class _BedCategoryState extends State<BedCategory> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectButton(0);
  }

  int selectedButtonIndex = -1;

  void selectButton(int index) {
    setState(() {
      BedIndex = index;
      selectedButtonIndex = index;
      print(CatIndex);
      print(BedIndex);
      if (CatIndex == 0 && BedIndex == 0) {
        widget.controller.text = "1100";
      }
      if (CatIndex == 1 && BedIndex == 0) {
        widget.controller.text = "1500";
      }
      if (CatIndex == 2 && BedIndex == 0) {
        widget.controller.text = "2000";
      }
      if (CatIndex == 0 && BedIndex == 1) {
        widget.controller.text = "2500";
      }
      if (CatIndex == 1 && BedIndex == 1) {
        widget.controller.text = "3000";
      }
      if (CatIndex == 2 && BedIndex == 1) {
        widget.controller.text = "4000";
      }
      if (CatIndex == 0 && BedIndex == 2) {
        widget.controller.text = "4200";
      }
      if (CatIndex == 1 && BedIndex == 2) {
        widget.controller.text = "6000";
      }
      if (CatIndex == 2 && BedIndex == 2) {
        widget.controller.text = "8000";
      }
    });

    BlocProvider.of<BargainBloc>(context).add(getNoOfBed(index));
  }

  ElevatedButton buildButton(int index, String buttonText) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.elliptical(80, 80),
            ),
            side: BorderSide(color: PrimaryColors.primaryblue)),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        backgroundColor: selectedButtonIndex == index
            ? PrimaryColors.primaryblue
            : whiteColor,
      ),
      onPressed: () {
        selectButton(index);
      },
      child: Text(
        buttonText,
        style: TextStyle(
          color: selectedButtonIndex == index
              ? whiteColor
              : PrimaryColors.primaryblue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildButton(0, 'Single Bed'),
        SizedBox(width: 10),
        buildButton(1, 'Double Bed'),
        SizedBox(width: 10),
        buildButton(2, 'Triple Bed'),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final double? size;
  final String label;
  final void Function()? onpressed;
  const CustomButton({
    required this.onpressed,
    this.size,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: PrimaryColors.primaryblue,
      ),
      onPressed: onpressed,
      child: Text(
        label,
        style: TextStyle(fontFamily: 'Poppins', fontSize: size),
      ),
    );
  }
}

class AcceptDecline extends StatelessWidget {
  final void Function()? onpressed;
  final Color bgcolor;
  final String label;
  const AcceptDecline({
    required this.onpressed,
    required this.bgcolor,
    required this.label,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onpressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor,
        ),
        child: Text(
          label,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 14),
        ),
      ),
    );
  }
}
