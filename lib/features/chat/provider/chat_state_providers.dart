import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/chat_match.dart';
import '../model/room.dart';

final matchesProvider = StateProvider<List<ChatMatch>>((ref) {
  return [];
});

final roomsProvider = StateProvider<List<Room>>((ref) {
  return [];
});
