import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../controllers/user/user_controller.dart';
import '../../../../models/user_model.dart';

class EditContato extends StatefulWidget {
  EditContato({
    Key? key,
    required this.title,
    required this.value,
    required this.item,
    required this.id,
  }) : super(key: key);

  final dynamic item;
  final String id;
  final String title;
  final String value;

  @override
  State<EditContato> createState() => _EditContatoState();
}

class _EditContatoState extends State<EditContato> {
  late TextEditingController txtController;

  final celFormat = MaskTextInputFormatter(
    mask: '(##)#####-####',
    filter: {
      '#': RegExp(r'[0-9]'),
    },
  );

  @override
  void initState() {
    super.initState();
    txtController = TextEditingController(text: widget.value);
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    widget.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),

                // Campo de email
                TextFormField(
                  autofocus: true,
                  inputFormatters: [celFormat],
                  controller: txtController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.email),
                    labelText: widget.title,
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
                    String novoContato = txtController.text;

                    if (novoContato.isNotEmpty && novoContato.length >= 9) {
                      var e = UsuarioModel(
                        UserController().idUsuario(),
                        widget.item['nome'],
                        novoContato,
                        '',
                      );

                      UserController().atualizar(context, widget.id, e);
                      Navigator.of(context)
                          .pop({'success': true, 'novoContato': novoContato});
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
                    'Editar',
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
