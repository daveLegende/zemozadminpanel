import 'package:shared_preferences/shared_preferences.dart';
import 'package:admin/api/config.dart';

class PreferenceServices {
  // set token
  Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool success = await prefs.setString(MyConfig().token, token);

    if (success) {
      print("Token enregistré avec succès");
    } else {
      print("Erreur lors de l'enregistrement du token");
    }
  }

  // get token
  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? success = await prefs.getString(MyConfig().token);

    if (success != null) {
      print("Token réccupéré avec succès $success");
      return success;
    } else {
      print("Erreur lors de la récupération du token");
      return null;
    }
  }

  // supprimer token
  Future<void> removeToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool success = await prefs.remove(MyConfig().token);

    if (success) {
      print("Token supprimé avec succès $success");
    } else {
      print("Erreur lors de la suppression du token");
    }
  }
}
