import 'package:ecotrip/data/network/apis/user/register_api.dart';
import 'package:ecotrip/di/components/service_locator.dart';
import 'package:ecotrip/ui/register/store/validation_step_store.dart';
import 'package:ecotrip/utils/routes/routes.dart';
import 'package:ecotrip/widgets/error_message_widget.dart';
import 'package:ecotrip/widgets/navigate_widget.dart';
import 'package:ecotrip/widgets/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class ValidateDataStepTwo extends StatefulWidget {
  @override
  _ValidateDataStepTwoState createState() => _ValidateDataStepTwoState();
}

class _ValidateDataStepTwoState extends State<ValidateDataStepTwo> {
  File? _licenseImage;
  File? _greenCardImage;
  String? _insuranceFilePath;
  String? _plateFilePath;

  final ImagePicker _picker = ImagePicker();

  late ValidationStepStore _store;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _store = getIt<ValidationStepStore>();
  }

  Future<void> _pickImage(String type) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (type == 'Carnet') {
          _licenseImage = File(pickedFile.path);
        } else if (type == 'Tarjeta Verde') {
          _greenCardImage = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _pickFile(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        if (type == 'Seguro') {
          _insuranceFilePath = result.files.single.name;
        } else if (type == 'Patente') {
          _plateFilePath = result.files.single.name;
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                SizedBox(height: 16.0),
                _buildImagePickerField(
                  image: _licenseImage,
                  hintText: "Carnet de Conducir",
                  onTap: () => _pickImage('Carnet'),
                ),
                SizedBox(height: 16.0),
                _buildImagePickerField(
                  image: _greenCardImage,
                  hintText: "Tarjeta Verde",
                  onTap: () => _pickImage('Tarjeta Verde'),
                ),
                SizedBox(height: 16.0),
                _buildFilePickerField(
                  fileName: _insuranceFilePath,
                  hintText: "Seguro",
                  onTap: () => _pickFile('Seguro'),
                ),
                SizedBox(height: 16.0),
                _buildFilePickerField(
                  fileName: _plateFilePath,
                  hintText: "Patente",
                  onTap: () => _pickFile('Patente'),
                ),
                SizedBox(height: 30.0),
                _buildNextButton(),
              ],
            ),
          ),
          Observer(builder: (_) {
            if (_store.secondStepSuccess) {
              return NavigateWidget(Routes.validate_data_step_three);
            } else {
              return ErrorMessageWidget(_store.errorStore.errorMessage);
            }
          }),
          Observer(builder: (_) {
            return Visibility(
              visible: _store.isLoading,
              child: CustomProgressIndicatorWidget(),
            );
          })
        ],
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
          "Datos conductor",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
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

  void uploadFiles() {
    _store.uploadFile(DocumentType.greenCard, _greenCardImage!);
    _store.uploadFile(DocumentType.license, _licenseImage!);
    _store.uploadFile(DocumentType.insurance, File(_insuranceFilePath!));
    _store.uploadFile(DocumentType.plate, File(_plateFilePath!));
  }
}
