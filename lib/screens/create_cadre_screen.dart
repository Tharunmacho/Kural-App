import 'package:flutter/material.dart';

class CreateCadreScreen extends StatefulWidget {
  const CreateCadreScreen({super.key});

  @override
  State<CreateCadreScreen> createState() => _CreateCadreScreenState();
}

class _CreateCadreScreenState extends State<CreateCadreScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Text controllers
  final TextEditingController _activeElectionController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _postalCodeController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  // Selected values
  String selectedGender = '';
  String selectedRole = '';
  String selectedBooth = '';
  String selectedStatus = 'Active';

  // Lists for dropdowns
  final List<String> roles = [
    'Team Leader',
    'Coordinator',
    'Field Agent',
    'Supervisor',
    'Manager',
    'Admin',
  ];

  final List<String> booths = [
    'Booth 001 - Community Center',
    'Booth 002 - Primary School',
    'Booth 003 - Government Office',
    'Booth 004 - Village Hall',
    'Booth 005 - Temple Complex',
  ];

  final List<String> statuses = ['Active', 'Inactive'];

  @override
  void initState() {
    super.initState();
    _activeElectionController.text = '119 - Thondamuthur';
    _stateController.text = 'Tamil Nadu';
    _countryController.text = 'India';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F7FA),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create Cadre',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Active Election
              _buildSectionTitle('Active Election'),
              _buildTextField(
                controller: _activeElectionController,
                enabled: false,
              ),
              const SizedBox(height: 20),

              // First Name
              _buildSectionTitle('First Name *'),
              _buildTextField(
                controller: _firstNameController,
                hintText: 'First Name',
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Last Name
              _buildSectionTitle('Last Name'),
              _buildTextField(
                controller: _lastNameController,
                hintText: 'Last Name',
              ),
              const SizedBox(height: 20),

              // Mobile Number
              _buildSectionTitle('Mobile Number *'),
              _buildTextField(
                controller: _mobileController,
                hintText: 'Mobile Number',
                keyboardType: TextInputType.phone,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Gender
              _buildSectionTitle('Gender *'),
              _buildGenderSelection(),
              const SizedBox(height: 20),

              // Password
              _buildSectionTitle('Password*'),
              _buildTextField(
                controller: _passwordController,
                hintText: 'Password',
                obscureText: true,
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Role
              _buildSectionTitle('Role'),
              _buildDropdown(
                value: selectedRole.isEmpty ? null : selectedRole,
                hintText: 'Select Role',
                items: roles,
                onChanged: (value) {
                  setState(() {
                    selectedRole = value ?? '';
                  });
                },
              ),
              const SizedBox(height: 20),

              // Booth Allocation
              _buildSectionTitle('Booth Allocation *'),
              _buildDropdown(
                value: selectedBooth.isEmpty ? null : selectedBooth,
                hintText: 'Select Booth',
                items: booths,
                onChanged: (value) {
                  setState(() {
                    selectedBooth = value ?? '';
                  });
                },
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Status
              _buildSectionTitle('Status *'),
              _buildDropdown(
                value: selectedStatus,
                hintText: 'Active',
                items: statuses,
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value ?? 'Active';
                  });
                },
                isRequired: true,
              ),
              const SizedBox(height: 20),

              // Email
              _buildSectionTitle('Email'),
              _buildTextField(
                controller: _emailController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),

              // Address - Street
              _buildSectionTitle('Address - Street'),
              _buildTextField(
                controller: _streetController,
                hintText: 'Street',
              ),
              const SizedBox(height: 20),

              // City
              _buildSectionTitle('City'),
              _buildTextField(
                controller: _cityController,
                hintText: 'City',
              ),
              const SizedBox(height: 20),

              // State
              _buildSectionTitle('State *'),
              _buildTextField(
                controller: _stateController,
                enabled: false,
              ),
              const SizedBox(height: 20),

              // Country
              _buildSectionTitle('Country'),
              _buildTextField(
                controller: _countryController,
                enabled: false,
              ),
              const SizedBox(height: 20),

              // Postal Code
              _buildSectionTitle('Postal Code'),
              _buildTextField(
                controller: _postalCodeController,
                hintText: 'Postal Code',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),

              // Remarks
              _buildSectionTitle('Remarks'),
              _buildTextField(
                controller: _remarksController,
                hintText: 'Remarks',
                maxLines: 3,
              ),
              const SizedBox(height: 40),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveCadre,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Save and Continue',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String? hintText,
    bool obscureText = false,
    bool enabled = true,
    bool isRequired = false,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        enabled: enabled,
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: isRequired ? (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        } : null,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildGenderSelection() {
    return Row(
      children: [
        _buildGenderCheckbox('Male'),
        const SizedBox(width: 20),
        _buildGenderCheckbox('Female'),
        const SizedBox(width: 20),
        _buildGenderCheckbox('Other'),
      ],
    );
  }

  Widget _buildGenderCheckbox(String gender) {
    return Row(
      children: [
        Checkbox(
          value: selectedGender == gender,
          onChanged: (value) {
            setState(() {
              selectedGender = value == true ? gender : '';
            });
          },
          activeColor: Color(0xFF1976D2),
        ),
        Text(
          gender,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hintText,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    bool isRequired = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Text(
          hintText,
          style: TextStyle(color: Color(0xFF1976D2)),
        ),
        validator: isRequired ? (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        } : null,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  void _saveCadre() {
    if (_formKey.currentState!.validate()) {
      if (selectedGender.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a gender'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      if (selectedBooth.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a booth allocation'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // Show success message and navigate back
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Cadre created successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate back to My Cadre screen
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _activeElectionController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _countryController.dispose();
    _postalCodeController.dispose();
    _remarksController.dispose();
    super.dispose();
  }
}
