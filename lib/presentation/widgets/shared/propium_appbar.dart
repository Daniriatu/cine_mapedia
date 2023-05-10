import 'package:flutter/material.dart';

class PropriumAppbar extends StatelessWidget {
  const PropriumAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorum = Theme.of(context).colorScheme;
    final titulusStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(Icons.movie_outlined, color: colorum.primary),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  "Cinemapedia",
                  style: titulusStyle,
                ),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.search))
              ],
            ),
          ),
        ));
  }
}
