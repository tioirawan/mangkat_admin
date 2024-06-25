import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vector_map_tiles/vector_map_tiles.dart';

final mapTileProvider = FutureProvider<Style>((ref) async {
  return StyleReader(
    uri:
        'https://api.maptiler.com/maps/abc58b1d-37ff-42b0-b89b-8f3bca4997be/style.json?key={key}',
    apiKey: '5kAH8xdBXlYW5kuJQF8y',
  ).read();
});
