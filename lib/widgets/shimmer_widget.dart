import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FeedShimmer extends StatelessWidget {
  const FeedShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (_, __) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade800,
            highlightColor: Colors.grey.shade700,
            child: Container(
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
            ),
          ),
        );
      },
    );
  }
}