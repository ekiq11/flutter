import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/util/lokasi.dart';

class LokasiServices {
  static const String url =
      'https://www.wisatakuapps.com/api/wisatakuApp/tampil_lokasi.php?id_user=';
  static Future<List<Lokasi>> getLokasi(String id) async {
    try {
      final response = await http.get(url + id);
      print(url + id);
      if (200 == response.statusCode) {
        final List<Lokasi> menu = lokasiFromJson(response.body);
        return menu;
      } else {
        return List<Lokasi>();
      }
    } catch (e) {
      return List<Lokasi>();
    }
  }
}
