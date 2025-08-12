// Ajuste: DTOs (API Models) para camada Data no padrão MVVM com fromJson/toJson.

class CharacterApiModel {
  final InfoCharacter info;
  final List<ResultsCharacter> results;

  CharacterApiModel({required this.info, required this.results});

  factory CharacterApiModel.fromJson(Map<String, dynamic> json) =>
      CharacterApiModel(
        info: InfoCharacter.fromJson(json['info'] as Map<String, dynamic>),
        results: (json['results'] as List<dynamic>)
            .map((e) => ResultsCharacter.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'info': info.toJson(),
        'results': results.map((e) => e.toJson()).toList(),
      };
}

class InfoCharacter {
  final int count;
  final int pages;
  final String? next;
  final String? prev;

  InfoCharacter(
      {required this.count, required this.pages, this.next, this.prev});

  factory InfoCharacter.fromJson(Map<String, dynamic> json) => InfoCharacter(
        count: json['count'] as int,
        pages: json['pages'] as int,
        next: json['next'] as String?,
        prev: json['prev'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'pages': pages,
        'next': next,
        'prev': prev,
      };
}

class CharacterPlace {
  final String name;
  final String url;

  CharacterPlace({required this.name, required this.url});

  factory CharacterPlace.fromJson(Map<String, dynamic> json) => CharacterPlace(
        name: json['name'] as String,
        url: json['url'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'url': url,
      };
}

class ResultsCharacter {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final CharacterPlace origin;
  final CharacterPlace location;
  final String image;
  final List<String> episode;
  final String url;
  final DateTime created;

  ResultsCharacter({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.url,
    required this.created,
  });

  factory ResultsCharacter.fromJson(Map<String, dynamic> json) =>
      ResultsCharacter(
        id: json['id'] as int,
        name: json['name'] as String,
        status: json['status'] as String,
        species: json['species'] as String,
        type: (json['type'] as String?) ?? '',
        gender: json['gender'] as String,
        origin: CharacterPlace.fromJson(json['origin'] as Map<String, dynamic>),
        location:
            CharacterPlace.fromJson(json['location'] as Map<String, dynamic>),
        image: json['image'] as String,
        episode:
            (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
        url: json['url'] as String,
        created: DateTime.parse(json['created'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
        'origin': origin.toJson(),
        'location': location.toJson(),
        'image': image,
        'episode': episode,
        'url': url,
        'created': created.toIso8601String(),
      };
}
