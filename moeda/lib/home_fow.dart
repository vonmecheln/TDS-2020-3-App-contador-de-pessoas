// import '../flutter_flow/flutter_flow_drop_down_template.dart';
import '../flutter_flow/flutter_flow_theme.dart';
// import '../flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageWidget extends StatefulWidget {
  HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late String dropDownValue1;
  late TextEditingController textController1;
  late String dropDownValue2;
  late TextEditingController textController2;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    textController1 = TextEditingController(text: '99.99');
    textController2 = TextEditingController(text: '99.99');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFFD66262),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: textController1,
                          obscureText: false,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFFCDD2),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFFFCDD2),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.title1.apply(
                            color: Colors.white,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),

                      Container(
                        width: 130,
                        height: 40,
                      ),
                      // FlutterFlowDropDown(
                      //   options: ['BRL', 'USD', 'EUR'],
                      //   onChanged: (value) {
                      //     setState(() => dropDownValue1 = value);
                      //   },
                      //   width: 130,
                      //   height: 40,
                      //   textStyle: FlutterFlowTheme.title3.override(
                      //     fontFamily: 'Poppins',
                      //     color: Colors.white,
                      //   ),
                      //   fillColor: Color(0x1CFFFFFF),
                      //   elevation: 2,
                      //   borderColor: Colors.transparent,
                      //   borderWidth: 0,
                      //   borderRadius: 0,
                      //   margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                      //   hidesUnderline: true,
                      // )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Color(0xFFEEEEEE),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: textController2,
                          obscureText: false,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFD66262),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFFD66262),
                                width: 1,
                              ),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(4.0),
                                topRight: Radius.circular(4.0),
                              ),
                            ),
                          ),
                          style: FlutterFlowTheme.title1.apply(
                            color: Color(0xFFEF9A9A),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),

                      Container(
                        width: 130,
                        height: 40,
                      ),

                      // FlutterFlowDropDown(
                      //   options: ['BRL', 'USD', 'EUR'],
                      //   onChanged: (value) {
                      //     setState(() => dropDownValue2 = value);
                      //   },
                      //   width: 130,
                      //   height: 40,
                      //   textStyle: FlutterFlowTheme.title3.override(
                      //     fontFamily: 'Poppins',
                      //     color: Color(0xFFEF9A9A),
                      //   ),
                      //   fillColor: Color(0x1CFFFFFF),
                      //   elevation: 2,
                      //   borderColor: Colors.transparent,
                      //   borderWidth: 0,
                      //   borderRadius: 0,
                      //   margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
                      //   hidesUnderline: true,
                      // )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
