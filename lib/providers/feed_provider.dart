import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/supabase_client.dart';
import '../models/post_model.dart';

final feedProvider =
StateNotifierProvider<FeedController, List<Post>>((ref) {
  return FeedController();
});

class FeedController extends StateNotifier<List<Post>> {
  FeedController() : super([]);

  int page = 0;
  bool loading = false;

  Future<void> fetch({bool refresh = false}) async {
    if (loading) return;
    loading = true;

    if (refresh) {
      page = 0;
      state = [];
    }

    final res = await supabase
        .from('posts')
        .select();

    print("RAW RESPONSE: $res"); // 👈 ADD THIS

    final data = (res as List)
        .map((e) => Post.fromJson(e))
        .toList();

    state = [...state, ...data];
    page++;
    loading = false;
  }
}