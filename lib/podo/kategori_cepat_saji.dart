import 'package:http/http.dart' as http;
import 'package:pdp_wisatakuliner/util/kategori_cepat_saji.dart';

class CepatSajiServices {
  //
  static const String url =
      'https://www.wisatakuapps.com/api/wisatakuApp/kategori_cepat_saji.php';
  static Future<List<CepatSaji>> getCepatSaji() async {
    try {
      final response = await http.get(url);
      if (200 == response.statusCode) {
        final List<CepatSaji> cepatSaji = cepatSajiFromJson(response.body);
        return cepatSaji;
      } else {
        return List<CepatSaji>();
      }
    } catch (e) {
      return List<CepatSaji>();
    }
  }
}
