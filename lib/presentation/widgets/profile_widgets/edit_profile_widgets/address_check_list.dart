import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';

import 'address_check_item.dart';

class AddressCheckList extends StatefulWidget {
  const AddressCheckList({super.key});

  @override
  State<AddressCheckList> createState() => _AddressCheckListState();
}

class _AddressCheckListState extends State<AddressCheckList> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemBuilder: (_, index) {
        return AddressCheckButtonWidget(
          isSelected: currentIndex == index,
          title: "المنزل",
          description: "شارع - عمارة - المدينة",
          onPressed: () {
            setState(() {
              currentIndex = index;
            });
          },
        );
      },
      separatorBuilder: (_, index) {
        return const CustomSizedBox(
          height: 8,
        );
      },
      itemCount: 2,
    );
  }
}
