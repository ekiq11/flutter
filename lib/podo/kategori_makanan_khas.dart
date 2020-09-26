import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/util/kategori_makanan_khas.dart';

class MakananKhasServices {
  //
  static const String url =
      'https://www.wisatakuapps.com/api/wisatakuApp/kategori_makanan_khas.php';
  static Future<List<MakananKhas>> getMakananKhas() async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<MakananKhas> khas = makananKhasFromJson(response.body);
        return khas;
      } else {
        return List<MakananKhas>();
      }
    } catch (e) {
      return List<MakananKhas>();
    }
  }
}
