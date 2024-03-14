import 'package:car_wash/core/assets_path/svg_path.dart';
import 'package:car_wash/presentation/widgets/choose_car_type_and_location_on_map_widgets/car_type_widget.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

class CarTypeList extends StatefulWidget {
  const CarTypeList({super.key});

  @override
  State<CarTypeList> createState() => _CarTypeListState();
}

class _CarTypeListState extends State<CarTypeList> {
  List<Map<String, dynamic>> itemsList = [
    {
      "svgPath": SvgPath.smallCar,
      "title": "حجم صغير",
      "description": "( 5 مقاعد )",
    },
    {
      "svgPath": SvgPath.bigCar,
      "title": "حجم كبير",
      "description": "( مركبات البيك اب و ذات الـ 7 , 8 مقاعد )",
    },
  ];
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (_, index) {
        return CarTypeWidget(isSelected: currentIndex == index, svgPath: itemsList[index]["svgPath"], title: itemsList[index]['title'], description: itemsList[index]['description'],onPressed: (){
          setState(() {
            currentIndex = index;
          });
        },);
      },
      separatorBuilder: (_, index) {
        return const CustomSizedBox(height: 16,);
      },
      itemCount: 2,
    );
  }
}
