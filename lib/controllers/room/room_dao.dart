import 'package:cloud_firestore/cloud_firestore.dart';

class RoomDao {
  listar() {
    return FirebaseFirestore.instance.collection('salas');
    // .where('status', isEqualTo: true);
  }
}
