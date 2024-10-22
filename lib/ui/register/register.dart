import 'package:another_flushbar/flushbar_helper.dart';
import 'package:boilerplate/data/network/apis/user/register_api.dart';
import 'package:boilerplate/di/components/service_locator.dart';
import 'package:boilerplate/ui/register/store/register_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/utils/routes/routes.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _userEmailController = TextEditingController();
  String _userEmailError = "";
  TextEditingController _passwordController = TextEditingController();
  String _passwordError = "";
  TextEditingController _confirmPasswordController = TextEditingController();
  String _confirmPasswordError = "";
  TextEditingController _nameController = TextEditingController();
  String _nameError = "";
  TextEditingController _lastNameController = TextEditingController();
  String _lastNameError = "";
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  String _ageError = "";
  TextEditingController _phoneNumberController = TextEditingController();
  String _phoneNumberError = "";

  late RegisterStore _store;

  @override
  void initState() {
    super.initState();
    _genderController.text = "Masculino";
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = getIt<RegisterStore>();
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
    return SingleChildScrollView(
      child: Stack(children: [
        Padding(
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
        ),
        Observer(
          builder: (context) {
            return _store.success
                ? navigate(context)
                : _showErrorMessage(_store.errorStore.errorMessage);
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _store.isLoading,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ]),
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
    return _buildTextField("Nombre", _nameController, _nameError);
  }

  Widget _buildLastNameField() {
    return _buildTextField("Apellido", _lastNameController, _lastNameError);
  }

  Widget _buildGenderField() {
    // radio button group of genero
    return Row(
      children: [
        Text("Genero: "),
        Radio(
          value: "Masculino",
          groupValue: _genderController.text,
          onChanged: (value) {
            setState(() {
              _genderController.text = value.toString();
            });
          },
        ),
        Text("Masculino"),
        Radio(
          value: "Femenino",
          groupValue: _genderController.text,
          onChanged: (value) {
            setState(() {
              _genderController.text = value.toString();
            });
          },
        ),
        Text("Femenino"),
      ],
    );
  }

  Widget _buildAgeField() {
    return _buildTextField("Edad", _ageController, _ageError);
  }

  Widget _buildPhoneNumberField() {
    return _buildTextField(
        "Numero de Celular", _phoneNumberController, _phoneNumberError);
  }

  Widget _buildEmailField() {
    return _buildTextField(
        "Correo electronico", _userEmailController, _userEmailError);
  }

  Widget _buildPasswordField() {
    return _buildTextField("Contraseña", _passwordController, _passwordError,
        isObscure: true);
  }

  Widget _buildConfirmPasswordField() {
    return _buildTextField(
        "Repetir contraseña", _confirmPasswordController, _confirmPasswordError,
        isObscure: true);
  }

  Widget _buildTextField(
      String hint, TextEditingController? controller, String error,
      {bool isObscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        decoration: InputDecoration(
          errorText: error.isEmpty ? null : error,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide: BorderSide(color: Colors.red),
          ),
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
        if (!_validateFields()) return;
        _store.register(RegisterParams(
          email: _userEmailController.text,
          password: _passwordController.text,
          firstName: _nameController.text,
          lastName: _lastNameController.text,
          gender: genderFromString(_genderController.text) ?? Gender.male,
          birthDate: DateTime.now(), // TODO: parse age to date
          phone: int.parse(_phoneNumberController.text),
        ));
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

  _showErrorMessage(String message) {
    if (message.isNotEmpty) {
      Future.delayed(Duration(milliseconds: 0), () {
        if (message.isNotEmpty) {
          FlushbarHelper.createError(
            message: message,
            title: AppLocalizations.of(context).translate('home_tv_error'),
            duration: Duration(seconds: 3),
          ).show(context);
        }
      });
    }
    return SizedBox.shrink();
  }

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).popAndPushNamed(Routes.validate_data_step_one);
    });
    return Container();
  }

  bool _validateFields() {
    bool valid = true;
    if (_nameController.text.isEmpty) {
      setState(() {
        _nameError = "Campo requerido";
      });
      valid = false;
    } else {
      setState(() {
        _nameError = "";
      });
    }

    if (_lastNameController.text.isEmpty) {
      setState(() {
        _lastNameError = "Campo requerido";
      });
      valid = false;
    } else {
      setState(() {
        _lastNameError = "";
      });
    }

    if (_ageController.text.isEmpty) {
      setState(() {
        _ageError = "Campo requerido";
      });
      valid = false;
    } else {
      setState(() {
        _ageError = "";
      });
    }

    if (_phoneNumberController.text.isEmpty) {
      setState(() {
        _phoneNumberError = "Campo requerido";
      });
      valid = false;
    } else {
      setState(() {
        _phoneNumberError = "";
      });
    }

    if (_userEmailController.text.isEmpty) {
      setState(() {
        _userEmailError = "Campo requerido";
      });
      valid = false;
    } else {
      setState(() {
        _userEmailError = "";
      });
    }

    if (_passwordController.text.isEmpty) {
      setState(() {
        _passwordError = "Campo requerido";
      });
      valid = false;
    } else {
      setState(() {
        _passwordError = "";
      });
    }

    if (_confirmPasswordController.text.isEmpty) {
      setState(() {
        _confirmPasswordError = "Campo requerido";
      });
      valid = false;
    } else {
      setState(() {
        _confirmPasswordError = "";
      });
    }

    if (_passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text != _confirmPasswordController.text) {
      setState(() {
        _passwordError = "Las contraseñas no coinciden";
        _confirmPasswordError = "Las contraseñas no coinciden";
      });
      valid = false;
    } else {
      setState(() {
        _passwordError = "";
        _confirmPasswordError = "";
      });
    }

    return valid;
  }
}
