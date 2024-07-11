import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa_16/cubits/theme/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Sozlamalar',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListTile(
              title: Text('Theme color'),
              leading: Icon(Icons.color_lens),
              trailing: BlocBuilder<ThemeCubit, bool>(
                builder: (context, isDarkMode) {
                  return IconButton(
                    icon: Icon(isDarkMode ? Icons.dark_mode : Icons.light_mode),
                    onPressed: () {
                      context.read<ThemeCubit>().toggleTheme();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.blue, Colors.purple.shade500],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/productScreen');
              },
              icon: Icon(
                Icons.home,
                size: 25,
                color: Colors.white,
              ),
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {},
              icon: Icon(
                Icons.person_2_outlined,
                size: 25,
                color: Colors.white,
              ),
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/favoriteScreen');
              },
              icon: Icon(
                Icons.favorite_outline,
                size: 25,
                color: Colors.white,
              ),
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                // Navigator.pushReplacementNamed(context, '/settingsScreen');
              },
              icon: Icon(
                Icons.settings,
                size: 25,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
