import 'package:ecotrip/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/ui/register/store/validation_step_store.dart';

class RegisterSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = getIt<ValidationStepStore>();
    final rol = store.userType == 'driver' ? 'conductor' : 'pasajero';

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildValidationIcon(),
            SizedBox(height: 30.0),
            _buildTitleText(),
            SizedBox(height: 10.0),
            _buildSubtitleText(rol),
            SizedBox(height: 40.0),
            _buildConfirmButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildValidationIcon() => Icon(Icons.check_circle, size: 150.0, color: Colors.green);

  Widget _buildTitleText() => Text(
        "Se validó tu identidad",
        style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      );

  Widget _buildSubtitleText(String rol) => Text(
        "Validamos correctamente tu identidad. Ahora puedes empezar a realizar viajes como $rol",
        style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
        textAlign: TextAlign.center,
      );

  Widget _buildConfirmButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lime,
        padding: EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
      onPressed: () {
        Future.delayed(Duration.zero, () {
          Navigator.of(context).pushNamedAndRemoveUntil(
            Routes.login,
            (route) => false,
          );
        });
      },
      child: Center(
        child: Text(
          "CONFIRMAR",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
    );
  }
}