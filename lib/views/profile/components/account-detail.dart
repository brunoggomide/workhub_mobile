import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:workhub_mobile/views/profile/components/widgets/edit-contato.dart';
import 'package:workhub_mobile/views/profile/components/widgets/edit-name.dart';
import 'package:workhub_mobile/views/profile/components/widgets/profile-detail.dart';

class AccountDetail extends StatefulWidget {
  const AccountDetail({
    super.key,
    required this.item,
    required this.id,
  });

  final dynamic item;
  final String id;

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  late String formattedDate;

  @override
  void initState() {
    super.initState();

    Timestamp timestamp = widget.item['criado_em'];
    DateTime dateTime = timestamp.toDate();

    formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Detalhes da conta',
          style: TextStyle(
            color: Colors.black,
            fontSize: 26,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: Colors.black,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Icon(
                  Icons.account_circle,
                  size: 120,
                  color: Colors.red,
                ),
              ),
            ),
            Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Adicione a lógica que você deseja executar quando o botão for pressionado
                    },
                    child: const Text(
                      'Editar Foto',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withAlpha(90),
                      thickness: 2,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withAlpha(90),
                      thickness: 2,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Informações do perfil',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            profileDetail(
              onPressed: () async {
                // Aguarde o resultado do diálogo
                Map<String, dynamic>? result = await showDialog(
                  context: context,
                  builder: (_) {
                    return EditName(
                      id: widget.id,
                      item: widget.item,
                      value: widget.item['nome'],
                      title: 'Nome',
                    );
                  },
                );

                // Se a edição foi bem-sucedida, atualize a tela
                if (result != null && result['success'] == true) {
                  setState(() {
                    // Atualize os dados conforme necessário
                    widget.item['nome'] = result['novoNome'];
                  });
                }
              },
              title: 'Nome',
              value: widget.item['nome'],
              icon: true,
            ),
            profileDetail(
              onPressed: () {},
              title: 'E-mail',
              value: widget.item['email'],
              icon: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withAlpha(90),
                      thickness: 2,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withAlpha(90),
                      thickness: 2,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                'Informações pessoal',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            profileDetail(
              onPressed: () async {
                // Aguarde o resultado do diálogo
                Map<String, dynamic>? result = await showDialog(
                  context: context,
                  builder: (_) {
                    return EditContato(
                      id: widget.id,
                      item: widget.item,
                      value: widget.item['contato'],
                      title: 'Contato',
                    );
                  },
                );

                // Se a edição foi bem-sucedida, atualize a tela
                if (result != null && result['success'] == true) {
                  setState(() {
                    // Atualize os dados conforme necessário
                    widget.item['contato'] = result['novoContato'];
                  });
                }
              },
              title: 'Contato',
              value: widget.item['contato'],
              icon: true,
            ),
            profileDetail(
              onPressed: () {},
              title: 'CPF',
              value: widget.item['documento'],
              icon: false,
            ),
            profileDetail(
              onPressed: () {},
              title: 'Criado em',
              value: formattedDate,
              icon: false,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withAlpha(90),
                      thickness: 2,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey.withAlpha(90),
                      thickness: 2,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Adicione a lógica que você deseja executar quando o botão for pressionado
                    },
                    child: const Text(
                      'Alterar senha',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
            const SizedBox(height: 10),
            Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Adicione a lógica que você deseja executar quando o botão for pressionado
                    },
                    child: const Text(
                      'Deletar conta',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
