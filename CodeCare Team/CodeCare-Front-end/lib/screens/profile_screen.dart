import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _fullNameController = TextEditingController();
  final _dobController = TextEditingController();
  final _genderController = TextEditingController();
  final _bloodTypeController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _allergiesController = TextEditingController();
  final _conditionsController = TextEditingController();
  final _medicationsController = TextEditingController();
  final _emergencyContactController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  DateTime? _selectedDob;

  void _pickDateOfBirth() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDob = pickedDate;
        _dobController.text = DateFormat.yMMMd().format(pickedDate);
      });
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _dobController.dispose();
    _genderController.dispose();
    _bloodTypeController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _allergiesController.dispose();
    _conditionsController.dispose();
    _medicationsController.dispose();
    _emergencyContactController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: const Color(0xFF1F6F68),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile picture
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(Icons.person, size: 50, color: Colors.white70),
            ),
            const SizedBox(height: 16),

            _buildTextField(_fullNameController, "Full Name"),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: _pickDateOfBirth,
              child: AbsorbPointer(
                child: _buildTextField(_dobController, "Date of Birth"),
              ),
            ),
            const SizedBox(height: 10),

            _buildTextField(_genderController, "Gender"),
            const SizedBox(height: 10),

            _buildTextField(_bloodTypeController, "Blood Type"),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(child: _buildTextField(_weightController, "Weight (kg)")),
                const SizedBox(width: 10),
                Expanded(child: _buildTextField(_heightController, "Height (cm)")),
              ],
            ),
            const SizedBox(height: 10),

            _buildTextField(_allergiesController, "Allergies"),
            const SizedBox(height: 10),

            _buildTextField(_conditionsController, "Medical Conditions"),
            const SizedBox(height: 10),

            _buildTextField(_medicationsController, "Current Medications"),
            const SizedBox(height: 10),

            _buildTextField(_emergencyContactController, "Emergency Contact"),
            const SizedBox(height: 10),

            _buildTextField(_phoneController, "Phone Number"),
            const SizedBox(height: 10),

            _buildTextField(_emailController, "Email Address"),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save profile data locally or to database
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profile Saved!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1F6F68),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Save Profile",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
    );
  }
}