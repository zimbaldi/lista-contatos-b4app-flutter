// AgendaModel agendaModelFromJson(String str) =>
//     AgendaModel.fromJson(json.decode(str));

// String agendaModelToJson(AgendaModel data) => json.encode(data.toJson());

class AgendaModel {
  List<Agenda>? results;

  AgendaModel({
    this.results,
  });

  factory AgendaModel.fromJson(Map<String, dynamic> json) => AgendaModel(
        results:
            List<Agenda>.from(json['results'].map((x) => Agenda.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'results': List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Agenda {
  String objectId = '';
  DateTime? createdAt;
  DateTime? updatedAt;
  String name = '';
  String phoneNumber = '';
  String email = '';
  String imagePath = '';

  Agenda({
    required this.objectId,
    this.createdAt,
    this.updatedAt,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.imagePath,
  });

  Agenda.create({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.imagePath,
  });

  factory Agenda.fromJson(Map<String, dynamic> json) => Agenda(
        objectId: json['objectId'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        email: json['email'],
        imagePath: json['imageUrl'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'imageUrl': imagePath,
      };
}







/*
class AgendaModel {
  List<Agenda>? results;

  AgendaModel({
    this.results,
  });

  AgendaModel.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Agenda>[];
      json['results'].forEach((v) {
        results!.add(Agenda.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Agenda {
  String? objectId;
  String? createdAt;
  String? updatedAt;
  String name;
  String? phoneNumber;
  String? email;
  String? imageUrl;

  Agenda({
    this.objectId,
    this.createdAt,
    this.updatedAt,
    required this.name,
    this.phoneNumber,
    this.email,
    this.imageUrl,
  });

  Agenda.fromJson(Map<String, dynamic> json) {
    objectId = json['objectId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    imageUrl = json['imageUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    //data['objectId'] = objectId;
    //data['createdAt'] = createdAt;
    //data['updatedAt'] = updatedAt;
    data['name'] = name;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
*/