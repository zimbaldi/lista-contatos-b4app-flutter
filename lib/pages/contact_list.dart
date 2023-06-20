import 'package:flutter/material.dart';
import 'package:lista_contatos/pages/contact_detail_page.dart';
import 'package:lista_contatos/repositories/agenda_repository.dart';

import '../models/agenda_model.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  late AgendaRepository agendaRepository;

  var agendaModel = AgendaModel();

  @override
  void initState() {
    agendaRepository = AgendaRepository();
    loadContactsList();
    super.initState();
  }

  loadContactsList() async {
    agendaModel = await agendaRepository.getContacts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
        actions: [
          IconButton(
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetailPage(
                    objctId: '',
                    name: '',
                    phoneNumber: '',
                    email: '',
                    imagePath: '',
                  ),
                ),
              );
              //print(agendaModel);
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await loadContactsList();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: agendaModel.results == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: agendaModel.results?.length,
                        itemBuilder: (context, index) {
                          var contactList = agendaModel.results?[index];
                          return Card(
                            child: ListTile(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ContactDetailPage(
                                      objctId: contactList.objectId,
                                      name: contactList.name,
                                      phoneNumber: contactList.phoneNumber,
                                      email: contactList.email,
                                      imagePath: contactList.imagePath,
                                    ),
                                  ),
                                );
                              },
                              //leading: Image.asset(contactList!.imagePath),
                              leading: CircleAvatar(
                                child: Text(
                                  contactList!.name[0],
                                ),
                              ),
                              title: Text(contactList.name),
                              //title: Text(contactList!.imagePath),
                              isThreeLine: true,
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(contactList.phoneNumber),
                                  Text(contactList.email)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //var agendaModel = Agenda(name: '', );
  // Future<void> createData() async {
  //   await agendaRepository
  //       .addContact(Agenda.fromJson());
  // }
}
