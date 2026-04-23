import 'package:flutter_riverpod/flutter_riverpod.dart';

final likeProvider =
StateNotifierProvider<LikeController, Map<String, bool>>(
      (ref) => LikeController(),
);

class LikeController extends StateNotifier<Map<String, bool>> {
  LikeController() : super({});

  void toggle(String id) {
    state = {...state, id: !(state[id] ?? false)};
  }
}