part of "car_services_screen.dart";

class CarServicesArgument extends Equatable {
  final ContentImageModel? contentImageModel;
  final String addressId;

  const CarServicesArgument({
    this.contentImageModel,
    required this.addressId,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        contentImageModel,
        addressId,
      ];
}
