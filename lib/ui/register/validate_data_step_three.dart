import 'dart:io';

import 'package:ecotrip/data/network/apis/user/register_api.dart';
import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/ui/register/store/validation_step_store.dart';
import 'package:ecotrip/utils/routes/routes.dart';
import 'package:ecotrip/widgets/error_message_widget.dart';
import 'package:ecotrip/widgets/navigate_widget.dart';
import 'package:ecotrip/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ValidateDataStepThree extends StatefulWidget {
  @override
  _ValidateDataStepThreeState createState() => _ValidateDataStepThreeState();
}

class _ValidateDataStepThreeState extends State<ValidateDataStepThree> {
  String? _serviceBillFilePath;

  late ValidationStepStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = getIt<ValidationStepStore>();
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _serviceBillFilePath = result.files.single.name;
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
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: 16.0),
              _buildFilePickerField(
                fileName: _serviceBillFilePath,
                hintText: "Factura de Servicio",
                onTap: _pickFile,
              ),
              SizedBox(height: 30.0),
              _buildNextButton(),
            ],
          ),
        ),
        Observer(builder: (_) {
          if (_store.thirdStepSuccess) {
            return NavigateWidget(Routes.validate_data_step_four);
          }
          return ErrorMessageWidget(_store.errorStore.errorMessage);
        }),
        Observer(builder: (_) {
          return Visibility(
            visible: _store.isLoading,
            child: CustomProgressIndicatorWidget(),
          );
        }),
      ]),
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
          "Comprobar lugar de residencia",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildFilePickerField({
    String? fileName,
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
              fileName != null ? fileName : hintText,
              style: TextStyle(
                color: fileName != null ? Colors.black : Colors.grey[600],
              ),
            ),
            Icon(Icons.insert_drive_file, color: Colors.black),
          ],
        ),
      ),
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
        uploadFiles();
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

  uploadFiles() {
    _store.uploadFile(DocumentType.serviceBill, File(_serviceBillFilePath!));
  }
}
