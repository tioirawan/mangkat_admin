import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppConfig {
  final String mapTilerKey;

  AppConfig({
    required this.mapTilerKey,
  });
}

final configProvider = Provider<AppConfig>((ref) {
  final mapTilerKey = dotenv.env['MAP_TILER_KEY'];

  assert(mapTilerKey != null, 'MAP_TILER_KEY is not defined');
  return AppConfig(
    mapTilerKey: mapTilerKey!,
  );
});
