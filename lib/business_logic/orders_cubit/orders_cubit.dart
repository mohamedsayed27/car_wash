import 'package:car_wash/data/data_source/remote_data_source/orders_remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/network/error_message_model.dart';
import '../../core/services/services_locator.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());


  final OrdersRemoteDatasource _ordersRemoteDatasource = sl();

  static OrdersCubit get(context) => BlocProvider.of(context);

  BaseErrorModel? baseErrorModel;


}
