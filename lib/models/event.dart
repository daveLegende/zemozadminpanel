import 'dart:convert';

class EventModel {
  String? id;
  String title;
  String desc;
  String image;

  EventModel({
    this.id,
    required this.title,
    required this.desc,
    required this.image,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['_id'],
      title: json['title'],
      desc: json['desc'],
      image: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'desc': desc,
      'image': image.toString(),
    };
  }
}

// list des EventModel
List<EventModel> eventListFromJson(String jsonString) {
  var data = json.decode(jsonString);
  return List<EventModel>.from(
    data.map((items) => EventModel.fromJson(items)),
  );
}

// exe
const desc =
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Lectus sit amet est placerat in egestas erat imperdiet sed. Nibh nisl condimentum id venenatis a condimentum. Dictum sit amet justo donec enim diam. Ultrices tincidunt arcu non sodales. In ante metus dictum at. Faucibus nisl tincidunt eget nullam non nisi est sit. Venenatis cras sed felis eget velit aliquet sagittis. Tincidunt augue interdum velit euismod in. Tellus mauris a diam maecenas sed enim ut sem. Ultrices gravida dictum fusce ut placerat orci. Non quam lacus suspendisse faucibus interdum posuere. Pellentesque massa placerat duis ultricies lacus sed turpis tincidunt. Etiam non quam lacus suspendisse. Semper feugiat nibh sed pulvinar proin gravida hendrerit lectus a. Congue nisi vitae suscipit tellus mauris a. Id porta nibh venenatis cras sed felis eget velit aliquet. Faucibus a pellentesque sit amet porttitor eget dolor morbi non. Quisque non tellus orci ac auctor augue mauris. Sapien faucibus et molestie ac feugiat sed lectus.";
// List<EventModel> EventModel = [
//   EventModel(
//     title: "Conférence de lancement du tournoi",
//     desc: desc,
//     image: ["assets/foot.jpg", "assets/spetacle.jpeg", "assets/bet.jpg"],
//   ),
//   EventModel(
//     title: "Conférence de lancement du tournoi",
//     desc: desc,
//     image: ["assets/foot.jpg", "assets/spetacle.jpeg", "assets/bet.jpg"],
//   ),
//   EventModel(
//     title: "Conférence de lancement du tournoi",
//     desc: desc,
//     image: ["assets/foot.jpg", "assets/spetacle.jpeg", "assets/bet.jpg"],
//   ),
//   EventModel(
//     title: "Conférence de lancement du tournoi",
//     desc: desc,
//     image: ["assets/foot.jpg", "assets/spetacle.jpeg", "assets/bet.jpg"],
//   ),
// ];
