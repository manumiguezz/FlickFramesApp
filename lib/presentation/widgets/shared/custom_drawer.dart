import '../../providers/theme/theme_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer(
        builder: (context, ref, _) {
          final themeProvider = ref.watch(themeProviderNotifier);
          final textStyles = Theme.of(context).textTheme;
          final colors = Theme.of(context).colorScheme;

          return _CustomListView(
            textStyles: textStyles, 
            colors: colors, 
            themeProvider: themeProvider,
            context: context,
            );
        },
      ),
    );
  }
}

class _CustomListView extends StatelessWidget {
  const _CustomListView({
    required this.textStyles,
    required this.colors,
    required this.themeProvider, 
    required this.context,
  });

  final TextTheme textStyles;
  final ColorScheme colors;
  final ThemeProvider themeProvider;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
          ),
          child: Text(
            'Adjustment',
            style: textStyles.titleLarge,
            ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [

              const Icon(Icons.nights_stay_outlined),

              const SizedBox(width: 10,),
        
              Text('Dark Mode',
              style: textStyles.titleMedium,
              ),

              const SizedBox(width: 110,),
        
              Transform.scale(
                scale: 0.9,
                child: CupertinoSwitch(
                  activeColor: colors.primary,
                  value: themeProvider.isDarkMode,
                  onChanged: (value) {
                    themeProvider.toggleTheme();
                  },
                ),
              ),
        
            ],
          ),
        ),

        const Divider(),

        Padding(
          padding: const EdgeInsets.all(8),
          child: GestureDetector(
            onTap: () {
              showLicensePage(
                context: context,
                applicationIcon: Image.network('https://1001freedownloads.s3.amazonaws.com/vector/thumb/74145/iOS_7_Icon_Template.png'),
                applicationLegalese: '© 2023 FlickFrames. All rights reserved.',
                applicationName: 'FlickFrames',
                applicationVersion: '0.5.8'
              );
            },
            child: Row(
              children: [
          
                const Icon(Icons.library_books_sharp),
          
                const SizedBox(width: 10),
          
                Text('Licenses',
                style: textStyles.titleMedium,
                ),
          
                const SizedBox(width: 110),
          
              ],
            ),
          ),
        )
        


      ],
    );
  }
}