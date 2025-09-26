import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme
{
  static Color primaryColor = Colors.blue.shade800;
  static const Color primaryLightColor = Colors.blue;
  static const Color secondaryColor = Colors.white;
  static Color headerColor = const Color(0xFF345C72);
  static Color redColor = const Color(0xFFFA0951);
  static Color pinkColor = const Color(0xFFEEB0D3);
  static Color purpleColor = const Color(0xFFA89CE3);
  static Color shadowColor = Colors.grey.shade100;
  static Color greyColor = const Color(0xFFF5F4F6);
  static Color lightTeal = const Color(0xFF74B0B6);
  static Color amberColor = const Color(0xFFF7BE33);
  static Color iconColor = const Color(0xFF4D4D4D);
  static Color greenColor = const Color(0xFF25CF43) ;
  static Color chatBubbleColor = const Color(0xFFF5D4E7);
  static Color orangeColor = const Color(0xFFFF8570);
  static Color planTextColor = const Color(0xFF2D2D2D);

  static ThemeData getLightTheme(BuildContext context){
    return ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSeed( seedColor: primaryColor),
        useMaterial3: true,
        splashColor: Colors.grey.shade100,
        primaryColor: primaryColor,
        focusColor: primaryColor,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        primaryColorDark: Colors.black,
        primaryColorLight: primaryColor,
        scrollbarTheme: ScrollbarThemeData(
          thumbColor:  WidgetStatePropertyAll(primaryColor),
          trackColor: WidgetStatePropertyAll(Colors.grey.shade300),
          // thumbVisibility: WidgetStatePropertyAll(true),
          // trackVisibility: WidgetStatePropertyAll(true),
        ),
        radioTheme:  RadioThemeData(
          fillColor: WidgetStatePropertyAll(primaryColor),
          overlayColor: WidgetStatePropertyAll(Colors.transparent),
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )
          // surfaceTintColor: Colors.white,
        ),
        cardColor: Colors.white,
        dividerTheme: DividerThemeData(
            color: Colors.grey.shade400
        ),
        listTileTheme: ListTileThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )
        ),
        dividerColor: Colors.grey.shade400,
        dialogBackgroundColor: Colors.white,
        dialogTheme: const DialogThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  )
              ),
              backgroundColor: WidgetStatePropertyAll(primaryColor),
              foregroundColor: const WidgetStatePropertyAll(Colors.white),
            )
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  )
              ),
              side:  WidgetStatePropertyAll(
                BorderSide(color: primaryColor, width: 2.0),
              ),
              foregroundColor:  WidgetStatePropertyAll(
                  primaryColor
              )
          ),

        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  )
              ),
            foregroundColor:  WidgetStatePropertyAll(primaryColor)

          ),

        ),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.deepPurple,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: Colors.black),
            foregroundColor: Colors.black,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.light,
              statusBarIconBrightness: Brightness.light,
            )
        ),
        iconTheme:  IconThemeData(
          color: primaryColor
        ),
        progressIndicatorTheme:  ProgressIndicatorThemeData(
            color: primaryColor
        ),
        bottomNavigationBarTheme:  BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
        ),
        floatingActionButtonTheme:  FloatingActionButtonThemeData(
          backgroundColor: primaryColor
        ),
        timePickerTheme: const TimePickerThemeData(
          backgroundColor: Colors.white,
          cancelButtonStyle: ButtonStyle(
            foregroundColor: WidgetStatePropertyAll(Colors.black)
          ),
          confirmButtonStyle: ButtonStyle(
              foregroundColor: WidgetStatePropertyAll(Colors.black)
          )
      ),
        switchTheme:  SwitchThemeData(
            trackColor:  WidgetStatePropertyAll(primaryColor),
            thumbColor: const WidgetStatePropertyAll(Colors.white),
            trackOutlineColor: WidgetStatePropertyAll(iconColor),
        )
    );
  }

  static ThemeData getDarkTheme(BuildContext context){
    return ThemeData(
        fontFamily: 'Poppins',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple),
        useMaterial3: true,
        primaryColor: Colors.white,
        focusColor: Colors.black,
        primaryColorDark: Colors.white,
        primaryColorLight: Colors.grey.shade900,
        splashColor: Colors.grey.shade900,
        scrollbarTheme: ScrollbarThemeData(
          // thumbVisibility: WidgetStatePropertyAll(true),
          // trackVisibility: WidgetStatePropertyAll(true),
          thumbColor: const WidgetStatePropertyAll(Colors.white),
          trackColor: WidgetStatePropertyAll(Colors.grey.shade800),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white
        ),
        radioTheme: const RadioThemeData(
            fillColor: WidgetStatePropertyAll(Colors.white)
        ),
        checkboxTheme: const CheckboxThemeData(
          side: BorderSide(color: Colors.white),
          checkColor: WidgetStatePropertyAll(Colors.white)
        ),
        cardTheme: CardThemeData(
          color: Colors.grey.withOpacity(0.5),
          surfaceTintColor: Colors.grey.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )
          // surfaceTintColor: Colors.white,
        ),
        dividerTheme: DividerThemeData(
            color: Colors.grey.shade300
        ),
        listTileTheme: ListTileThemeData(
          textColor: Colors.white,
          iconColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )
        ),
        dividerColor: Colors.grey,
        dialogBackgroundColor: Colors.grey.shade800,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  )
              ),
              backgroundColor: const WidgetStatePropertyAll(Colors.white),
              foregroundColor: const WidgetStatePropertyAll(Colors.black),
            )
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  )
              ),
              side: const WidgetStatePropertyAll(
                BorderSide(color: Colors.white, width: 2.0),
              ),
              foregroundColor: const WidgetStatePropertyAll(
                  Colors.white
              )
          ),

        ),
        textButtonTheme:  TextButtonThemeData(
          style: ButtonStyle(
              foregroundColor: const WidgetStatePropertyAll(
                  Colors.white
              ),
            shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                )
            ),
          ),

        ),

        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.deepPurple,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            surfaceTintColor: Colors.black,
            elevation: 0,
            titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp,),
            foregroundColor: Colors.white,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
            )
        ),

        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          prefixIconColor: Colors.white,
          suffixIconColor: Colors.white
        ),

        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
            decorationColor: Colors.white
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white
        ),
        progressIndicatorTheme:  ProgressIndicatorThemeData(
            color: Colors.white,
            refreshBackgroundColor: primaryColor
        ),
        cardColor: Colors.black,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade400,
        showUnselectedLabels: true,

      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.grey.shade900,
        surfaceTintColor: Colors.grey.shade900,
        shadowColor: Colors.grey,
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 18)
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: Colors.grey.shade900,
        surfaceTintColor: Colors.grey.shade900,
        headerHeadlineStyle: const TextStyle(color: Colors.white),
        headerHelpStyle: const TextStyle(color: Colors.white),
        dayStyle: const TextStyle(color: Colors.white),
        rangePickerHeaderHeadlineStyle: const TextStyle(color: Colors.white),
        rangePickerHeaderHelpStyle: const TextStyle(color: Colors.white),
        headerForegroundColor: Colors.white,
        rangePickerHeaderForegroundColor: Colors.white,
        rangeSelectionBackgroundColor: Colors.white,
        yearStyle: const TextStyle(color: Colors.white),
        weekdayStyle: const TextStyle(color: Colors.white),
        dayForegroundColor: const WidgetStatePropertyAll(Colors.white),
        yearForegroundColor: const WidgetStatePropertyAll(Colors.white),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)
          )
        )
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: Colors.grey.shade800,

      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: Colors.grey.shade800,
        modalBackgroundColor: Colors.grey.shade800,
      ),
      switchTheme: const SwitchThemeData(
        trackColor: WidgetStatePropertyAll(Colors.white)
      )
    );
  }
}