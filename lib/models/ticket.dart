import 'dart:convert';

class TicketModel {
  String? id;
  String type;
  String? duree;
  String? userId;
  String? amount;
  String date;
  String? isUsed;

  TicketModel({
    this.id,
    this.duree,
    this.userId,
    this.amount,
    this.isUsed,
    required this.type,
    required this.date,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) {
    return TicketModel(
      id: json["_id"].toString(),
      type: json["type"].toString(),
      duree: json["duree"].toString(),
      userId: json["userId"].toString(),
      amount: json["amount"].toString(),
      isUsed: json["isUsed"].toString(),
      date: json["date"].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "date": date,
      "amount": amount,
      "duree": duree,
    };
  }

  @override
  String toString() {
    return 'Id: $id\n'
        'Type: $type\n'
        'Durée: $duree\n'
        'User Id: $userId\n'
        'Amount: $amount\n'
        'isUsed: $isUsed\n'
        'Date: $date';
  }

  //
  factory TicketModel.fromString(String ticketString) {
    var parts = ticketString.split('\n');
    var id = parts[0].split(': ')[1];
    var type = parts[1].split(': ')[1];
    var duree = parts[2].split(': ')[1];
    var userId = parts[3].split(': ')[1];
    var amount = parts[4].split(': ')[1];
    var isUsed = parts[5].split(': ')[1];
    var date = parts[6].split(': ')[1];

    return TicketModel(
      id: id,
      type: type,
      duree: duree,
      userId: userId,
      amount: amount,
      isUsed: isUsed,
      date: date,
    );
  }
}

// list des tickets
List<TicketModel> ticketListFromJson(String jsonString) {
  var data = json.decode(jsonString);
  return List<TicketModel>.from(
    data.map((items) => TicketModel.fromJson(items)),
  );
}

String emplacement = "Tokoin Solidarité";

final constantTicket = TicketModel(
  type: "",
  date: "",
);
