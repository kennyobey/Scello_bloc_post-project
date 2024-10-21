import 'package:flutter/material.dart';

class SaveChangesButton extends StatelessWidget {
  final bool isEditing;
  final VoidCallback onPressed;

  const SaveChangesButton({
    Key? key,
    required this.isEditing,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: isEditing ? null : onPressed,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 40,
        ),
        backgroundColor: Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      icon: const Icon(Icons.save, color: Colors.white),
      label: const Text(
        'Save Changes',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}