import 'package:flutter/material.dart';
import 'package:task_board/models/info_product.dart';
import 'package:task_board/services/info_product_services.dart';
import 'package:task_board/models/info_category.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final InfoProductServices _services = InfoProductServices();
  
  List<InfoProduct> _allProducts = []; // Lista completa
  List<InfoProduct> _filteredProducts = []; // Lista que se muestra
  List<InfoCategory> _categories = [];
  
  int? _selectedCategoryId; // ID de la categoría elegida
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // Cargamos productos y categorías al tiempo
  Future<void> _loadData() async {
    try {
      final results = await Future.wait([
        _services.getProducts(),
        _services.getCategories(),
      ]);

      setState(() {
        _allProducts = results[0] as List<InfoProduct>;
        _filteredProducts = _allProducts;
        _categories = results[1] as List<InfoCategory>;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  // Función para filtrar localmente
  void _filterProducts(int? categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
      if (categoryId == null) {
        _filteredProducts = _allProducts;
      } else {
        _filteredProducts = _allProducts
            .where((p) => p.category.id == categoryId)
            .toList();
      }
    });
  }

void _onCategoryChanged(int? categoryId) async {
  setState(() {
    _isLoading = true; // Mostramos el loader mientras llega la nueva data
    _selectedCategoryId = categoryId;
  });

  try {
    // Pedimos a la API los productos filtrados
    final filteredList = await _services.getProducts(categoryId: categoryId);
    
    setState(() {
      _filteredProducts = filteredList;
      _isLoading = false;
    });
  } catch (e) {
    setState(() => _isLoading = false);
    // Mostrar un snackbar de error si gustas
  }
}
  // Dentro de tu _ProductScreenState

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Tienda Platzi'),
      actions: [
        // Botón para resetear filtro rápidamente
        IconButton(
          icon: const Icon(Icons.filter_alt_off),
          onPressed: () => _filterProducts(null),
        )
      ],
    ),
    body: _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Column(
            children: [
              // --- DROPDOWN DE CATEGORÍAS ---
              Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  child: DropdownButtonFormField<int?>(
    isExpanded: true, // Asegura que el texto largo no desborde
    decoration: InputDecoration(
      labelText: 'Categoría',
      prefixIcon: const Icon(Icons.category_outlined), // Icono decorativo
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: Colors.grey[50], // Un fondo sutil para que resalte
    ),
    value: _selectedCategoryId,
    items: [
      const DropdownMenuItem(
        value: null,
        child: Text('Todas las categorías'),
      ),
      ..._categories.map((cat) {
        return DropdownMenuItem(
          value: cat.id,
          child: Text(cat.name),
        );
      }).toList(),
    ],
    // Llamamos a la nueva función asíncrona que definimos antes
    onChanged: (int? newValue) {
      _onCategoryChanged(newValue); 
    },
  ),
),

              // --- LISTA DE PRODUCTOS ---
              Expanded(
                child: _filteredProducts.isEmpty
                    ? const Center(child: Text('No hay productos aquí'))
                    : ListView.builder(
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = _filteredProducts[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  product.images[0],
                                  width: 50,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                                ),
                              ),
                              title: Text(product.title),
                              subtitle: Text('\$${product.price} - ${product.category.name}'),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
  );
}
  
}