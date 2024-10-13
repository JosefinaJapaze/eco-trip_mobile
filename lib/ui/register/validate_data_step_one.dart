import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ValidateDataStepOne extends StatefulWidget {
  @override
  _ValidateDataStepOneState createState() => _ValidateDataStepOneState();
}

class _ValidateDataStepOneState extends State<ValidateDataStepOne> {
  File? _dniImage;
  File? _conductCertificateImage;
  final ImagePicker _picker = ImagePicker();
  String _accountType = "Pasajero"; // Default selection

  Future<void> _pickImage(String type) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        if (type == 'DNI') {
          _dniImage = File(pickedFile.path);
        } else if (type == 'Certificado') {
          _conductCertificateImage = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 16.0),
            _buildImagePickerField(
              image: _dniImage,
              hintText: "DNI",
              onTap: () => _pickImage('DNI'),
            ),
            SizedBox(height: 16.0),
            _buildImagePickerField(
              image: _conductCertificateImage,
              hintText: "Certificado de Buena Conducta",
              onTap: () => _pickImage('Certificado'),
            ),
            SizedBox(height: 30.0),
            _buildAccountTypeSelector(),
            SizedBox(height: 30.0),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Validar datos",
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          "Datos personales",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }
  Widget _buildImagePickerField({
    File? image,
    required String hintText,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              image != null ? "Imagen seleccionada" : hintText,
              style: TextStyle(
                color: image != null ? Colors.black : Colors.grey[600],
              ),
            ),
            Icon(Icons.photo, color: Colors.black),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountTypeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Seleccione tipo de cuenta:",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            _buildRadioOption("Pasajero"),
            SizedBox(width: 20.0),
            _buildRadioOption("Conductor"),
          ],
        ),
      ],
    );
  }

  Widget _buildRadioOption(String value) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: _accountType,
          onChanged: (String? newValue) {
            setState(() {
              _accountType = newValue!;
            });
          },
        ),
        Text(value),
      ],
    );
  }

  Widget _buildNextButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lime,
        padding: EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onPressed: () {
        // Add your logic here for "Siguiente"
      },
      child: Center(
        child: Text(
          "SIGUIENTE",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
