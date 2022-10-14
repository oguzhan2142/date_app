import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/providers/repository_providers.dart';

import '../../../model/match_user.dart';
import '../../../repository/i_api_repository.dart';

final matchUserProvider = ChangeNotifierProvider<MatchUserNotifier>((ref) {
  IApiRepository apiRepository = ref.read(apiRepositoryProvider);
  return MatchUserNotifier(apiRepository: apiRepository);
});

class MatchUserNotifier extends ChangeNotifier {
  final IApiRepository apiRepository;

  MatchUser? matchUser;

  MatchUserNotifier({
    required this.apiRepository,
    this.matchUser,
  });

  void nextMatch() async {
    var nextUser = await apiRepository.getNextMatchUser();

    matchUser = nextUser;
    print('notified');
    notifyListeners();
  }
}
