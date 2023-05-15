import 'package:flutter/material.dart';

class PlenusScreenLoader extends StatelessWidget {
  const PlenusScreenLoader({super.key});
  Stream<String> getAdvertit() {
    final advertit = <String>[
      "Cargando películas",
      "Comprando palomitas",
      "Acomodándonos en la butaca",
      "Pensando...",
      "Esto tardo más de lo esperado :("
    ];

    return Stream.periodic(const Duration(milliseconds: 1200), (step) {
      return advertit[step];
    }).take(advertit.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Espere por favor"),
        const SizedBox(
          height: 10,
        ),
        const CircularProgressIndicator(),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder(
            stream: getAdvertit(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Cargando");
              return Text(snapshot.data!);
            })
      ]),
    );
  }
}
