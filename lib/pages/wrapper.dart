
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_final_flutter/pages/home_page.dart';
import 'package:trabajo_final_flutter/pages/login_page.dart';
import 'package:trabajo_final_flutter/services/auth_services.dart';
import '../models/user_model.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
        stream: authService.user,
        builder: (_, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;
            return user == null ? LoginPage() : HomePage();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
