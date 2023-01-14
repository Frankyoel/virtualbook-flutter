// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_final_flutter/services/auth_services.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        /* actions: [
          IconButton(
              icon: Icon(Icons.browse_gallery),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const SubirImagen(title: 'Cargar imagen')));
              })
        ],*/
      ),
      body: const ContenidoRG(),
    );
  }
}

class ContenidoRG extends StatelessWidget {
  const ContenidoRG({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Header(),
        FormRegistro(),
      ],
    );
  }
}

class FormRegistro extends StatefulWidget {
  const FormRegistro({
    Key? key,
  }) : super(key: key);

  @override
  State<FormRegistro> createState() => _FormRegistroState();
}

class _FormRegistroState extends State<FormRegistro> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _usernameController = TextEditingController();
    final authService = Provider.of<AuthService>(context);
    final isValid = _formKey.currentState!.validate();

    return Container(
      padding: EdgeInsets.all(20),
      child: Form(
          key: _formKey,
          child: Column(children: [
            SizedBox(height: 15),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Nombre de usuario'),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Requerido';
                }
                final isValid = RegExp(r'^[A-Za-z0-9_]{3,24}$').hasMatch(val);
                if (!isValid) {
                  return 'Debe tener una longitud de 3-24 datos ';
                }
                return null;
              },
            ),
            SizedBox(height: 15),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Email'),
              ),
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'Requerido';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text('Contraseña'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Requerido';
                }
                if (value.length < 6) {
                  return '6 datos como minimo';
                }
                return null;
              },
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await authService.createUserWithEmailAndPassword(
                        _emailController.text, _passwordController.text);
                    {
                      mensajeAlerta(context);
                    }{
                      Navigator.pop(context);
                    }
                  }
                },
                child: const Text('Registar')),
            const SizedBox(height: 10),
            const Center(
              child: Text('¿Tienes una cuenta?'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text('      Conectate por'),
                TextButton(
                  onPressed: () {
                  //  Navigator.pushNamed(context, '/login_page');
                  },
                  child: const Text('Aqui'),
                ),
              ],
            )
          ])),
    );
  }

  Future<dynamic> mensajeAlerta(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text('Confirmacion;)'),
              content: const Text('Felicidades, su cuenta esta registrada'),
              actions: [
                ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text('Ok'))
              ],
            ));
  }
}

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(top: 35),
          width: double.infinity,
          height: 200,
          color: Color.fromARGB(188, 106, 159, 234),
          child: Column(children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80),
                border: Border.all(
                    width: 5, color: Color.fromARGB(255, 3, 15, 149)),
                //  image: DecorationImage(
                //    image: AssetImage('assets/github.png'), fit: BoxFit.cover),
              ),
            ),
            Container(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'MY VIRTUAL BOOK',
                )),
          ]),
        )
      ],
    );
  }
}
