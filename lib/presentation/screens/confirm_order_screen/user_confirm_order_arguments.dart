
import 'package:car_wash/data/models/time_schedule/time_schedule.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/car_types_model/car_types_model.dart';
import '../../../data/models/plans_model/all_plans_model.dart';
import '../car_services_screen/car_services_screen.dart';

class UserConfirmOrderArguments extends Equatable {
  final CarServicesArgument carServicesArgument;
  final TimeScheduleModel timeScheduleModel;
  final TimeModel timeModel;
  final ContentImageModel servicesModel;
  final AllPlansModel allPlansModel;

  const UserConfirmOrderArguments({
    required this.carServicesArgument,
    required this.timeScheduleModel,
    required this.servicesModel,
    required this.timeModel,
    required this.allPlansModel,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        carServicesArgument,
        timeScheduleModel,
        servicesModel,
        allPlansModel,
        timeModel,
      ];
}
