import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/app_theme/custom_font_weights.dart';
import '../../../core/app_theme/custom_themes.dart';
import '../../../data/models/order_models/single_order_model.dart';
import '../shared_widgets/agent_details_widget.dart';
import '../shared_widgets/custom_sized_box.dart';

class AgentComponent extends StatelessWidget {
  final Representative? representative;
  const AgentComponent({super.key, this.representative});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "المندوب",
          style: CustomThemes.primaryColorTextTheme(context).copyWith(
            fontSize: 16.sp,
            fontWeight: CustomFontWeights.bold,
          ),
        ),
        const CustomSizedBox(
          height: 16,
        ),
        AgentDetailsWidget(representative: representative,),
      ],
    );
  }
}
