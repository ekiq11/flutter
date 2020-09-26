import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/util/kategori_kue.dart';

class KueServices {
  //
  static const String url =
      'https://www.wisatakuapps.com/api/wisatakuApp/kategori_kue.php';
  static Future<List<Kue>> getKue() async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<Kue> kue = kueFromJson(response.body);
        return kue;
      } else {
        return List<Kue>();
      }
    } catch (e) {
      return List<Kue>();
    }
  }
}
