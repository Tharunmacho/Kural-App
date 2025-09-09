import 'package:flutter/material.dart';

class ViewElectionScreen extends StatefulWidget {
  const ViewElectionScreen({super.key});

  @override
  State<ViewElectionScreen> createState() => _ViewElectionScreenState();
}

class _ViewElectionScreenState extends State<ViewElectionScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.close,
            color: Colors.black87,
            size: 28,
          ),
        ),
        title: Text(
          'View Election',
          style: TextStyle(
            color: Color(0xFF1565C0), // Dark blue color
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step 1: Create Election
            _buildSectionTitle('Step 1: Create Election'),
            const SizedBox(height: 20),
            
            // Election Picture Section
            _buildSubSectionTitle('Election Picture'),
            const SizedBox(height: 12),
            _buildElectionPictureSection(),
            const SizedBox(height: 20),
            
            // Category Section
            _buildSubSectionTitle('Category'),
            const SizedBox(height: 12),
            _buildInputField(''),
            const SizedBox(height: 20),
            
            // Election Information Section
            _buildSubSectionTitle('Election Information'),
            const SizedBox(height: 12),
            
            _buildFieldLabel('Election Type'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Election Body'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Country'),
            const SizedBox(height: 8),
            _buildInputField('India'),
            const SizedBox(height: 16),
            
            _buildFieldLabel('State'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('PC Name'),
            const SizedBox(height: 8),
            _buildInputField('Pollachi'),
            const SizedBox(height: 16),
            
            _buildFieldLabel('AC Name'),
            const SizedBox(height: 8),
            _buildInputField('Thondamuthur'),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Urban Name'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Rural Name'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Election Name'),
            const SizedBox(height: 8),
            _buildInputField('119 - Thondamuthur'),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Election Description'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Election Date'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Status'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 20),
            
            // Booth Information Section
            _buildSubSectionTitle('Booth Information'),
            const SizedBox(height: 12),
            
            _buildFieldLabel('Total Number of Booths'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Total All Booths'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Number of Pink Booths'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 20),
            
            // Voter Information Section
            _buildSubSectionTitle('Voter Information'),
            const SizedBox(height: 12),
            
            _buildFieldLabel('Total Voters'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Male Voters'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Female Voters'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Transgender Voters'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 20),
            
            // Remarks Section
            _buildSubSectionTitle('Remarks'),
            const SizedBox(height: 12),
            
            _buildFieldLabel('Remarks'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 20),
            
            // Calendar of Event Section
            _buildSubSectionTitle('Calendar of Event'),
            const SizedBox(height: 12),
            
            _buildFieldLabel('Gazette Notification'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Last Date for Filling Nomination'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Scrutiny Nomination'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Last Date for Withdrawal of Nomination'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Date of Poll'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Date of Counting of Votes'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 16),
            
            _buildFieldLabel('Completion Deadline'),
            const SizedBox(height: 8),
            _buildInputField(''),
            const SizedBox(height: 30),
            
            // Edit Button
            _buildEditButton(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _buildSubSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF1565C0), // Dark blue color
      ),
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Color(0xFF1565C0), // Dark blue color
      ),
    );
  }

  Widget _buildElectionPictureSection() {
    return Row(
      children: [
        // Profile picture
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/icons/star.png', // Using star icon as placeholder
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey[600],
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 20),
        
        // Upload Photo Button
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Text(
            'Upload Photo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInputField(String initialValue) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Text(
        initialValue,
        style: TextStyle(
          fontSize: 16,
          color: initialValue.isEmpty ? Colors.grey[500] : Colors.black87,
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Edit',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
