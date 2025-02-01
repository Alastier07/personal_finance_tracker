import 'package:hive/hive.dart';

import 'transaction_model.dart';

class TransactionTypeAdapter extends TypeAdapter<TransactionType> {
  @override
  final typeId = 1; // Choose a unique typeId for this adapter

  @override
  TransactionType read(BinaryReader reader) {
    // Read the integer value and map it to the enum
    return TransactionType.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, TransactionType obj) {
    // Write the integer value of the enum (its index)
    writer.writeInt(obj.index);
  }
}
