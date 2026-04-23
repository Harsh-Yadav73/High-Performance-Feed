import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/post_model.dart';
import '../providers/like_provider.dart';
import '../core/supabase_client.dart';
import '../screens/detail_screen.dart';

class PostCard extends ConsumerWidget {
  final Post post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final liked = ref.watch(likeProvider)[post.id] ?? false;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailScreen(post: post),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),

          /// 🔥 Gradient background
          gradient: LinearGradient(
            colors: [
              Colors.grey.shade900,
              Colors.black,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),

          /// 🔥 Heavy shadow (assignment requirement)
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.8),
              blurRadius: 25,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🖼 IMAGE
              Hero(
                tag: post.id,
                child: CachedNetworkImage(
                  imageUrl: post.thumb,
                  memCacheWidth: 300,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,

                  placeholder: (context, url) => Container(
                    height: 220,
                    color: Colors.grey.shade800,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),

                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error, color: Colors.red),
                ),
              ),

              /// ❤️ ACTION BAR
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// ❤️ LIKE SECTION
                    Row(
                      children: [
                        AnimatedScale(
                          duration: const Duration(milliseconds: 200),
                          scale: liked ? 1.2 : 1.0,
                          child: IconButton(
                            icon: Icon(
                              liked
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color:
                              liked ? Colors.redAccent : Colors.white,
                            ),

                            /// ✅ FIXED: LIKE FUNCTION BACK
                            onPressed: () async {
                              /// Optimistic UI
                              ref
                                  .read(likeProvider.notifier)
                                  .toggle(post.id);

                              try {
                                await supabase.rpc('toggle_like', params: {
                                  'p_post_id': post.id,
                                  'p_user_id': 'user_123',
                                });
                              } catch (e) {
                                /// Silent revert (no message)
                                ref
                                    .read(likeProvider.notifier)
                                    .toggle(post.id);
                              }
                            },
                          ),
                        ),

                        /// ❤️ LIKE COUNT (REAL-TIME FEEL)
                        Text(
                          "${post.likes + (liked ? 1 : 0)}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    /// ⋮ MORE ICON
                    const Icon(
                      Icons.more_vert,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}