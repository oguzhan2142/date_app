import 'package:frontend/manager/request_manager.dart';

abstract class BaseRepository {
  final RequestManager requestManager;

  BaseRepository({
    required this.requestManager,
  });
}
