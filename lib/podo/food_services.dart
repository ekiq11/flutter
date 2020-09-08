import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/util/tesfood.dart';

class Services {
  //
  static const String url =
      'http://belajar.junioracademy.id/api/lihat_menu.php';
  static Future<List<Food>> getFoods() async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<Food> foods = foodFromJson(response.body);
        return foods;
      } else {
        return List<Food>();
      }
    } catch (e) {
      return List<Food>();
    }
  }
}
