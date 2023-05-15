import 'package:cine_mapedia/presentation/providers/movies/movies_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialisLoadingProvider = Provider<bool>((ref) {
  final step1 = ref.watch(inPraesensMoviesProvider).isEmpty;
  final step2 = ref.watch(popularibusMoviesProvider).isEmpty;
  final step3 = ref.watch(moxMoviesProvider).isEmpty;
  final step4 = ref.watch(maximumPunctaMoviesProvider).isEmpty;

  if (step1 || step2 || step3 || step4) return true;

  return false;
});
