import 'package:flutter/material.dart';

class VoterHistoryFilter extends StatelessWidget {
  final Set<String> selectedVoterHistory;
  final StateSetter setModalState;

  const VoterHistoryFilter({
    super.key,
    required this.selectedVoterHistory,
    required this.setModalState,
  });

  @override
  Widget build(BuildContext context) {
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
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _buildHistoryChip('2024', 'PC', Color(0xFF1976D2)), // Blue for PC (Parliamentary Constituency)
            _buildHistoryChip('2022', 'ULB', Color(0xFFD32F2F)), // Red for ULB (Urban Local Bodies)
            _buildHistoryChip('2021', 'AC', Color(0xFF388E3C)), // Green for AC (Assembly Constituency)
            _buildNotVotedChip(), // Special chip for not voted
          ],
        ),
      ],
    );
  }

  Widget _buildHistoryChip(String year, String type, Color color) {
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
          color: isSelected ? color.withValues(alpha: 0.2) : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : Colors.grey[300]!,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                year,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(
                type,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotVotedChip() {
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
            const SizedBox(height: 2),
            Text(
              'Not\nVoted',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
