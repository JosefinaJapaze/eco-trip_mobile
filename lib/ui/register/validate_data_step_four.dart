import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';

class ValidateDataStepFour extends StatefulWidget {
  @override
  _ValidateDataStepFourState createState() => _ValidateDataStepFourState();
}

class _ValidateDataStepFourState extends State<ValidateDataStepFour> {
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;
  XFile? _selfieImage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    _cameraController = CameraController(
      _cameras!.firstWhere(
          (camera) => camera.lensDirection == CameraLensDirection.front),
      ResolutionPreset.medium,
    );

    await _cameraController!.initialize();
    setState(() {}); // Rebuild to show camera preview
  }

  Future<void> _takeSelfie() async {
    if (_cameraController != null && _cameraController!.value.isInitialized) {
      final image = await _cameraController!.takePicture();
      setState(() {
        _selfieImage = image;
      });
    }
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildHeader(),
            SizedBox(height: 16.0),
            _buildCameraPreview(),
            SizedBox(height: 16.0),
            _buildInstructionsText(),
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
          "Retrato con cámara frontal",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildCameraPreview() {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return Container(
        height: 300.0,
        width: 300.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.grey[300],
        ),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return GestureDetector(
        onTap: _takeSelfie,
        child: Container(
          height: 300.0, // Define the size of the circular container
          width: 300.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Make the container round
            border: Border.all(color: Colors.black),
          ),
          clipBehavior: Clip
              .hardEdge, // Ensure the content inside is clipped to the circle
          child: _selfieImage == null
              ? CameraPreview(_cameraController!)
              : Image.file(
                  File(_selfieImage!.path),
                  fit: BoxFit.cover,
                ),
        ),
      );
    }
  }

  Widget _buildInstructionsText() {
    return Text(
      "Apuntá el teléfono hacia el centro de tu cara y no dejes de mirar la pantalla",
      style: TextStyle(fontSize: 16.0, color: Colors.grey[700]),
      textAlign: TextAlign.center,
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
        Navigator.of(context).pushNamed("/register_success");
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
