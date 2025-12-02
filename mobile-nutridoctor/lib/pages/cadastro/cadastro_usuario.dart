import 'package:flutter/material.dart';
import 'package:nutridoctor/uteis/appColors.dart';
import 'package:nutridoctor/uteis/cpfFIeld.dart';
import 'package:nutridoctor/uteis/datanascimentoField.dart';

class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CadastroUsuarioState();
  }
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmSenhaController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _senhaController.dispose();
    _confirmSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Criar Conta",
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
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            Icon(
              Icons.person_add_alt_1,
              size: 80,
              color: AppColors.primary,
            ),
            const SizedBox(height: 10),
            Text(
              "Junte-se ao NutriDoctor",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField(
              label: "Nome Completo",
              icon: Icons.person_outline,
              controller: _nomeController,
            ),
            const SizedBox(height: 16),
            CpfField(),
            const SizedBox(height: 16),
            DataNascimentoField(),
            const SizedBox(height: 16),
            _buildTextField(
              label: "Senha",
              icon: _isPasswordVisible
                  ? Icons.lock_open_outlined
                  : Icons.lock_outline,
              isPassword: true,
              obscureText: !_isPasswordVisible,
              controller: _senhaController,
              onIconPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: "Confirmar Senha",
              icon: _isConfirmPasswordVisible
                  ? Icons.lock_open_outlined
                  : Icons.lock_reset,
              isPassword: true,
              obscureText: !_isConfirmPasswordVisible,
              controller: _confirmSenhaController,
              onIconPressed: () {
                setState(() {
                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                });
              },
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "CADASTRAR",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    VoidCallback? onIconPressed,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? obscureText : false,
      keyboardType: keyboardType,
      cursorColor: AppColors.primary,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: AppColors.primary),
        prefixIcon: onIconPressed != null
            ? IconButton(
                icon: Icon(icon, color: AppColors.primary),
                onPressed: onIconPressed,
              )
            : Icon(icon, color: AppColors.primary),
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
