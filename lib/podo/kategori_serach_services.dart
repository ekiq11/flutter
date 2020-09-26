import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/util/kategori_search.dart';

class SearchServices {
  static const String url =
      'https://www.wisatakuapps.com/api/wisatakuApp/cari.php?keyword=';
  static Future<List<Search>> getSearch(String _searchControl) async {
    try {
      final response = await http.get(url + _searchControl);
      print(url + _searchControl);
      if (200 == response.statusCode) {
        final List<Search> keyword = searchFromJson(response.body);
        return keyword;
      } else {
        return List<Search>();
      }
    } catch (e) {
      return List<Search>();
    }
  }
}
