import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BranchTile extends StatelessWidget {
  const BranchTile({
    Key? key,
    required this.bgColor,
    required this.branch,
  }) : super(key: key);
  final LinearGradient bgColor;
  final String branch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          gradient: bgColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Center(
          child: Text(
            branch,
            style: GoogleFonts.lemonada(
              fontSize: 15,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
