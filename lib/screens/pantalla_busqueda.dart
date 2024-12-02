import 'package:examen2_eduardoflores/modules/busqueda/domain/dto/dto.dart';
import 'package:examen2_eduardoflores/modules/busqueda/domain/repository/repository.dart';
import 'package:examen2_eduardoflores/modules/busqueda/useCase/usecase.dart';
import 'package:examen2_eduardoflores/screens/pantalla_navigator.dart';
import 'package:examen2_eduardoflores/screens/pantallas_detalle.dart';
import 'package:flutter/material.dart';


class PantallaBusqueda extends StatefulWidget {
  const PantallaBusqueda({Key? key}) : super(key: key);
  
  @override
  _PantallaBusquedaState createState() => _PantallaBusquedaState();
}

class _PantallaBusquedaState extends State<PantallaBusqueda> {
  final TextEditingController controladorBusqieda = TextEditingController();
  late BusquedaUseCase fetchBusquedaUseCase= BusquedaUseCase(BusquedaRepository());
  late Future<List<BusquedaDTO>> busquedaFuture = fetchBusquedaUseCase.execute("");

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BarraNavegadora(title: 'Buscar'), //barra de navegacion
      
      //otro future list
      body:
      Column(children: [
        //barra de busqueda
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controladorBusqieda,
              decoration: InputDecoration(
                hintText: 'Buscar productos...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (controladorBusqieda.text.isNotEmpty) {
                      setState(() {
                        //el set state actualiza la pantalla, y lo actualizamos llamando otra vez a la API con la busqueda
                        busquedaFuture = fetchBusquedaUseCase.execute(controladorBusqieda.text);
                      });
                    }
                  }
                ),
              ),
            ),
          ),

          //lista de productos encontrados
        FutureBuilder<List<BusquedaDTO>>(
  future: busquedaFuture,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else {
      if (snapshot.hasError) {
        return Center(child: Text('Error al cargar los productos: ${snapshot.error}'));
      }
      return Expanded( // Moved Expanded here
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 0.7,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final product = snapshot.data![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PantallasDetalle(productId: product.id),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                          child: Image.network(
                            product.thumbnail,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              product.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Detalles',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  },
),
      ],
      
      
      
      )
      
    );
  }
}
