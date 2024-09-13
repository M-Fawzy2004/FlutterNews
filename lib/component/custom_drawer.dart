import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';
import 'custom_drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          // icon header
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: LottieBuilder.asset(
              'assets/Animation - 1725719063093.json',
              reverse: true,
              height: 150,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25),
            child: Divider(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          // icon Home
          CustomDrawerTile(
            onTap: () {
              Navigator.pop(context);
            },
            text: 'Home',
            icon: Icons.home,
          ),

          // icon Brightness
          CustomDrawerTile(
            onTap: () {
              Provider.of<ThemeAppProvider>(context, listen: false)
                  .toggleTheme();
              Navigator.pop(context);
            },
            text: 'Dark Mode',
            icon: Provider.of<ThemeAppProvider>(context).isDarkMode
                ? Icons.brightness_7
                : Icons.brightness_4,
          ),

          // icon language
          CustomDrawerTile(
            onTap: () {},
            text: 'Language',
            icon: Icons.language,
          ),

          // icon language
          CustomDrawerTile(
            onTap: () {},
            text: 'Privacy ',
            icon: Icons.privacy_tip,
          ),

          // icon language
          CustomDrawerTile(
            onTap: () {},
            text: 'About US',
            icon: Icons.info_outline,
          ),
        ],
      ),
    );
  }
}
