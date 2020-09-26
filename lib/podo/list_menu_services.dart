import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/util/list_menu.dart';

class MenuServices {
  static const String url =
      'https://www.wisatakuapps.com/api/wisatakuApp/tampil_list_menu.php?id_user=';
  static Future<List<Menu>> getList(String id) async {
    try {
      final response = await http.get(url + id);
      print(url + id);
      if (200 == response.statusCode) {
        final List<Menu> menu = menuFromJson(response.body);
        return menu;
      } else {
        return List<Menu>();
      }
    } catch (e) {
      return List<Menu>();
    }
  }
}
