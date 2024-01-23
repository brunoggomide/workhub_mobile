import 'package:flutter/material.dart';

import '../../../../controllers/auth/auth_controller.dart';

class ForgotPassword extends StatelessWidget {
  final emailController = TextEditingController();

  ForgotPassword({
    required String email,
    Key? key,
  }) : super(key: key) {
    emailController.text = email;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Conteúdo
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Titulo
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'Recuperação de senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                // Descrição
                const Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 20,
                  ),
                  child: Text(
                    'Digite seu email para recuperar sua senha',
                    textAlign: TextAlign.center,
                    style: TextStyle(),
                  ),
                ),

                // Campo de email
                TextFormField(
                  autofocus: true,
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: 'E-mail',
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                ),
                const SizedBox(height: 15),

                // Confirmar
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(177, 47, 47, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  onPressed: () {
                    String email = emailController.text;

                    if (email.isNotEmpty) {
                      AuthController().esqueceuSenha(context, email);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red[300],
                          content: const Text(
                              'Preencha todos os campos obrigatórios.'),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Recuperar',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Botão para fechar
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              color: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close),
            ),
          ),
        ],
      ),
    );
  }
}
