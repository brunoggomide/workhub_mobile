import 'package:cloud_firestore/cloud_firestore.dart';

class DeskDao {
  listar() {
    return FirebaseFirestore.instance
        .collection('mesas')
        .where('status', isEqualTo: true);
  }

  listarUma(id) {
    return FirebaseFirestore.instance
        .collection('mesas')
        .where('id', isEqualTo: id);
  }
}
