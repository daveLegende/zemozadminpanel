// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'dart:typed_data';

import 'package:admin/api/url.dart';
import 'package:admin/constant.dart';
import 'package:admin/helper.dart';
import 'package:admin/models/admin.dart';
import 'package:admin/models/equipe.dart';
import 'package:admin/models/event.dart';
import 'package:admin/models/poules.dart';
import 'package:admin/services/preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class ApiRepositeries extends GetxController {
  var tmsg = "".obs;
  var pmsg = "".obs;
  var mmsg = "".obs;

  var tb = false.obs;
  var pb = false.obs;
  var mb = false.obs;

  void setMessage(Rx<String> oldmsg, String newmsg) {
    oldmsg.value = newmsg;
  }

  void setLoading(Rx<bool> oldb, bool loading) {
    oldb.value = loading;
  }

  // add teams
  Future<void> addTeam(
      {required EquipeModel equipe,
      required Uint8List image,
      required BuildContext context}) async {
    try {
      setMessage(tmsg, loading);
      final token = await PreferenceServices().getToken();

      var request = http.MultipartRequest('POST', Uri.parse(APIURL.addTeamUrl));

      request.fields['nom'] = equipe.nom;
      request.fields['coach'] = equipe.coach;
      request.fields['commune'] = equipe.commune;
      request.fields['joueurs'] = equipe.joueurs.join(", ");
      print("-------------------${jsonEncode(equipe.joueurs)}");
      request.files.add(
        http.MultipartFile.fromBytes(
          "logo",
          image.cast(),
          // await File(event.equipe.logo).length(),
          filename: equipe.logo.split('/').last,
          contentType: MediaType('image', '*'),
        ),
      );
      // var file = await http.MultipartFile.fromPath(
      //   'logo',
      //   event.equipe.logo,
      //   // await File(event.equipe.logo).length(),
      //   filename: event.equipe.logo.split('/').last,
      //   contentType: MediaType('image',
      //       '*'), // Assurez-vous d'adapter le type de contenu correctement
      // );
      // request.files.add(file);
      request.headers.addAll({
        "Content-type": "multipart/form-data",
        'Authorization': "Bearer " + token!,
        // "Authorization": "Bearer $token",
      });

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = await response.stream.bytesToString();
        print('Réponse du serveur : $responseData');
        setMessage(tmsg, "${equipe.nom} créée avec succès");
        Helper().mySuccessToast("${equipe.nom} créée avec succès", context);
      } else if (response.statusCode == 404) {
        print('Equipe ${equipe.nom} existe déja');
        setMessage(tmsg, "${equipe.nom} existe déja");
        Helper().myErrorToast("${equipe.nom} existe déja", context);
      } else {
        print("Erreur du serveur, status code : ${response.statusCode}");
        setMessage(tmsg, "Une erreur est survenue, veuilllez réssayer");
        Helper().myErrorToast(
            "Une erreur est survenue, veuilllez réssayer", context);
      }
    } catch (e) {
      print(e);
      setMessage(tmsg, "Erreur du serveur");
      Helper().myErrorToast("Erreur de serveur", context);
    }
  }

  // update team
  Future<bool> updateTeam(
      {required EquipeModel equipe,
      required Uint8List image,
      required BuildContext context}) async {
    try {
      final token = await PreferenceServices().getToken();

      var request =
          http.MultipartRequest('PUT', Uri.parse(APIURL.updateTeamUrl));
      print("--***********${request.fields}");

      request.fields['nom'] =
          equipe.nom == "" ? request.fields['nom']! : equipe.nom;
      request.fields['coach'] =
          equipe.coach == "" ? request.fields['coach']! : equipe.coach;
      request.fields['commune'] =
          equipe.commune == "" ? request.fields['commune']! : equipe.commune;
      request.fields['joueurs'] = equipe.joueurs.isEmpty
          ? request.fields['joueurs']!
          : equipe.joueurs.join(", ");

      request.fields['teamId'] = equipe.id!;
      if (image != null) {
        request.files.add(
          http.MultipartFile.fromBytes(
            'logo',
            image,
            filename: 'logo.png',
            contentType: MediaType('image', 'png'),
          ),
        );
      }

      request.headers.addAll({
        'Content-type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      });

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        print('Réponse du serveur : $responseData');
        Helper().mySuccessToast("Équipe mise à jour avec succès", context);
        return true;
      } else if (response.statusCode == 404) {
        print('Équipe non trouvée');
        Helper().myErrorToast("Équipe non trouvée", context);
        return false;
      } else {
        print("Erreur du serveur, status code : ${response.statusCode}");
        Helper().myErrorToast("Erreur du serveur, veuillez réessayer", context);
        return false;
      }
    } catch (e) {
      print(e);
      // setMessage(tmsg, "Erreur du serveur");
      Helper().myErrorToast("Erreur de serveur", context);
      return false;
    }
  }

  // ajouter poules
  Future<void> addPoule(
      {required String nom,
      required List<String> equipes,
      required BuildContext context}) async {
    try {
      setMessage(pmsg, loading);
      final token = await PreferenceServices().getToken();

      final response = await http.post(
        Uri.parse(APIURL.addPouleUrl),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          'nom': nom,
          'equipes': equipes,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setMessage(pmsg, "$nom créée avec succès");
        setLoading(pb, true);
        Helper().mySuccessToast("$nom créée avec succès", context);
      } else if (response.statusCode == 404) {
        setMessage(pmsg, "$nom existe déja");
        Helper().myErrorToast("$nom existe déja", context);
      } else {
        print("Erreur du serveur, status code : ${response.statusCode}");
        setMessage(pmsg,
            "Une erreur est survenue, certaine(s) équipes sont déja dans une poule");
        Helper().myErrorToast(
            "Une erreur est survenue, certaine(s) équipes sont déja dans une poule",
            context);
      }
    } catch (e) {
      print(e);
      setMessage(pmsg, "Erreur du serveur");
      Helper().myErrorToast("Erreur de serveur", context);
    }
  }

  // match
  Future<void> createMatch(
      {required String homeId,
      required String awayId,
      required String pouleId,
      required String type,
      required String date,
      required BuildContext context}) async {
    try {
      setMessage(mmsg, loading);
      String? token = await PreferenceServices().getToken();

      final response = await http.post(
        Uri.parse(APIURL.createMatchURL),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({
          "homeId": homeId,
          "awayId": awayId,
          "type": type,
          "pouleId": pouleId,
          "date": date,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setMessage(mmsg, "Confrontation créée avec succès");
        setLoading(mb, true);
        Helper().mySuccessToast("Confrontation créée avec succès", context);
      } else if (response.statusCode == 404) {
        setMessage(mmsg, "Cette Confrontation existe déja");
        Helper().myErrorToast("Cette Confrontation existe déja", context);
      } else if (response.statusCode == 403) {
        setMessage(mmsg, response.body);
        Helper().myErrorToast(response.body, context);
      } else {
        print("Erreur du serveur, status code : ${response.statusCode}");
        setMessage(mmsg,
            "Une erreur est survenue, certaine(s) équipes sont déja dans une poule");
        Helper().myErrorToast(
            "Une erreur est survenue, certaine(s) équipes sont déja dans une poule",
            context);
      }
    } catch (e) {
      print(e);
      setMessage(mmsg, "Erreur du serveur");
      Helper().myErrorToast("Erreur de serveur", context);
    }
  }

  // stop match
  Future<void> stopMatch(
      {required String matchId, required BuildContext context}) async {
    try {
      setMessage(pmsg, loading);
      final token = await PreferenceServices().getToken();

      final response = await http.post(
        Uri.parse(APIURL.stopMatchURL),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({'matchId': matchId}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Helper().mySuccessToast("Match arrêté avec succès", context);
      } else {
        print("Erreur du serveur, status code : ${response.statusCode}");
        Helper().myErrorToast(
            "Une erreur s'est produite...veuillez réessayer", context);
      }
    } catch (e) {
      print(e);
      setMessage(pmsg, "Erreur du serveur");
      Helper().myErrorToast("Erreur de serveur", context);
    }
  }

  // debuter match
  Future<bool> beginMatch(
      {required String matchId, required BuildContext context}) async {
    try {
      final token = await PreferenceServices().getToken();

      final response = await http.post(
        Uri.parse(APIURL.beginMatch),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({'matchId': matchId}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Helper().mySuccessToast("Match débuté avec succès", context);
        return true;
      } else {
        print("Erreur du serveur, status code : ${response.statusCode}");
        Helper().myErrorToast(
            "Une erreur s'est produite...veuillez réessayer", context);
        return false;
      }
    } catch (e) {
      print(e);
      Helper().myErrorToast("Erreur de serveur", context);
      return false;
    }
  }

  // supprimé match
  Future<bool> deleteMatch(
      {required String matchId, required BuildContext context}) async {
    try {
      final token = await PreferenceServices().getToken();

      final response = await http.post(
        Uri.parse(APIURL.deleteOneMatch),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({'matchId': matchId}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Helper().mySuccessToast("Match supprimée avec succès", context);
        return true;
      } else {
        print("Erreur du serveur, status code : ${response.statusCode}");
        Helper().myErrorToast(
            "Suppresion impossible...veuillez réessayer", context);
        return false;
      }
    } catch (e) {
      print(e);
      Helper().myErrorToast("Erreur de serveur", context);
      return false;
    }
  }

  // supprimé match
  Future<bool> deleteAdmin(
      {required Admin admin, required BuildContext context}) async {
    try {
      final token = await PreferenceServices().getToken();

      final response = await http.delete(
        Uri.parse(APIURL.deleteAdmintURL),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({'adminId': admin.id}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Helper().mySuccessToast(
            "L'admin ${admin.email} supprimé avec succès", context);
        return true;
      } else {
        print("Erreur du serveur, status code : ${response.statusCode}");
        Helper().myErrorToast(
            "Suppresion impossible...veuillez réessayer", context);
        return false;
      }
    } catch (e) {
      print(e);
      Helper().myErrorToast("Erreur de serveur", context);
      return false;
    }
  }

  // supprimé équipe
  Future<bool> deleteTeam(
      {required EquipeModel team, required BuildContext context}) async {
    try {
      setMessage(pmsg, loading);
      final token = await PreferenceServices().getToken();

      final response = await http.delete(
        Uri.parse(APIURL.deleteOneTeam),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({'teamId': team.id!}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        Helper().mySuccessToast("${team.nom} supprimé avec succès", context);
        return true;
      } else {
        print("Erreur du serveur, status code : ${response.statusCode}");
        Helper().myErrorToast(
            "Suppression de ${team.nom} échouée ...veuillez réessayer",
            context);
        print(response.body);
        return false;
      }
    } catch (e) {
      print(e);
      setMessage(pmsg, "Erreur du serveur");
      Helper().myErrorToast("Erreur de serveur", context);
      return false;
    }
  }

  // supprimé équipe
  Future<bool> deletePoule(
      {required PouleModel poule, required BuildContext context}) async {
    try {
      setMessage(pmsg, loading);
      final token = await PreferenceServices().getToken();

      final response = await http.delete(
        Uri.parse(APIURL.deleteOnePoule),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({'pouleId': poule.id!}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.body);
        Helper().mySuccessToast("${poule.nom} supprimé avec succès", context);
        return true;
      } else {
        print("Erreur du serveur, status code : ${response.statusCode}");
        Helper().myErrorToast(
            "Suppression de ${poule.nom} échouée ...veuillez réessayer",
            context);
        print(response.body);
        return false;
      }
    } catch (e) {
      print(e);
      setMessage(pmsg, "Erreur du serveur");
      Helper().myErrorToast("Erreur de serveur", context);
      return false;
    }
  }

  // events
  // add teams
  Future<bool> addEvent(
      {required EventModel event,
      required Uint8List image,
      required BuildContext context}) async {
    try {
      final token = await PreferenceServices().getToken();

      var request =
          http.MultipartRequest('POST', Uri.parse(APIURL.createEventURL));

      request.fields['title'] = event.title;
      request.fields['desc'] = event.desc;

      request.files.add(
        http.MultipartFile.fromBytes(
          "logo",
          image.cast(),
          // await File(event.equipe.logo).length(),
          filename: event.image.split('/').last,
          contentType: MediaType('image', '*'),
        ),
      );

      request.headers.addAll({
        "Content-type": "multipart/form-data",
        'Authorization': "Bearer " + token!,
      });

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = await response.stream.bytesToString();
        print('Réponse du serveur : $responseData');
        Helper().mySuccessToast("${event.title} créé avec succès", context);
        return true;
      } else if (response.statusCode == 404) {
        print('${event.title} existe déja');
        Helper().myErrorToast("${event.title} existe déja", context);
        return false;
      } else {
        var responseData = await response.stream.bytesToString();
        print("Erreur du serveur, status code : ${response.statusCode}");
        print("Erreur du serveur, status code : ${responseData}");
        Helper().myErrorToast(
            "Une erreur est survenue, veuilllez réssayer", context);
        return false;
      }
    } catch (e) {
      print(e);
      Helper().myErrorToast("Erreur de serveur", context);
      return false;
    }
  }

  // Edit event
  // add teams
  Future<bool> updateEvent(
      {required EventModel event,
      required Uint8List image,
      required BuildContext context}) async {
    try {
      final token = await PreferenceServices().getToken();

      var request =
          http.MultipartRequest('POST', Uri.parse(APIURL.editEventURL));

      request.fields['title'] = event.title;
      request.fields['desc'] = event.desc;
      request.fields['id'] = event.id!;

      request.files.add(
        http.MultipartFile.fromBytes(
          "logo",
          image.cast(),
          // await File(event.equipe.logo).length(),
          filename: event.image.split('/').last,
          contentType: MediaType('image', '*'),
        ),
      );

      request.headers.addAll({
        "Content-type": "multipart/form-data",
        'Authorization': "Bearer " + token!,
      });

      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseData = await response.stream.bytesToString();
        print('Réponse du serveur : $responseData');
        Helper().mySuccessToast("${event.title} modifié avec succès", context);
        return true;
      } else if (response.statusCode == 404) {
        print('Event ${event.title} existe déja');
        Helper().myErrorToast("${event.title} existe déja", context);
        return false;
      } else {
        var responseData = await response.stream.bytesToString();
        print("Erreur du serveur, status code : ${response.statusCode}");
        print("Erreur du serveur, status code : ${responseData}");
        Helper().myErrorToast(
            "Une erreur est survenue, veuilllez réssayer", context);
        return false;
      }
    } catch (e) {
      print(e);
      Helper().myErrorToast("Erreur de serveur", context);
      return false;
    }
  }

  // supprimé une annonce
  Future<bool> deleteEvent(
      {required EventModel event, required BuildContext context}) async {
    try {
      final token = await PreferenceServices().getToken();

      final response = await http.delete(
        Uri.parse(APIURL.deleteEventURL),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({'eventId': event.id!}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Helper().mySuccessToast(
            "L'annonce : '${event.title}' supprimé avec succès", context);
        return true;
      } else {
        print("Erreur du serveur, status code : ${response.statusCode}");
        print("Erreur du serveur, status code : ${response.body}");
        Helper().myErrorToast(
            "Suppresion impossible...veuillez réessayer", context);
        return false;
      }
    } catch (e) {
      print(e);
      Helper().myErrorToast("Erreur de serveur", context);
      return false;
    }
  }

  //  dépot
}
