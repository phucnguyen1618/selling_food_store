// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'type_product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TypeProductAdapter extends TypeAdapter<TypeProduct> {
  @override
  final int typeId = 3;

  @override
  TypeProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TypeProduct(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TypeProduct obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.idType)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TypeProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
