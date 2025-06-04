import 'package:car_wash/business_logic/address_cubit/address_cubit.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/constants.dart';
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
    return BlocConsumer<AddressCubit, AddressState>(
      listener: (context, state) {
        if (state is DeleteAddressSuccessState) {
          Navigator.pop(context);
          showToast(
            errorType: 0,
            message: "تم حذف العنوان",
          );
        }
        if (state is DeleteAddressLoadingState) {
          showProgressIndicator(context);
        }
        if (state is DeleteAddressErrorState) {
          Navigator.pop(context);
          showToast(
            errorType: 1,
            message: state.error,
          );
        }
      },
      builder: (context, state) {
        AddressCubit cubit = AddressCubit.get(context);
        return cubit.getAddressLoading
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (_, index) {
                  return AddressCheckButtonWidget(
                    isSelected: currentIndex == index,
                    title: cubit.getAddressesModel!.result![index].streetName!
                        .toString(),
                    description: cubit
                        .getAddressesModel!.result![index].streetName!
                        .toString(),
                    onPressed: () {},
                    addressId:
                        cubit.getAddressesModel!.result![index].id.toString(),
                  );
                },
                separatorBuilder: (_, index) {
                  return const CustomSizedBox(
                    height: 8,
                  );
                },
                itemCount: cubit.getAddressesModel!.result?.length??0,
              );
      },
    );
  }
}
