import 'dart:async';
import 'dart:convert';

import 'package:admin/api/url.dart';
import 'package:admin/helper.dart';
import 'package:admin/models/match_model.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RepoSocket {
  final WebSocketChannel channel =
      WebSocketChannel.connect(Uri.parse(APIURL.socketURL));

  final matchUpdatesController = StreamController<MatchModel>();
  // commencer ou terminer un match
  Future<bool> startOrEndMatch(
      {required BuildContext context,
      required String matchId,
      required String matchState}) async {
    try {
      final message = {
        'type': 'matchState',
        "matchId": matchId,
        "matchState": matchState,
      };
      channel.sink.add(jsonEncode(message));
      final toastMessage = matchState == "TERMINER"
          ? "Match terminé avec succès"
          : "Match débuté avec succès";
      Helper().mySuccessToast(toastMessage, context);
      return true;
    } catch (e) {
      print('Erreur du serveur $e');
      Helper().myErrorToast("Une erreur est survenue, veuillez réessayer", context);
      return false;
    }
  }
}
