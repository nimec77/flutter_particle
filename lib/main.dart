import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_particle/pages/particle_designer.dart';
import 'package:spritewidget/spritewidget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ParticleApp());
}

class ParticleApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ParticlePage(title: 'Particle Designer'),
    );
  }
}

class ParticlePage extends StatefulWidget {
  final String title;

  const ParticlePage({Key key, @required this.title})
      : assert(title != null),
        super(key: key);

  @override
  _ParticlePageState createState() => _ParticlePageState();
}

class _ParticlePageState extends State<ParticlePage> {
  ImageMap _images;
  Future<void> _future;

  @override
  void initState() {
    super.initState();

    _images = ImageMap(rootBundle);
    _future = _images.load([
      'assets/particle-0.png',
      'assets/particle-1.png',
      'assets/particle-2.png',
      'assets/particle-3.png',
      'assets/particle-4.png',
      'assets/particle-5.png',
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            body: ParticleDesigner(size: size, images: _images),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
