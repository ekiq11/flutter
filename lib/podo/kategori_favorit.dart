import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/util/kategori_favorite.dart';

class FavoriteServices {
  static const String url =
      'https://www.wisatakuapps.com/api/wisatakuApp/lihat_favorite.php?id_user=';
  static Future<List<Favorite>> getFavorite(String idMenu) async {
    try {
      final response = await http.get(url + idMenu);
      print(url + idMenu);
      if (200 == response.statusCode) {
        final List<Favorite> favorit = favoriteFromJson(response.body);
        return favorit;
      } else {
        return List<Favorite>();
      }
    } catch (e) {
      return List<Favorite>();
    }
  }
}
