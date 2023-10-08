import 'package:flutter_riverpod/flutter_riverpod.dart';

final radioProvider =
    StateProvider.autoDispose<int>((StateProviderRef<int> ref) {
  return 0;
});
