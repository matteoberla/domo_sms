import 'package:domo_sms/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum AllowedChars { text, integer, double, date, time }

class PalladioTextInput extends StatelessWidget {
  const PalladioTextInput(
      {super.key,
      required this.textController,
      this.focusNode,
      this.onTap,
      this.onChanged,
      this.focused,
      this.error,
      this.textAlign = TextAlign.end,
      this.forcedKeyboard = false,
      this.keyboardType = TextInputType.text,
      this.onFocusChanged,
      required this.allowedChars,
      this.readOnly = false,
      this.enabled = true,
      this.obscured = false,
      this.padding = 5.0,
      this.borderColor = mainColor,
      this.showClearButton = false,
      this.onClearTap});

  final TextEditingController textController;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final Function(String newText)? onChanged;
  final bool? focused;
  final bool? error;
  final TextAlign textAlign;
  final bool forcedKeyboard;
  final TextInputType? keyboardType;
  final VoidCallback? onFocusChanged;
  final AllowedChars allowedChars;
  final bool readOnly;
  final bool enabled;
  final bool obscured;
  final double padding;
  final Color borderColor;
  final bool showClearButton;
  final VoidCallback? onClearTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: padding, horizontal: 3),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10.0),
        ),
        border: Border.all(
          width: getWidth(error, focused),
          color: getBorderColor(error, focused),
        ),
      ),
      child: Focus(
        onFocusChange: (hasFocus) {
          if (onFocusChanged != null && hasFocus == false) {
            onFocusChanged!();
          }
        },
        child: TextField(
          obscureText: obscured,
          decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: showClearButton
                ? IconButton(
                    onPressed: onClearTap,
                    icon: const Icon(Icons.clear),
                  )
                : null,
          ),
          showCursor: kIsWeb ? true : forcedKeyboard,
          keyboardType: forcedKeyboard ? keyboardType : TextInputType.none,
          inputFormatters: <TextInputFormatter>[
            if (allowedChars == AllowedChars.double)
              FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,10}')),
            if (allowedChars == AllowedChars.integer)
              FilteringTextInputFormatter.digitsOnly,
            if (allowedChars == AllowedChars.date)
              FilteringTextInputFormatter.allow(RegExp(
                  r'^\d{0,2}[.,\/:]{0,2}(\d{0,2}[.,\/:]{0,2}(\d{0,4}))')),
            if (allowedChars == AllowedChars.time)
              FilteringTextInputFormatter.allow(
                  RegExp(r'^\d{0,2}[.,\/:]{0,2}(\d{0,2}[.,\/:]{0,2}(\d{0,2}))'))
          ],
          // Only numbers can be entered
          maxLines: obscured ? 1 : null,
          controller: textController,
          focusNode: focusNode,
          onTap: onTap,
          onChanged: onChanged,
          textAlign: textAlign,
          readOnly: readOnly,
          enabled: enabled,
        ),
      ),
    );
  }

  Color getBorderColor(bool? error, bool? focused) {
    if (error == true) {
      return errorColor;
    }
    if (focused == true) {
      return focusColor;
    } else {
      return borderColor;
    }
  }

  double getWidth(bool? error, bool? focused) {
    if (error == true) {
      return 2.0;
    }
    if (focused == true) {
      return 1.5;
    } else {
      return 1.0;
    }
  }
}
