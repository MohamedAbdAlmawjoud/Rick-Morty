class CharactersModel {
  
    CharactersModel.fromJson(Map<String, dynamic> json){
        id = json['id'];
        name = json['name'];
        status = json['status'];
        species = json['species'];
        type = json['type'];
        gender = json['gender'];
        origin = Location.fromJson(json['origin']);
        location = Location.fromJson(json['location']);
        image = json['image'];
        episode = List.castFrom<dynamic, String>(json['episode']);
        url = json['url'];
        created = DateTime.parse(json['created']);
    }

    late int id;
    late String name;
    late String status;
    late String species;
    late String type;
    late String gender;
    late Location origin;
    late Location location;
    late String image;
    late List<String> episode;
    late String url;
    late DateTime created;
}

class Location {
    Location({
        required this.name,
        required this.url,
    });

    Location.fromJson(Map<String, dynamic> json){
        name = json['name'];
        url = json['url'];
    }

    late String name;
    late String url;
}
