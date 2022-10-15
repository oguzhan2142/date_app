import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/match_user.dart';

final currentMatchProvider = StateProvider<MatchUser?>((ref) {
  return null;
});
