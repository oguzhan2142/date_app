import 'package:frontend/base/view_model.dart';

import 'package:frontend/interface/authenticated.dart';
import 'package:provider/provider.dart';

import '../model/chat_match.dart';
import '../repository/chat_repository.dart';

class ChatViewModel extends ViewModel with IAuthenticated {
  late final ChatRepository chatRepository;

  List<ChatMatch>? chatMatches;

  bool isLoading = false;

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  ChatViewModel({required super.context}) {
    chatRepository = Provider.of<ChatRepository>(context, listen: false);
    _initData();
  }

  void _initData() async {
    _setLoading(true);

    await _initMatches();
    _setLoading(false);
  }

  Future<void> _initMatches() async {
    chatMatches = await chatRepository.getMatches(userId: id!);
  }
}
