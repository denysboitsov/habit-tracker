import 'package:flutter/material.dart';
import 'package:habit_tracker/widgets/habit_tracker.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  databaseFactory = databaseFactoryFfi;
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'SFPro',
        primaryColorLight: Colors.blue,
        primaryColorDark: Colors.black,
        primaryColor: Color.fromARGB(255, 31, 31, 31),
        splashFactory: NoSplash.splashFactory,
        iconButtonTheme: IconButtonThemeData(
          style: ElevatedButton.styleFrom(
            splashFactory: NoSplash.splashFactory,
          ),
        ),
        dialogTheme: const DialogTheme(
          backgroundColor: Color.fromARGB(255, 31, 31, 31),
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: Color.fromARGB(255, 31, 31, 31),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            side: BorderSide(
              width: 1,
              //color: Color.fromARGB(255, 53, 53, 53),
            ),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.blue,
          unselectedItemColor: Color.fromARGB(255, 134, 134, 134),
          //backgroundColor: Colors.black,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent.withAlpha(100),
          titleTextStyle: const TextStyle(
            color: Color.fromARGB(255, 232, 232, 232),
            fontSize: 24,
            //fontWeight: FontWeight.bold,
          ),
          actionsIconTheme: const IconThemeData(
              size: 24, color: Color.fromARGB(255, 232, 232, 232)),
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: const TextTheme(
            bodySmall: TextStyle(
              fontFamily: 'SFPro',
              fontSize: 10,
              color: Color.fromARGB(255, 232, 232, 232),
            ),
            bodyMedium: TextStyle(
              fontFamily: 'SFPro',
              fontSize: 16,
              color: Color.fromARGB(255, 232, 232, 232),
            ),
            titleMedium: TextStyle(
              fontFamily: 'SFPro',
              fontSize: 20,
              color: Color.fromARGB(255, 232, 232, 232),
              fontWeight: FontWeight.bold,
            ),
            titleLarge: TextStyle(
              fontFamily: 'SFPro',
              fontSize: 24,
              color: Color.fromARGB(255, 232, 232, 232),
              fontWeight: FontWeight.bold,
            ),
            labelMedium: TextStyle(
              fontFamily: 'SFPro',
              fontSize: 16,
              color: Colors.blue,
            )),
        datePickerTheme: const DatePickerThemeData(
          //yearBackgroundColor: MaterialStatePropertyAll<Color>(Colors.white),
          yearOverlayColor: MaterialStatePropertyAll<Color>(Colors.white),
          yearStyle: TextStyle(
            color: Colors.white,
          ),
          weekdayStyle: TextStyle(
            color: Colors.white,
          ),
          yearForegroundColor: MaterialStatePropertyAll<Color>(Colors.white),
          headerForegroundColor: Colors.white,
          dividerColor: Colors.transparent,
          dayForegroundColor: MaterialStatePropertyAll<Color>(Colors.white),
          todayBackgroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
          todayBorder: BorderSide(
            width: 0,
            //color: Color.fromARGB(255, 53, 53, 53),
          ),
          backgroundColor: Color.fromARGB(255, 31, 31, 31),
          cancelButtonStyle: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
          ),
          confirmButtonStyle: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll<Color>(Colors.blue),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
            side: BorderSide(
              width: 1,
              //color: Color.fromARGB(255, 53, 53, 53),
            ),
          ),
        ),
      ),
      home: HabitTracker(),
    ),
  );
}
