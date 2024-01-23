import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:cpf_cnpj_validator/cpf_validator.dart';

import '../../../controllers/auth/auth_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isObscure = true;
  var txtNome = TextEditingController();
  var txtContato = TextEditingController();
  var txtCpf = TextEditingController();
  var txtEmail = TextEditingController();
  var txtSenha = TextEditingController();
  var txtConfirmSenha = TextEditingController();
  final cpfFormat = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );
  final celFormat = MaskTextInputFormatter(
    mask: '(##)#####-####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

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
                  'Faça seu cadastro para ter acesso ao sistema do Work-Hub!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withAlpha(100),
                  ),
                ),
                const SizedBox(height: 58),
                TextFormField(
                  controller: txtNome,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    labelText: 'Nome',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 24, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: txtCpf,
                  inputFormatters: [cpfFormat],
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.badge),
                    labelText: 'CPF',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 24, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: txtContato,
                  inputFormatters: [celFormat],
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    labelText: 'Contato',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 24, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
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
                const SizedBox(height: 16),
                TextFormField(
                  obscureText: isObscure,
                  controller: txtConfirmSenha,
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
                    labelText: 'Confirme sua senha',
                    isDense: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 24, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
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
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 20),
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
                String nome = txtNome.text;
                String cpf = txtCpf.text;
                String contato = txtContato.text;
                String email = txtEmail.text;
                String senha = txtSenha.text;
                String confirmSenha = txtConfirmSenha.text;

                if (nome.isNotEmpty &&
                    cpf.isNotEmpty &&
                    contato.isNotEmpty &&
                    email.isNotEmpty &&
                    senha.isNotEmpty &&
                    confirmSenha.isNotEmpty) {
                  if (CPFValidator.isValid(cpf)) {
                    if (senha == confirmSenha) {
                      AuthController().criarConta(
                        context,
                        nome,
                        cpf,
                        contato,
                        email,
                        senha,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red[300],
                          content: const Text('Confirme sua senha'),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red[300],
                        content: const Text('CPF inválido'),
                      ),
                    );
                  }
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
                'CADASTRAR',
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
