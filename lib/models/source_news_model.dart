class SourceNewsModel {
  String id;
  String name;
  String description;
  String url;
  String category;
  String language;
  String country;

  SourceNewsModel({
    this.id,
    this.name,
    this.description,
    this.url,
    this.category,
    this.language,
    this.country
  });

  factory SourceNewsModel.fromJson(Map<String, dynamic> json) {
    return SourceNewsModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      url: json['url'],
      category: json['category'],
      language: json['language'],
      country: json['country']
    );
  }

  Map toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['url'] = url;
    map['category'] = category;
    map['language'] = language;
    map['country'] = country;

    return map;
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'url': url,
    'category': category,
    'language': language,
    'country': country
  };
}