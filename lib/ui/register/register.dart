import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  late FocusNode _passwordFocusNode;
  late FocusNode _confirmPasswordFocusNode;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
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
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildRegisterField(),
          _buildNameField(),
          _buildLastNameField(),
          _buildGenderField(),
          _buildAgeField(),
          _buildPhoneNumberField(),
          _buildEmailField(),
          _buildPasswordField(),
          _buildConfirmPasswordField(),
          _buildRegisterButton(),
        ],
      ),
    );
  }

  Widget _buildRegisterField() {
    return Text(
      'Registro',
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildNameField() {
    return _buildTextField("Nombre");
  }

  Widget _buildLastNameField() {
    return _buildTextField("Apellido");
  }

  Widget _buildGenderField() {
    return _buildTextField("Sexo");
  }

  Widget _buildAgeField() {
    return _buildTextField("Edad");
  }

  Widget _buildPhoneNumberField() {
    return _buildTextField("Numero de Celular");
  }

  Widget _buildEmailField() {
    return _buildTextField("Correo electronico");
  }

  Widget _buildPasswordField() {
    return _buildTextField("Contraseña", isObscure: true);
  }

  Widget _buildConfirmPasswordField() {
    return _buildTextField("Repetir contraseña", isObscure: true);
  }

  Widget _buildTextField(String hint, {bool isObscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: isObscure,
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
          hintText: hint,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.black),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:
                BorderSide(color: Colors.black), // Border color when enabled
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:
                BorderSide(color: Colors.blue), // Border color when focused
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lime,
        padding: EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed("/validate_data_step_one");
      },
      child: Text(
        "CONFIRMAR",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }
}
