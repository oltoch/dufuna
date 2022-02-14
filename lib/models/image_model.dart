///Model class for Image
class ImageModel {
  String? fieldname;
  String? originalname;
  String? mimetype;
  String? encoding;
  String? path;
  int? size;
  String? filename;

//<editor-fold desc="Data Methods">

  ImageModel({
    this.fieldname,
    this.originalname,
    this.mimetype,
    this.encoding,
    this.path,
    this.size,
    this.filename,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImageModel &&
          runtimeType == other.runtimeType &&
          fieldname == other.fieldname &&
          originalname == other.originalname &&
          mimetype == other.mimetype &&
          encoding == other.encoding &&
          path == other.path &&
          size == other.size &&
          filename == other.filename);

  @override
  int get hashCode =>
      fieldname.hashCode ^
      originalname.hashCode ^
      mimetype.hashCode ^
      encoding.hashCode ^
      path.hashCode ^
      size.hashCode ^
      filename.hashCode;

  @override
  String toString() {
    return 'ImageModel{'
        ' fieldname: $fieldname,'
        ' originalname: $originalname,'
        ' mimetype: $mimetype,'
        ' encoding: $encoding,'
        ' path: $path,'
        ' size: $size,'
        ' filename: $filename,'
        '}';
  }

  ImageModel copyWith({
    String? fieldname,
    String? originalname,
    String? mimetype,
    String? encoding,
    String? path,
    int? size,
    String? filename,
  }) {
    return ImageModel(
      fieldname: fieldname ?? this.fieldname,
      originalname: originalname ?? this.originalname,
      mimetype: mimetype ?? this.mimetype,
      encoding: encoding ?? this.encoding,
      path: path ?? this.path,
      size: size ?? this.size,
      filename: filename ?? this.filename,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'fieldname': fieldname,
      'originalname': originalname,
      'mimetype': mimetype,
      'encoding': encoding,
      'path': path,
      'size': size,
      'filename': filename,
    };
  }

  //Since there are properties that do not have list of pictures,
  //null check is employed to avoid mapping null to a non-nullable field.
  factory ImageModel.fromMap(Map<String, dynamic> map) {
    return ImageModel(
      fieldname: map['fieldname'] ?? null,
      originalname: map['originalname'] ?? null,
      mimetype: map['mimetype'] ?? null,
      encoding: map['encoding'] ?? null,
      path: map['path'] ?? null,
      size: map['size'] ?? null,
      filename: map['filename'] ?? null,
    );
  }

//</editor-fold>
}
