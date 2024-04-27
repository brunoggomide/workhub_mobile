import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';
import '../../views/utils/env.dart';

class UserController {
  //ID DO USUARIO
  idUsuario() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  getData() {
    return FirebaseFirestore.instance
        .collection('clientes')
        .where('uid', isEqualTo: idUsuario());
  }

  void atualizar(context, String id, UsuarioModel ex) {
    FirebaseFirestore.instance
        .collection('clientes')
        .doc(id)
        .update(ex.toJson())
        .then((value) => sucesso(context, 'Atualizado com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }

  getEmpresaData(String empresaId) async {
    try {
      var empresa = await FirebaseFirestore.instance
          .collection('empresas')
          .where('uid', isEqualTo: empresaId)
          .limit(1)
          .get();

      if (empresa.docs.isNotEmpty) {
        return {
          'nome': empresa.docs.first.data()['nome'] as String?,
          'contato': empresa.docs.first.data()['contato'] as String?,
          'email': empresa.docs.first.data()['email'] as String?
        };
      } else {
        return null;
      }
    } catch (e) {
      print('Erro ao buscar dados da empresa: $e');
      return null;
    }
  }
}
