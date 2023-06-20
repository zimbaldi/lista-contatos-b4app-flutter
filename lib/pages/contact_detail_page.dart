// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:validatorless/validatorless.dart';
import '../models/agenda_model.dart';
import '../repositories/agenda_repository.dart';

class ContactDetailPage extends StatefulWidget {
  String objctId = '';
  String name = '';
  String phoneNumber = '';
  String email = '';
  String imagePath = '';

  ContactDetailPage({
    Key? key,
    required this.objctId,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<ContactDetailPage> createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
  late AgendaRepository agendaRepository;
  var agendaModel = AgendaModel();
  // var agenda = Agenda.create(
  //     name: name, phoneNumber: phoneNumber, email: email, imageUrl: imageUrl);
  XFile? image;

  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var emailController = TextEditingController();

  //var image;
  bool isEdit = false;

  var maskFormatter = MaskTextInputFormatter(
      mask: '(##)#####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  final formKey = GlobalKey<FormState>();

  // Future pickImage(ImageSource source) async {
  //   final image = await ImagePicker().pickImage(source: source);
  //   if (image != null) {
  //     String path =
  //         (await path_provider.getApplicationDocumentsDirectory()).path;
  //     String name = basename(image.path);
  //     await image.saveTo('$path/$name');
  //     print(image.path);
  //     await GallerySaver.saveImage(image.path);
  //     setState(() {
  //       //this.image = File(path);
  //     });
  //     //return File(path).copy(image.path);
  //   }

  // if (image == null) return;
  // final imageSaved = await saveImage(image.path);
  // setState(() {
  //   this.image = imageSaved;
  // });
//  }

  // Future<File> saveImage(String imagePath) async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   final name = basename(imagePath);
  //   final image = File('${directory.path}/$name');
  //   print(imagePath);

  //   GallerySaver.saveImage(imagePath);
  //   return File(imagePath).copy(image.path);
  // }

  @override
  void dispose() {
    nameController;
    phoneNumberController;
    emailController;
    super.dispose();
  }

  @override
  void initState() {
    agendaRepository = AgendaRepository();

    nameController.text = widget.name;
    phoneNumberController.text = widget.phoneNumber;
    emailController.text = widget.email;
    if (widget.objctId.isNotEmpty) {
      isEdit = true;

      nameController.text = widget.name;
      phoneNumberController.text = widget.phoneNumber;
      emailController.text = widget.email;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Update' : 'Create'),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints:
              BoxConstraints(maxHeight: MediaQuery.sizeOf(context).height),
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) {
                          return Wrap(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text('Tirar foto'),
                                onTap: () async {
                                  //pickImage(ImageSource.camera);
                                  final ImagePicker picker = ImagePicker();
                                  image = await picker.pickImage(
                                      source: ImageSource.camera);

                                  if (image != null) {
                                    String path = (await path_provider
                                            .getApplicationDocumentsDirectory())
                                        .path;
                                    String name = basename(image!.path);
                                    await image!.saveTo('$path/$name');
                                    //print(image!.path);
                                    await GallerySaver.saveImage(image!.path);
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                    setState(() {});
                                  }
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo),
                                title: const Text('Escolher da galeria'),
                                onTap: () async {
                                  //pickImage(ImageSource.gallery);
                                  final ImagePicker picker = ImagePicker();
                                  image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  if (context.mounted) {
                                    Navigator.pop(context);
                                  }
                                  setState(() {});
                                },
                              ),
                              ListTile(
                                leading:
                                    const Icon(Icons.delete_forever_rounded),
                                title: const Text('Apagar foto'),
                                onTap: () async {
                                  image = null;
                                  setState(() {});
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: SizedBox(
                      //color: Colors.grey,
                      width: 140,
                      height: 140,
                      child: Stack(
                        children: [
                          ClipOval(
                            child: image == null
                                ? Image.asset('images/avatar.jpg')
                                : Image.file(
                                    File(image!.path),
                                    //image!,
                                    width: 140,
                                    height: 140,
                                  ),
                          ),
                          const Positioned(
                            right: 5,
                            bottom: 5,
                            child: CircleAvatar(
                              backgroundColor: Colors.blueGrey,
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // image == null
                    //     ? SizedBox(
                    //         width: 140,
                    //         child: ClipOval(
                    //           child: Image.asset(
                    //             'images/avatar.jpg',
                    //           ),
                    //         ),
                    //       )
                    //     : ProfileImage(
                    //         imagePath: image!.path.toString(),
                    //         onPressed: () {},
                    //       ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: Validatorless.min(
                        3, 'The name should have more than 3 letters'),
                    controller: nameController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Name'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: Validatorless.number('Please type only numbers'),
                    controller: phoneNumberController,
                    inputFormatters: [maskFormatter],
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Phone number'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator:
                        Validatorless.email('Please type a valid e-mail'),
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), hintText: 'E-mail'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Preencha os dados corretamente'),
                            ),
                          );
                        } else {
                          isEdit ? updateData() : createData();
                          Navigator.pop(context, 'refresh');
                        }
                      },
                      child: Text(
                        isEdit ? 'Update' : 'Add',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateData() async {
    await agendaRepository.updateContact(
      widget.objctId,
      Agenda.create(
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
        email: emailController.text,
        imagePath: image!.path,
      ),
    );
  }

  Future<void> createData() async {
    await agendaRepository.addContact(
      Agenda.create(
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
        email: emailController.text,
        imagePath: image!.path,
      ),
    );
  }
}
 // String path = (await path_provider
//         .getApplicationDocumentsDirectory())
//     .path;
// String name = basename(photo.path);
// await photo.saveTo('$path/$name');

//name: nameController.text,
//phoneNumber: phoneNumberController.text,
//email: emailController.text,
