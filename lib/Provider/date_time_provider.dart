import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateProvider = StateProvider<String>((StateProviderRef<String> ref) {
  return "dd/mm/yy";
});

final timeProvider = StateProvider<String>((StateProviderRef<String> ref) {
  return "hh : mm";
});
