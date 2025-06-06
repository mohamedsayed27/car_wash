import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../business_logic/orders_cubit/orders_cubit.dart';
import '../shared_widgets/custom_sized_box.dart';
import 'car_type_widget.dart';

class CarTypeList extends StatefulWidget {
  final bool? shrinkWrap;
  const CarTypeList({super.key, this.shrinkWrap});

  @override
  State<CarTypeList> createState() => _CarTypeListState();
}

class _CarTypeListState extends State<CarTypeList> {
  @override
  void initState() {
    OrdersCubit.get(context).getCarTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = OrdersCubit.get(context);
        return CustomSizedBox(
          height: 132,
          child: cubit.getCarTypesLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : ListView.separated(
                  shrinkWrap: widget.shrinkWrap==null?false:true,
                  padding: EdgeInsets.zero,
                  physics: widget.shrinkWrap==null?null:const NeverScrollableScrollPhysics(),
                  itemBuilder: (_, index) {
                    return CarTypeWidget(
                      isSelected: cubit.carCurrentIndex == index,
                      imagesPath:
                          cubit.carTypesModel?.result?[index].image ?? "",
                      title: cubit.carTypesModel?.result?[index].name ?? "",
                      description:
                          cubit.carTypesModel?.result?[index].content ?? "",
                      onPressed: () {
                        if( cubit.carCurrentIndex == index){
                          cubit.removeSelection();
                        }else {
                          cubit.changeCarType(
                          index,
                          cubit.carTypesModel!.result![index],
                        );
                        }
                      },
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const CustomSizedBox(
                      height: 16,
                    );
                  },
                  itemCount: cubit.carTypesModel?.result?.length ?? 0,
                ),
        );
      },
    );
  }
}
