part of "car_services_screen.dart";

class CarServicesArgument extends Equatable {
  final ContentImageModel? contentImageModel;
  final AddressModel addressModel;

  const CarServicesArgument({
    this.contentImageModel,
    required this.addressModel,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        contentImageModel,
    addressModel,
      ];
}
