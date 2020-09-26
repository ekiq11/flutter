import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/util/kategori_minuman.dart';

class MinumanServices {
  //
  static const String url =
      'https://www.wisatakuapps.com/api/wisatakuApp/kategori_minuman.php';
  static Future<List<Minuman>> getMinuman() async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<Minuman> minuman = minumanFromJson(response.body);
        return minuman;
      } else {
        return List<Minuman>();
      }
    } catch (e) {
      return List<Minuman>();
    }
  }
}
