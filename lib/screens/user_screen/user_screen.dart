import 'package:flutter/material.dart';
import 'package:task_board/models/auth_model.dart';
import 'package:task_board/screens/products/product_screen.dart';
import 'package:task_board/services/auth_service.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // Controladores para capturar el texto
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  bool _isObscure = true; // Para ocultar/mostrar la contraseña
void _handleLogin() async {
  if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Por favor llena todos los campos')),
    );
    return;
  }

  setState(() => _isLoading = true);

  bool success = await _authService.login(
    _emailController.text.trim(),
    _passwordController.text.trim(),
  );

  setState(() => _isLoading = false);

  if (success) {
    // 2. NAVEGACIÓN EXITOSA
    if (!mounted) return; // Buena práctica: verificar que el widget siga activo
    
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ProductScreen()),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Error: Credenciales inválidas'),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Iniciar Sesión')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.lock_outline, size: 80, color: Colors.blue),
            const SizedBox(height: 30),
            
            // Campo de Email
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            
            // Campo de Contraseña
            TextField(
              controller: _passwordController,
              obscureText: _isObscure,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
                  onPressed: () => setState(() => _isObscure = !_isObscure),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            
            // Botón de Ingreso
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _handleLogin,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: _isLoading 
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text('INGRESAR', style: TextStyle(fontSize: 16)),
              ),
            ),
            
            TextButton(
              onPressed: () {
                // Aquí podrías navegar a la pantalla de registro
              },
              child: const Text('¿No tienes cuenta? Regístrate aquí'),
            )
          ],
        ),
      ),
    );
  }
}