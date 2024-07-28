import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../shared_widgets/custom_sized_box.dart';

class SecondIndexComponent extends StatelessWidget {
  const SecondIndexComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return  const CustomSizedBox(
      height: 660,
      width: double.infinity,
      child: GoogleMap(
        myLocationButtonEnabled: false,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(23.61108120291162, 45.286281856525534),
          zoom: 11.5,
        ),
      ),
    );
  }
}
