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
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();

  late FocusNode _passwordFocusNode;
  late FocusNode _confirmPasswordFocusNode;

  late RegisterStore _store;

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
    _confirmPasswordFocusNode = FocusNode();
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
    return Stack(children: [
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
    ]);
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
    return _buildTextField("Nombre", _nameController);
  }

  Widget _buildLastNameField() {
    return _buildTextField("Apellido", _lastNameController);
  }

  Widget _buildGenderField() {
    return _buildTextField("Sexo", _genderController);
  }

  Widget _buildAgeField() {
    return _buildTextField("Edad", _ageController);
  }

  Widget _buildPhoneNumberField() {
    return _buildTextField("Numero de Celular", _phoneNumberController);
  }

  Widget _buildEmailField() {
    return _buildTextField("Correo electronico", _userEmailController);
  }

  Widget _buildPasswordField() {
    return _buildTextField("Contraseña", _passwordController, isObscure: true);
  }

  Widget _buildConfirmPasswordField() {
    return _buildTextField("Repetir contraseña", _confirmPasswordController, isObscure: true);
  } 

  Widget _buildTextField(String hint, TextEditingController? controller, {bool isObscure = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
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
      Navigator.of(context).pushNamed(Routes.validate_data_step_one);
    });
    return Container();
  }
}
