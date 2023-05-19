import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream <String> getLoadingMessages() {
    final messages = <String>[
    'Loading movies...',
    'Cooking popcorns...',
    'Laiding on bed...',
    'Getting confy...',
    'Waiting TOO much...',
    'This is not working...'
  ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step){
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Waiting'),
          const SizedBox(height: 10,),
          const CircularProgressIndicator(strokeWidth: 2,),

          StreamBuilder(
            stream: getLoadingMessages(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('loading...');

              return Text(snapshot.data!);
            },
          )
        ],
      ),
    );
  }
}