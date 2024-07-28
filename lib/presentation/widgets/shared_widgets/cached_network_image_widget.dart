import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String imagePath;
  final BoxFit? fit;
  const CachedNetworkImageWidget({super.key, this.width, this.height, required this.imagePath, this.fit,});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: imagePath,
      fit: fit,
      httpHeaders: const {
        'User-Agent': 'Chrome/96.0.4664.110',
      },
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[200]!,
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
