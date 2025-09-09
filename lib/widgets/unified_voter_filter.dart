import 'package:flutter/material.dart';

class UnifiedVoterFilter extends StatelessWidget {
  final double minAge;
  final double maxAge;
  final Set<String> selectedGenders;
  final Set<String> selectedVoterHistory;
  final Set<String> selectedVoterCategory;
  final Set<String> selectedPoliticalParty;
  final Set<String> selectedReligion;
  final StateSetter setModalState;
  final Function(double, double) onAgeChanged;

  const UnifiedVoterFilter({
    super.key,
    required this.minAge,
    required this.maxAge,
    required this.selectedGenders,
    required this.selectedVoterHistory,
    required this.selectedVoterCategory,
    required this.selectedPoliticalParty,
    required this.selectedReligion,
    required this.setModalState,
    required this.onAgeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Age filter
        _buildAgeFilter(),
        const SizedBox(height: 30),
        
        // Gender filter
        _buildGenderFilter(),
        const SizedBox(height: 30),
        
        // Voter History filter
        _buildVoterHistoryFilter(),
        const SizedBox(height: 30),
        
        // Voter Category filter
        _buildVoterCategoryFilter(),
        const SizedBox(height: 30),
        
        // Political Party filter
        _buildPoliticalPartyFilter(),
        const SizedBox(height: 30),
        
        // Religion filter
        _buildReligionFilter(),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildAgeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Age',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Text('Age ${minAge.round()}'),
            Spacer(),
            Text('Age ${maxAge.round()}'),
          ],
        ),
        RangeSlider(
          values: RangeValues(minAge, maxAge),
          min: 0,
          max: 120,
          divisions: 120,
          labels: RangeLabels(
            minAge.round().toString(),
            maxAge.round().toString(),
          ),
          onChanged: (RangeValues values) {
            setModalState(() {
              onAgeChanged(values.start, values.end);
            });
          },
        ),
      ],
    );
  }

  Widget _buildGenderFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildGenderChip('Male', Icons.person, Colors.blue),
            const SizedBox(width: 16),
            _buildGenderChip('Female', Icons.person, Colors.pink),
            const SizedBox(width: 16),
            _buildGenderChip('Others', Icons.transgender, Colors.orange),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderChip(String label, IconData icon, Color color) {
    bool isSelected = selectedGenders.contains(label);
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedGenders.remove(label);
          } else {
            selectedGenders.add(label);
          }
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? color : Colors.grey[600],
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? color : Colors.grey[600],
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoterHistoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Voter History',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildHistoryBadge('2024', 'PC', Color(0xFF1976D2)),
            const SizedBox(width: 12),
            _buildHistoryBadge('2022', 'ULB', Color(0xFFD32F2F)),
            const SizedBox(width: 12),
            _buildHistoryBadge('2021', 'AC', Color(0xFF388E3C)),
            const SizedBox(width: 12),
            _buildNotVotedBadge(),
          ],
        ),
      ],
    );
  }

  Widget _buildHistoryBadge(String year, String type, Color color) {
    String key = '$year $type';
    bool isSelected = selectedVoterHistory.contains(key);
    
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedVoterHistory.remove(key);
          } else {
            selectedVoterHistory.add(key);
          }
        });
      },
      child: Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              year,
              style: TextStyle(
                color: isSelected ? color : Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Text(
              type,
              style: TextStyle(
                color: isSelected ? color : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotVotedBadge() {
    String key = 'Not Voted';
    bool isSelected = selectedVoterHistory.contains(key);
    
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedVoterHistory.remove(key);
          } else {
            selectedVoterHistory.add(key);
          }
        });
      },
      child: Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey.withValues(alpha: 0.3) : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Colors.grey[600]! : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoterCategoryFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Voter Category',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            // Row 1
            _buildCategoryIcon('Active', Icons.check_circle, Colors.green),
            _buildCategoryIcon('Inactive', Icons.cancel, Colors.red),
            _buildCategoryIcon('Unknown', Icons.help, Colors.grey),
            _buildCategoryIcon('Shifted', Icons.trending_up, Colors.blue),
            _buildCategoryIcon('Dead', Icons.dangerous, Colors.black),
            
            // Row 2
            _buildCategoryIcon('Duplicate', Icons.content_copy, Colors.blue),
            _buildCategoryIcon('Disabled', Icons.accessible, Colors.grey),
            _buildCategoryIcon('Family', Icons.family_restroom, Colors.brown),
            _buildCategoryIcon('ID Card', Icons.badge, Colors.blue),
            _buildCategoryIcon('Professional', Icons.work, Colors.orange),
            
            // Row 3
            _buildCategoryIcon('Booth', Icons.location_on, Colors.red),
            _buildCategoryIcon('Profile', Icons.account_circle, Colors.pink),
            _buildCategoryIcon('Verified', Icons.verified, Colors.green),
            _buildCategoryIcon('Group', Icons.group, Colors.green),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryIcon(String label, IconData icon, Color color) {
    bool isSelected = selectedVoterCategory.contains(label);
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedVoterCategory.remove(label);
          } else {
            selectedVoterCategory.add(label);
          }
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.grey[100],
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Icon(
          icon,
          color: isSelected ? color : Colors.grey[600],
          size: 24,
        ),
      ),
    );
  }

  Widget _buildPoliticalPartyFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Political Party',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            // Row 1 - Main parties with emojis representing party symbols
            _buildPartyIcon('🌿', 'DMK', Colors.red),
            _buildPartyIcon('🪷', 'BJP', Colors.orange),
            _buildPartyIcon('🛡️', 'ADMK', Colors.green),
            _buildPartyIcon('✋', 'Congress', Colors.blue),
            _buildPartyIcon('🥨', 'Others', Colors.grey),
            
            // Row 2 - Additional parties
            _buildPartyIcon('⚫', 'Independent', Colors.black),
            _buildPartyIcon('🌞', 'PMK', Colors.yellow),
            _buildPartyIcon('🇮🇳', 'Nationalist', Colors.blue),
            _buildPartyIcon('🔵', 'Regional', Colors.blue),
            _buildPartyIcon('🔴', 'Socialist', Colors.red),
            
            // Row 3 - More parties
            _buildPartyIcon('☭', 'Communist', Colors.red),
            _buildPartyIcon('🎯', 'Alliance', Colors.purple),
            _buildPartyIcon('🎤', 'Voice', Colors.orange),
          ],
        ),
      ],
    );
  }

  Widget _buildPartyIcon(String emoji, String party, Color color) {
    bool isSelected = selectedPoliticalParty.contains(party);
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedPoliticalParty.remove(party);
          } else {
            selectedPoliticalParty.add(party);
          }
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.grey[100],
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            emoji,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }

  Widget _buildReligionFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Religion',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            // Row 1
            _buildReligionIcon('🕉️', 'Hindu', Colors.orange),
            _buildReligionIcon('☪️', 'Muslim', Colors.green),
            _buildReligionIcon('✝️', 'Christian', Colors.blue),
            _buildReligionIcon('🤲', 'Buddhist', Colors.purple),
            _buildReligionIcon('☬', 'Sikh', Colors.blue),
            
            // Row 2
            _buildReligionIcon('🔯', 'Jain', Colors.yellow),
          ],
        ),
      ],
    );
  }

  Widget _buildReligionIcon(String emoji, String religion, Color color) {
    bool isSelected = selectedReligion.contains(religion);
    return GestureDetector(
      onTap: () {
        setModalState(() {
          if (isSelected) {
            selectedReligion.remove(religion);
          } else {
            selectedReligion.add(religion);
          }
        });
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.grey[100],
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            emoji,
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
