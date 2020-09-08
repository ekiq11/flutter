import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/util/kategori_rating.dart';
import 'package:pdp_wisatakuliner/util/kategori_search.dart';

class RatingServices {
  static const String url =
      'http://belajar.junioracademy.id/api/tampil_rating.php?id_menu=';
  static Future<List<Rating>> getRating(String idMenu) async {
    try {
      final response = await http.get(url + idMenu);
      print(url + idMenu);
      if (200 == response.statusCode) {
        final List<Rating> rating = ratingFromJson(response.body);
        return rating;
      } else {
        return List<Rating>();
      }
    } catch (e) {
      return List<Rating>();
    }
  }
}
