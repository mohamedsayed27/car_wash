import 'package:car_wash/data/models/base_response_model.dart';
import 'package:equatable/equatable.dart';

class GetAllTimeScheduleModel
    extends BaseResponseModel<List<TimeScheduleModel>> {
  const GetAllTimeScheduleModel({
    required super.success,
    required super.message,
    super.result,
  });

  factory GetAllTimeScheduleModel.fromJson(Map<String, dynamic> json) {
    return GetAllTimeScheduleModel(
      success: json['success'],
      message: json['message'],
      result: json['result'].isNotEmpty && json['result'] != null
          ? List<TimeScheduleModel>.from(
              json['result'].map((e) => TimeScheduleModel.fromJson(e)))
          : null,
    );
  }
}

class TimeScheduleModel extends Equatable {
  final int? id;
  final String? date;
  final List<TimeModel>? times;

  const TimeScheduleModel({
    this.id,
    this.date,
    this.times,
  });

  @override
  List<Object?> get props => [id, date, times];

  factory TimeScheduleModel.fromJson(Map<String, dynamic> json) {
    List<TimeModel>? timesList = [];
    if (json['times'] != null) {
      timesList = List<TimeModel>.from(
          json['times'].map((time) => TimeModel.fromJson(time)));
    }
    return TimeScheduleModel(
      id: json['id'],
      date: json['date'],
      times: timesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'times': times?.map((time) => time.toJson()).toList(),
    };
  }
}

class TimeModel extends Equatable {
  final int? id;
  final String? time;
  final int? availability;

  const TimeModel({
    this.id,
    this.time,
    this.availability,
  });

  @override
  List<Object?> get props => [id, time, availability];

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(
      id: json['id'],
      time: json['time'],
      availability: json['availability'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'time': time,
      'availability': availability,
    };
  }
}
