import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class ViewModel {
  final ProviderRef ref;

  ViewModel({
    required this.ref,
  });
}
