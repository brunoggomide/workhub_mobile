import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:workhub_mobile/views/auth/login/login.dart';

import '../../views/base/base.dart';
import '../../views/utils/env.dart';

class AuthController {
  criarConta(context, nome, documento, contato, email, senha) {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((res) {
      // Enviar confirmação do e-mail
      res.user!.sendEmailVerification();

      FirebaseFirestore.instance.collection('clientes').add({
        'uid': res.user!.uid,
        'nome': nome,
        'documento': documento,
        'contato': contato,
        'email': email,
        'criado_em': FieldValue.serverTimestamp(),
        'atualizado_em': ''
      });

      sucesso(context, 'Verifique seu e-mail para ativar seu cadastro');
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: ((c) {
            return const Login();
          }),
        ),
      );
    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'O usuário já foi cadastrado.');
          break;
        case 'invalid-email':
          erro(context, 'O formato do e-mail é inválido.');
          break;
        default:
          erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  login(context, email, senha) {
    // Check if the email exists in Firestore collection 'clientes'
    FirebaseFirestore.instance
        .collection('clientes')
        .where('email', isEqualTo: email)
        .get()
        .then((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        // Email exists, proceed with sign-in
        FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: senha)
            .then((res) {
          if (res.user!.emailVerified) {
            sucesso(context, 'Usuário autenticado com sucesso!');
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: ((c) {
                  return const BaseScreen();
                }),
              ),
            );
          } else {
            erro(context, 'O endereço de e-mail não foi confirmado.');
          }
        }).catchError((e) {
          switch (e.code) {
            case 'user-not-found':
              erro(context, 'Usuário não encontrado.');
              break;
            case 'wrong-password':
              erro(context, 'Senha incorreta.');
              break;
            default:
              erro(context, 'ERRO: ${e.code.toString()}');
          }
        });
      } else {
        // Email does not exist in Firestore collection 'clientes'
        erro(context, 'E-mail não cadastrado.');
      }
    }).catchError((error) {
      // Handle Firestore query error
      erro(context, 'Erro ao verificar o e-mail.');
    });
  }

  esqueceuSenha(context, String email) {
    if (email.isNotEmpty) {
      FirebaseAuth.instance
          .sendPasswordResetEmail(
        email: email,
      )
          .then((res) {
        Navigator.pop(context);
        sucesso(context, 'E-mail enviado com sucesso.');
      }).catchError((e) {
        switch (e.code) {
          case 'invalid-email':
            erro(context, 'O formato do email é inválido.');
            break;
          case 'user-not-found':
            erro(context, 'Usuário não encontrado.');
            break;
          default:
            erro(context, e.code.toString());
        }
      });
    }
  }

  logout(context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (c) {
          return const Login();
        },
      ),
    );
  }
}
