import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Colors
const mainColor = Colors.blueGrey;
const backgroundColor = Colors.white;
const foregroundColor = Colors.black;
const palladioColor = Color(0xffbe9d56);
final canvasColor = Colors.grey[200]!;
final drawerColor = Colors.grey[200]!;
const iconsColor = Colors.black;
const iconsTileColor = Colors.black45;
const iconsPopUpMenuColor = Colors.blueGrey;
const iconsColorLight = Colors.white;
const cursorColor = Colors.black;
const transparent = Colors.transparent;
const dividerColor = Colors.black38;
const dividerDarkerColor = Colors.black45;
final lightHighlightColor = Colors.grey[200]!;
final highlightColor = Colors.grey[300]!;
final darkHighlightColor = Colors.grey[400]!;
const selectedColor = Colors.grey;
final deactivatedColor = Colors.grey[300]!;
const opaqueColor = Colors.black12;
const stdBadgeColor = Colors.red;
const operationBadgeColor = Colors.lightBlueAccent;
final borderShadowColor = Colors.grey[500]!;
//
const missingInfoColor = Colors.indigoAccent;
const dangerColor = Colors.red;
const dangerLightColor = Colors.red;
const warningColor = Colors.yellow;
const warningSecondaryColor = Colors.orange;
final warningLightSecondaryColor = Colors.orange[400]!;
const successColor = Colors.green;
final successSecondaryColor = Colors.lightGreen[400]!;
const successLightColor = Colors.lightGreen;
const infoColor = Colors.lightBlue;
const darkInfoColor = Colors.blue;
const debugItemColor = Colors.deepPurple;
//
const errorColor = Colors.red;
const focusColor = Colors.blueAccent;
const correctColor = Colors.green;
const incompleteColor = Colors.yellow;
const interactiveColor = Colors.blue;
//
const completedPresenza = Colors.green;
const neverStarted = Colors.red;
const incompletedPresenza = Colors.orange;
const overflowPresenza = Colors.blue;
//
const bottomBannerColor = Colors.yellow;
//
const darkTextColor = Colors.black;
const lightTextColor = Colors.white;
const opaqueTextColor = Colors.grey;
final successOpaqueTextColor = Colors.green[50];
//
const timelineConnectorColor = Colors.grey;
final eventsDotColor = mainColor[300]!;
//
const notificationColor = Colors.orange;
final receivedBubbleColor = Colors.grey[300]!;
final sentBubbleColor = Colors.green[300]!;
//
const tabBarColor = Colors.blue;

class Styles {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      useMaterial3: false,
      primarySwatch: mainColor,
      primaryColor: backgroundColor,
      indicatorColor: const Color(0xffCBDCF8),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Color(0xffF1F5FB),
      ),
      hintColor: const Color(0xffc0c0c0),
      highlightColor: highlightColor,
      hoverColor: transparent,
      focusColor: transparent,
      disabledColor: Colors.grey,
      iconTheme: const IconThemeData(color: iconsColor),
      textSelectionTheme:
          const TextSelectionThemeData(cursorColor: cursorColor),
      fontFamily: GoogleFonts.poppins().fontFamily,
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      cardColor: backgroundColor,
      canvasColor: canvasColor,
      brightness: Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
            colorScheme: const ColorScheme.light(),
          ),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
      dividerTheme: const DividerThemeData(color: dividerColor),
      tabBarTheme: const TabBarTheme(
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0, color: tabBarColor),
        ),
      ),
    );
  }
}
