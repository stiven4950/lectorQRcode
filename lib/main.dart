import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:qr_reader/pages/home_page.dart';
import 'package:qr_reader/pages/map_page.dart';

import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UiProvider()),
        ChangeNotifierProvider(create: (_) => new ScanListProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Reader',
        initialRoute: 'home',
        routes: {
          HomePage.route: (_) => HomePage(),
          MapPage.route: (_) => MapPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}

// INSTALACIÓN DE BARCODES
/*
Para instalar correctamente en IOS se debe seguir una serie de pasos
con la ayuda de la terminal se configura el archivo xcWorkspace de la carpeta
de IOS y por úktimo se instala el POD mediante pod install, para más
información se mira en dart.dev

Para utilizar maps de google

Se debe entrar a la documentación de google_maps_flutter
Allí se debe ingresar a la consola de google cloud
De allí se entra a APIS y servicios donde se habilitan
los paquetes de mapas para Android e iOS

- Llenar pantalla de consentimiento
- 
 */