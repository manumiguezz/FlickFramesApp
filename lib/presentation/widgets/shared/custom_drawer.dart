import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/theme/theme_provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer(
        builder: (context, ref, _) {
          final themeProvider = ref.watch(themeProviderNotifier);
          final textStyles = Theme.of(context).textTheme;
          final colors = Theme.of(context).colorScheme;

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
              
                    CupertinoSwitch(
                      activeColor: colors.primary,
                      value: themeProvider.isDarkMode,
                      onChanged: (value) {
                        themeProvider.toggleTheme();
                      },
                    ),
              
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}