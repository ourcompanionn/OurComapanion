import 'package:flutter_riverpod/legacy.dart';

final currentLocationPulseProvider =
    StateProvider.autoDispose<double>((ref) => 0);