import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:study_material_bank/data/subjects.dart';
import 'package:study_material_bank/utils/constants.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({
    Key? key,
    required this.semCode,
    required this.branchCode,
  }) : super(key: key);
  final int semCode;
  final int branchCode;

  @override
  _SubjectsScreenState createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  List<String> getSubjects() {
    if (widget.branchCode == 0) {
      switch (widget.semCode) {
        case 3:
          return cseSem3Subs;
        case 4:
          return cseSem4Subs;
        case 5:
          return cseSem5Subs;
        case 6:
          return cseSem6Subs;

        default:
          return [];
      }
    } else if (widget.branchCode == 1) {
      switch (widget.semCode) {
        case 3:
          return eeeSem3Subs;
        case 4:
          return eeeSem4Subs;
        case 5:
          return eeeSem5Subs;
        case 6:
          return eeeSem6Subs;

        default:
          return [];
      }
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0111),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Select Subject",
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: index % 2 == 0 ? kTile1 : kTile2,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            getSubjects()[index],
                            style: GoogleFonts.lemonada(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                print(widget.semCode);
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(
              color: Colors.white,
            );
          },
          itemCount: getSubjects().length,
        ),
      ),
    );
  }
}
