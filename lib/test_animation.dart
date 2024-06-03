import 'package:car_wash/core/assets_path/images_path.dart';
import 'package:car_wash/presentation/widgets/shared_widgets/custom_sized_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestAnimation extends StatefulWidget {
  const TestAnimation({super.key});

  @override
  State<TestAnimation> createState() => _TestAnimationState();
}

class _TestAnimationState extends State<TestAnimation> {
  bool isGrid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () {
            isGrid = !isGrid;
            setState(() {});
          },
          icon: Icon(Icons.ac_unit),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isGrid?2:1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1
            ),
            itemBuilder: (_, index) => GridItem(index: index,),
            itemCount: 4,
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Hero(
          tag: "image",
          child: AnimatedContainer(
            height: 100,
            width: 100,
            duration: const Duration(
              milliseconds: 200,
            ),
            child: Image.asset(
              ImagesPath.dummyPersonImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        CustomSizedBox(
          width: 12,
        ),
        Hero(
          tag: "tag",
          child: Text(
            "data",
          ),
        ),
      ],
    );
  }
}

class GridItem extends StatelessWidget {
  final int index;
  const GridItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Hero(
          tag: "image$index",
          child: AnimatedContainer(
            height: 50,
            width: 50,
            duration: const Duration(
              milliseconds: 200,
            ),
            child: Image.asset(
              ImagesPath.dummyPersonImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        CustomSizedBox(
          height: 12,
        ),
        Hero(
          tag: "tag$index",
          child: Text(
            "data",
          ),
        ),
      ],
    );
  }
}
