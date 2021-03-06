import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/util/komentar_tampil.dart';

class KomentarFavServices {
  static const String url =
      'https://www.wisatakuapps.com/api/wisatakuApp/tampil_komentar.php?id_menu=';
  static Future<List<Komentar>> getKomentar(String idMenu) async {
    try {
      final response = await http.get(url + idMenu);
      print(url + idMenu);
      if (200 == response.statusCode) {
        final List<Komentar> komentar = komentarFromJson(response.body);
        return komentar;
      } else {
        return List<Komentar>();
      }
    } catch (e) {
      return List<Komentar>();
    }
  }
}
