import 'package:flutter/material.dart';
import 'package:nutridoctor/pages/cadastro/cadastro_usuario.dart';
import 'package:nutridoctor/uteis/appColors.dart';

class LoginUsuario extends StatefulWidget {
  const LoginUsuario({Key? key}) : super(key: key);

  @override
  State<LoginUsuario> createState() => _LoginUsuarioState();
}

class _LoginUsuarioState extends State<LoginUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Acesso",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.primary,
        centerTitle: true,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Icon(
              Icons.account_circle,
              size: 100,
              color: AppColors.primary,
            ),
            const SizedBox(height: 10),
            Text(
              "NutriDoctor",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 40),
            _buildTextField(
              label: "Data de Nascimento",
              icon: Icons.calendar_today,
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 20),
            _buildTextField(
              label: "Senha",
              icon: Icons.lock,
              isPassword: true,
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Esqueceu a senha?",
                  style: TextStyle(
                      color: AppColors.primary, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // Ação de Login
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "ENTRAR",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Não tem uma conta?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CadastroUsuario()));
                  },
                  child: Text(
                    "Cadastre-se aqui",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      obscureText: isPassword,
      keyboardType: keyboardType,
      cursorColor: AppColors.primary,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.primary),
        prefixIcon: Icon(icon, color: AppColors.primary),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.primary.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        filled: true,
        fillColor: AppColors.backgroundLight,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      ),
    );
  }
}
