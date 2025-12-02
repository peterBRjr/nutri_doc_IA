import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:nutridoctor/uteis/appColors.dart';

class DataNascimentoField extends StatelessWidget {
  final maskData = MaskTextInputFormatter(
    mask: "##/##/####",
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  DataNascimentoField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: [maskData],
      cursorColor: AppColors.primary,
      style: const TextStyle(color: Colors.black87),
      decoration: InputDecoration(
        labelText: 'Data de Nascimento',
        labelStyle: TextStyle(color: AppColors.primary),
        prefixIcon:
            Icon(Icons.calendar_today_outlined, color: AppColors.primary),
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
        hintText: 'dd/mm/aaaa',
      ),
    );
  }
}
