import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/util/tampi;_wilayah.dart';

class WilayahServices {
  static const String url =
      'https://www.wisatakuapps.com/api/wisatakuApp/tampil_list_wilayah.php';
  static Future<List<Wilayah>> getWilayah() async {
    try {
      final response = await http.get(url);
      print(url);
      if (200 == response.statusCode) {
        final List<Wilayah> wilayah = wilayahFromJson(response.body);
        return wilayah;
      } else {
        return List<Wilayah>();
      }
    } catch (e) {
      return List<Wilayah>();
    }
  }
}
