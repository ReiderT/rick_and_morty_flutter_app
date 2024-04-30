import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_api/view/theme/app_theme.dart';
import 'package:rick_and_morty_api/view/theme/text_field_style1.dart';
import 'package:rick_and_morty_api/view/theme/text_styles.dart';
import 'package:rick_and_morty_api/view/widgets/custom_button1.dart';
import 'package:rick_and_morty_api/view/widgets/custom_text_field.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:rick_and_morty_api/viewmodel/auth_view_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // text editing controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return KeyboardDismisser(
      gestures: const [GestureType.onTap],
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0.0,
              child: SizedBox(
                height: (58.0 * screenHeight) / 100.0,
                width: screenWidth,
                  child: Image.asset(
                    'assets/images/login/image_1.png',
                    fit: BoxFit.cover, 
                  ),
                ),
            ),
            
            Positioned(
              top: (43.72 * screenHeight) / 100.0,
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0, bottom: 20.0),
                  height: screenHeight - (43.72 * screenHeight) / 100.0, 
                  decoration: BoxDecoration(
                    color: AppDarkTheme.black900,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0))
                  ),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "Hoola",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                            ),
                          ),
                          SizedBox(width: 10.0,),
                          Icon(Icons.handshake_rounded, color: Colors.amber,),
                        ],
                      ),
                      const SizedBox(height: 10.0,),
                      CustomTextField(
                        title: 'Correo',
                        controller: _emailController,
                        decoration: TextFieldStyle1.textFieldDecoration(
                          hintText: 'ejemplo@correo.com',
                        ),
                      ),
                      const SizedBox(height: 35.0,),
                      CustomTextField(
                        title: 'Contraseña',
                        controller: _passwordController,
                        decoration: TextFieldStyle1.textFieldDecoration(
                          hintText: '*********',
                        ),
                      ),
                      const SizedBox(height: 40.0,),
                      CustomButton1(
                        text: 'Ingresar',
                        style: TextStyles.body1(
                          color: AppDarkTheme.buttonActiveLabel,
                        ),
                        onPressed: () async {
                          try {
                            final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
                            await authViewModel.signInWithEmailAndPassword(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                            );
                          } catch (e) {
                            // Manejar errores de inicio de sesión
                            Fluttertoast.showToast(msg: 'Error al iniciar sesión: $e');
                            //log('Error al iniciar sesión: $e');
                          }
                          
                          if (!context.mounted) return;
                          final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
                          if (authViewModel.getCurrentUser() != null) {
                            if (!authViewModel.getCurrentUser()!.emailVerified) {
                              return;
                            }
                          }  
                        },
                      ),
                    ]
                  ),
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}