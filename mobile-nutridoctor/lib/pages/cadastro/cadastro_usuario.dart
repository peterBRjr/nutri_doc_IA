import 'package:flutter/material.dart';

class CadastroUsuario extends StatefulWidget {
  const CadastroUsuario({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CadastroUsuarioState();
  }
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  final Color _primaryGreen = const Color(0xFF2E7D32);
  final Color _accentGreen = const Color(0xFFE8F5E9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Criar Conta",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _primaryGreen,
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
            const SizedBox(height: 20),
            Icon(
              Icons.person,
              size: 80,
              color: _primaryGreen,
            ),
            const SizedBox(height: 10),
            Text(
              "Bem-vindo(a)!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _primaryGreen,
              ),
            ),
            const SizedBox(height: 30),
            _buildTextField(
              label: "Nome Completo",
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: "Data de Nascimento",
              icon: Icons.calendar_today_outlined,
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: "Senha",
              icon: Icons.lock_outline,
              isPassword: true,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              label: "Confirmar Senha",
              icon: Icons.lock_reset,
              isPassword: true,
            ),
            const SizedBox(height: 40),
            SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryGreen,
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
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      obscureText: isPassword,
      keyboardType: keyboardType,
      cursorColor: _primaryGreen,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: _primaryGreen),
        prefixIcon: Icon(icon, color: _primaryGreen),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.green.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: _primaryGreen, width: 2),
        ),
        filled: true,
        fillColor: _accentGreen,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      ),
    );
  }
}
