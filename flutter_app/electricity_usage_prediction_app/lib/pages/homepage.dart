import 'package:electricity_usage_prediction_app/services/api_service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final ApiService apiService = ApiService();

  final _formKey = GlobalKey<FormState>();

  // Controllers for input fields
  final TextEditingController voltageController = TextEditingController();
  final TextEditingController sub1Controller = TextEditingController();
  final TextEditingController sub2Controller = TextEditingController();
  final TextEditingController sub3Controller = TextEditingController();
  final TextEditingController hourController = TextEditingController();

  int dayOfWeek = 0; // Default Monday
  double? prediction;

  void fetchPrediction() async {
    if (_formKey.currentState!.validate()) {
      double? result = await apiService.getPrediction(
        voltage: double.parse(voltageController.text),
        sub1: double.parse(sub1Controller.text),
        sub2: double.parse(sub2Controller.text),
        sub3: double.parse(sub3Controller.text),
        hour: int.parse(hourController.text),
        dayOfWeek: dayOfWeek,
      );

      setState(() {
        prediction = result;
      });
      print(prediction);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Energy Prediction Input')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildTextField('Voltage (V)', voltageController),
              buildTextField('Sub_metering_1', sub1Controller),
              buildTextField('Sub_metering_2', sub2Controller),
              buildTextField('Sub_metering_3', sub3Controller),
              buildTextField('Hour (0-23)', hourController, isInt: true),
              SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: dayOfWeek,
                decoration: InputDecoration(labelText: 'Day of Week'),
                items: [
                  DropdownMenuItem(value: 0, child: Text('Monday')),
                  DropdownMenuItem(value: 1, child: Text('Tuesday')),
                  DropdownMenuItem(value: 2, child: Text('Wednesday')),
                  DropdownMenuItem(value: 3, child: Text('Thursday')),
                  DropdownMenuItem(value: 4, child: Text('Friday')),
                  DropdownMenuItem(value: 5, child: Text('Saturday')),
                  DropdownMenuItem(value: 6, child: Text('Sunday')),
                ],
                onChanged: (value) {
                  setState(() {
                    dayOfWeek = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: fetchPrediction,
                child: Text('Predict'),
              ),
              SizedBox(height: 20),
              if (prediction != null)
                Text(
                  'Prediction: ${prediction!.toStringAsFixed(2)} kW',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    bool isInt = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: !isInt),
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Enter $label';
          if (isInt && int.tryParse(value) == null)
            return 'Enter a valid integer';
          if (!isInt && double.tryParse(value) == null)
            return 'Enter a valid number';
          return null;
        },
      ),
    );
  }
}
