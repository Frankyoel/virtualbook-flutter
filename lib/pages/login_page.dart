// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_final_flutter/services/auth_services.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acceso'),
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
      body: const ContenidoLG(),
    );
  }
}

class ContenidoLG extends StatelessWidget {
  const ContenidoLG({super.key});

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
     /*Future<void> _signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    final email = _emailController.text;
    final password = _passwordController.text;
    final username = _usernameController.text;
    try {
      await supabase.auth.signUp(
          email: email, password: password, data: {'username': username});
      Navigator.of(context)
          .pushAndRemoveUntil(ChatPage.route(), (route) => false);
    } on AuthException catch (error) {
      context.showErrorSnackBar(message: error.message);
    } catch (error) {
      context.showErrorSnackBar(message: unexpectedErrorMessage);
    }
  }*/

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
                   if (_formKey.currentState!.validate()){
                    await authService.siginWithEmailAndPassword(_emailController.text, _passwordController.text);
                    {Navigator.pop(context);}
                   }
                },
                child: const Text('Ingresar')),
            const SizedBox(height: 10),
            const Center(
              child: Text('¿Aun no tienes una cuenta?'),
            ),
                Center(
                  child: TextButton(
                    onPressed: () {
                    //  Navigator.pushNamed(context, '/registro_page');
                    },
                    child: const Text('Registrate aqui'),
                  ),
                ),
             
          ])),
    );
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