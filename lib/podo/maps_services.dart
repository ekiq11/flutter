import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/util/mpas_list.dart';

class MapsServices {
  static const String url =
      'https://www.wisatakuapps.com/api/wisatakuApp/lihat_menu.php';
  static Future<List<Maps>> getMaps() async {
    try {
      final response = await http.get(url);
      print(url);
      if (200 == response.statusCode) {
        final List<Maps> maps = mapsFromJson(response.body);
        return maps;
      } else {
        return List<Maps>();
      }
    } catch (e) {
      return List<Maps>();
    }
  }
}
