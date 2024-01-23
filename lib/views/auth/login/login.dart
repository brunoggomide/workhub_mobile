import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../../controllers/auth/auth_controller.dart';
import 'components/forgot_password.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isObscure = true;
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Row(
            children: [
              SizedBox(
                width: 100,
                child: TextLiquidFill(
                  text: 'Work-Hub',
                  waveColor: Color.fromRGBO(177, 47, 47, 1),
                  boxBackgroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  boxHeight: 50.0,
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),
                const Text(
                  'Bem-vindo(a),',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Faça login para ter acesso ao sistema do Work-Hub!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withAlpha(100),
                  ),
                ),
                const SizedBox(height: 72),
                TextFormField(
                  controller: txtEmail,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.mail),
                    labelText: 'E-mail',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 24, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 56),
                TextFormField(
                  obscureText: isObscure,
                  controller: txtSenha,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: Icon(
                          isObscure ? Icons.visibility : Icons.visibility_off),
                    ),
                    labelText: 'Senha',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 24, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return ForgotPassword(email: txtEmail.text);
                          });
                    },
                    child: const Text(
                      'Esqueci minha senha',
                      style: TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(
                    height: 100), // Adiciona espaço entre o texto e o botão
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 20, left: 16, right: 16),
          child: SizedBox(
            height: 56,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(177, 47, 47, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                String email = txtEmail.text;
                String senha = txtSenha.text;

                if (email.isNotEmpty && senha.isNotEmpty) {
                  AuthController().login(context, email, senha);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red[300],
                      content:
                          const Text('Preencha todos os campos obrigatórios.'),
                    ),
                  );
                }
              },
              child: const Text(
                'ENTRAR',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
