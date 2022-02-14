import 'package:dufuna/models/image_model.dart';

///Model class for Property
class PropertyModel {
  final String? id;
  final String address;
  final String type;
  final int bedroom;
  final int sittingRoom;
  final int bathroom;
  final int kitchen;
  final int toilet;
  final String propertyOwner;
  final String description;
  final String validFrom;
  final String validTo;
  final List<ImageModel> images;

//<editor-fold desc="Data Methods">

  const PropertyModel({
    this.id,
    required this.address,
    required this.type,
    required this.bedroom,
    required this.sittingRoom,
    required this.bathroom,
    required this.kitchen,
    required this.toilet,
    required this.propertyOwner,
    required this.description,
    required this.validFrom,
    required this.validTo,
    required this.images,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PropertyModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          address == other.address &&
          type == other.type &&
          bedroom == other.bedroom &&
          sittingRoom == other.sittingRoom &&
          bathroom == other.bathroom &&
          kitchen == other.kitchen &&
          toilet == other.toilet &&
          propertyOwner == other.propertyOwner &&
          description == other.description &&
          validFrom == other.validFrom &&
          validTo == other.validTo &&
          images == other.images);

  @override
  int get hashCode =>
      id.hashCode ^
      address.hashCode ^
      type.hashCode ^
      bedroom.hashCode ^
      sittingRoom.hashCode ^
      bathroom.hashCode ^
      kitchen.hashCode ^
      toilet.hashCode ^
      propertyOwner.hashCode ^
      description.hashCode ^
      validFrom.hashCode ^
      validTo.hashCode ^
      images.hashCode;

  @override
  String toString() {
    return 'PropertyModel{'
        ' id: $id,'
        ' address: $address,'
        ' type: $type,'
        ' bedroom: $bedroom,'
        ' sittingRoom: $sittingRoom,'
        ' bathroom: $bathroom,'
        ' kitchen: $kitchen,'
        ' toilet: $toilet,'
        ' propertyOwner: $propertyOwner,'
        ' description: $description,'
        ' validFrom: $validFrom,'
        ' validTo: $validTo,'
        ' images: $images,'
        '}';
  }

  PropertyModel copyWith({
    String? id,
    String? address,
    String? type,
    int? bedroom,
    int? sittingRoom,
    int? bathroom,
    int? kitchen,
    int? toilet,
    String? propertyOwner,
    String? description,
    String? validFrom,
    String? validTo,
    List<ImageModel>? images,
  }) {
    return PropertyModel(
      id: id ?? this.id,
      address: address ?? this.address,
      type: type ?? this.type,
      bedroom: bedroom ?? this.bedroom,
      sittingRoom: sittingRoom ?? this.sittingRoom,
      bathroom: bathroom ?? this.bathroom,
      kitchen: kitchen ?? this.kitchen,
      toilet: toilet ?? this.toilet,
      propertyOwner: propertyOwner ?? this.propertyOwner,
      description: description ?? this.description,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      images: images ?? this.images,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'address': address,
      'type': type,
      'bedroom': bedroom,
      'sittingRoom': sittingRoom,
      'bathroom': bathroom,
      'kitchen': kitchen,
      'toilet': toilet,
      'propertyOwner': propertyOwner,
      'description': description,
      'validFrom': validFrom,
      'validTo': validTo,
      'images': images.map((e) => e.toMap()).toList(),
    };
  }

  factory PropertyModel.fromMap(Map<String, dynamic> map) {
    return PropertyModel(
      id: map['_id'],
      address: map['address'],
      type: map['type'],
      bedroom: map['bedroom'],
      sittingRoom: map['sittingRoom'],
      bathroom: map['bathroom'],
      kitchen: map['kitchen'],
      toilet: map['toilet'],
      propertyOwner: map['propertyOwner'],
      description: map['description'],
      validFrom: map['validFrom'],
      validTo: map['validTo'],
      images: List<ImageModel>.from(
          map['images'].map((e) => ImageModel.fromMap(e))),
    );
  }

//</editor-fold>
}
