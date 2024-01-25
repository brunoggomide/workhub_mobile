import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../models/user_model.dart';
import '../../views/utils/env.dart';

class UserController {
  //ID DO USUARIO
  idUsuario() {
    return FirebaseAuth.instance.currentUser!.uid;
  }

  getData() {
    return FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: idUsuario());
  }

  void atualizar(context, String id, UsuarioModel ex) {
    FirebaseFirestore.instance
        .collection('usuarios')
        .doc(id)
        .update(ex.toJson())
        .then((value) => sucesso(context, 'Atualizado com sucesso'))
        .catchError((e) => erro(context, 'ERRO: ${e.code.toString()}'));
  }
}
