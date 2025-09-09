import 'package:flutter/material.dart';

class FamilyDetailsScreen extends StatelessWidget {
  final int familyNumber;
  final int partNumber;
  
  const FamilyDetailsScreen({
    super.key, 
    required this.familyNumber,
    required this.partNumber,
  });

  @override
  Widget build(BuildContext context) {
    // Sample family data based on family number
    List<Map<String, dynamic>> familyMembers = _getFamilyMembers();
    
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header section
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFE3F2FD),
                    Color(0xFFBBDEFB),
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black87,
                        size: 24,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Part $partNumber - Family',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                  ), // Spacer to center the title
                ],
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Total voters section
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Total Voters: ${familyMembers.length}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Family members list
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: familyMembers.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    child: _buildFamilyMemberCard(familyMembers[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFamilyMembers() {
    if (familyNumber == 1) {
      return [
        {
          'serialNo': 4,
          'section': 1,
          'part': 1,
          'name': 'revathi',
          'tamilName': 'ரேவதி',
          'fatherName': 'thirunavukarasu',
          'fatherTamilName': 'திருநாவுக்கரசு',
          'voterId': 'RIV2260768',
          'doorNo': 'Door No 1',
          'age': 56,
          'relation': 'Husband',
          'gender': 'female',
        },
      ];
    } else if (familyNumber == 2) {
      return [
        {
          'serialNo': 551,
          'section': 1,
          'part': 2,
          'name': 'zavasanthi',
          'tamilName': 'வசந்தி',
          'fatherName': 'chinnasamy',
          'fatherTamilName': 'சின்னசாமி',
          'voterId': 'RIV2501039',
          'doorNo': 'Door No 60',
          'age': 56,
          'relation': 'Husband',
          'gender': 'female',
        },
      ];
    } else {
      return [];
    }
  }

  Widget _buildFamilyMemberCard(Map<String, dynamic> member) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with serial, section, part
          Row(
            children: [
              Text(
                'Serial : ${member['serialNo']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1976D2),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                'Section : ${member['section']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1976D2),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                'Part : ${member['part']}',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF1976D2),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Member details row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile image
              Container(
                width: 100,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.image,
                            color: Colors.blue,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: Color(0xFF1976D2),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Text(
                        member['voterId'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Member information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member['name'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      member['tamilName'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      member['fatherName'],
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      member['fatherTamilName'],
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      member['doorNo'],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 16),
          
          // Age and relation row
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: member['gender'] == 'female' 
                      ? Colors.pink[100] 
                      : Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      member['gender'] == 'female' 
                          ? Icons.female 
                          : Icons.male,
                      color: member['gender'] == 'female' 
                          ? Colors.pink 
                          : Colors.blue,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${member['age']}',
                      style: TextStyle(
                        color: member['gender'] == 'female' 
                            ? Colors.pink 
                            : Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                member['relation'],
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
