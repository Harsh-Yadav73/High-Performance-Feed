import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/feed_provider.dart';
import '../widgets/post_card.dart';
import '../widgets/shimmer_widget.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    /// Initial Fetch
    Future.microtask(() {
      ref.read(feedProvider.notifier).fetch();
    });

    /// Infinite Scroll
    controller.addListener(() {
      if (controller.position.pixels >=
          controller.position.maxScrollExtent - 200) {
        ref.read(feedProvider.notifier).fetch();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(feedProvider);

    return Scaffold(
      backgroundColor: Colors.black,

      /// 🔥 PREMIUM APPBAR
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "High Performance Feed",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.black,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      /// 🔥 BODY
      body: posts.isEmpty
          ? const FeedShimmer() // 👈 Premium loading
          : RefreshIndicator(
        onRefresh: () async {
          await ref
              .read(feedProvider.notifier)
              .fetch(refresh: true);
        },
        child: ListView.builder(
          controller: controller,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(vertical: 10),
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return RepaintBoundary(
              child: PostCard(post: posts[index]),
            );
          },
        ),
      ),
    );
  }
}