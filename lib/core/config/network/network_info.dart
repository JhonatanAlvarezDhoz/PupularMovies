// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class ConnectivityExample extends StatefulWidget {
//   @override
//   _ConnectivityExampleState createState() => _ConnectivityExampleState();
// }

// class _ConnectivityExampleState extends State<ConnectivityExample> {
//   ConnectivityResult _connectionStatus = ConnectivityResult.none;
//   final Connectivity _connectivity = Connectivity();
//   late StreamSubscription<ConnectivityResult> _connectivitySubscription;

//   @override
//   void initState() {
//     super.initState();
//     // Inicializar estado de conexión
//     _initConnectivity();

//     Escuchar cambios en la conectividad
//     _connectivitySubscription = 
//       _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }

//   // Inicializar estado de conectividad
//   Future<void> _initConnectivity() async {
//     late ConnectivityResult result;
//     try {
//       result = await _connectivity.checkConnectivity();
//     } catch (e) {
//       print('No se pudo verificar la conectividad: $e');
//       return;
//     }

//     // Si el widget ya no está en el árbol, no actualizar
//     if (!mounted) return;

//     // Actualizar estado de conexión
//     setState(() {
//       _connectionStatus = result;
//     });
//   }

//   // Actualizar estado de conexión
//   Future<void> _updateConnectionStatus(ConnectivityResult result) async {
//     setState(() {
//       _connectionStatus = result;
//     });
//   }

//   // Método para obtener texto descriptivo del estado
//   String _getConnectionStatusText() {
//     switch (_connectionStatus) {
//       case ConnectivityResult.wifi:
//         return 'Conectado a WiFi';
//       case ConnectivityResult.mobile:
//         return 'Conectado a Datos Móviles';
//       case ConnectivityResult.ethernet:
//         return 'Conectado por Ethernet';
//       case ConnectivityResult.bluetooth:
//         return 'Conectado por Bluetooth';
//       case ConnectivityResult.none:
//         return 'Sin Conexión';
//       case ConnectivityResult.other:
//         return 'Otro tipo de conexión';
//     }
//   }

//   // Método para verificar si hay conexión a internet
//   Future<bool> _checkInternetConnection() async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } on SocketException catch (_) {
//       return false;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Estado de Conexión')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Mostrar estado de conexión
//             Text(
//               _getConnectionStatusText(),
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: _connectionStatus == ConnectivityResult.none 
//                   ? Colors.red 
//                   : Colors.green,
//               ),
//             ),
//             SizedBox(height: 20),
            
//             // Botón para verificar conexión a internet
//             ElevatedButton(
//               onPressed: () async {
//                 bool hasInternet = await _checkInternetConnection();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(
//                       hasInternet 
//                         ? 'Conexión a Internet disponible' 
//                         : 'Sin conexión a Internet',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     backgroundColor: hasInternet ? Colors.green : Colors.red,
//                   ),
//                 );
//               },
//               child: Text('Verificar Conexión a Internet'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Cancelar suscripción para evitar memory leaks
//     _connectivitySubscription.cancel();
//     super.dispose();
//   }
// }

// import 'package:connectivity_plus/connectivity_plus.dart';

// abstract class NetworkInfo {
//   Future<bool> get isConnected;
// }

// class NetworkInfoImpl implements NetworkInfo {
//   final Connectivity connectivity;

//   NetworkInfoImpl(this.connectivity);

//   @override
//   Future<bool> get isConnected async {
//     final connectivityResult = await connectivity.checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }

//   // Método para obtener tipo de conexión
//   Future<ConnectivityResult> get connectionType async {
//     return await connectivity.checkConnectivity();
//   }

//   // Stream para escuchar cambios de conectividad
//   Stream<ConnectivityResult> get onConnectivityChanged {
//     return connectivity.onConnectivityChanged;
//   }
// }