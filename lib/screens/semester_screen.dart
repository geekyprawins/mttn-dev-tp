import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_material_bank/data/semesters.dart';
import 'package:study_material_bank/screens/subjects_screen.dart';
import 'package:study_material_bank/utils/animated_page_route.dart';

class SemesterScreen extends StatefulWidget {
  const SemesterScreen({Key? key, required this.branchCode}) : super(key: key);
  final int branchCode;
  @override
  _SemesterScreenState createState() => _SemesterScreenState();
}

class _SemesterScreenState extends State<SemesterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        centerTitle: true,
        title: Text(
          "Select Semester",
          style: GoogleFonts.iceberg(
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              child: semTiles[index],
              onTap: () {
                Navigator.push(
                  context,
                  AnimatedPageRoute(
                    SubjectsScreen(
                      semCode: 3 + index,
                      branchCode: widget.branchCode,
                    ),
                  ),
                );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.white,
            );
          },
          itemCount: semTiles.length,
        ),
      ),
    );
  }
}
