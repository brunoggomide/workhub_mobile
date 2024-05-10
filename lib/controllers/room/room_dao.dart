import 'package:cloud_firestore/cloud_firestore.dart';

class RoomDao {
  listar() {
    return FirebaseFirestore.instance.collection('salas');
  }

  listarUma(id) {
    return FirebaseFirestore.instance
        .collection('salas')
        .where('id', isEqualTo: id);
  }
}
