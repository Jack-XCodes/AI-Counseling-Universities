import 'dart:async';
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  final ApiService _apiService = ApiService();
  bool _isLoading = true;
  bool _isError = false;
  String _statusMessage = "Initializing...";

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );
    
    _controller.forward();
    _checkBackendStatus();
  }

  Future<void> _checkBackendStatus() async {
    setState(() {
      _statusMessage = "Connecting to Rafiki AI...";
    });
    
    try {
      final isHealthy = await _apiService.checkHealth();
      
      if (isHealthy) {
        setState(() {
          _statusMessage = "Connection successful! Loading your profile...";
        });
        
        // Wait a moment for animation
        await Future.delayed(Duration(seconds: 2));
        
        // Navigate to chat screen
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => ChatScreen())
          );
        }
      } else {
        setState(() {
          _isError = true;
          _isLoading = false;
          _statusMessage = "Unable to connect to Rafiki AI. Please check your connection.";
        });
      }
    } catch (e) {
      setState(() {
        _isError = true;
        _isLoading = false;
        _statusMessage = "Error connecting to AI server.";
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              RafikiTheme.primaryColor,
              Color(0xFF7E57C2), // Lighter purple
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App logo with animation
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "R",
                      style: TextStyle(
                        color: RafikiTheme.primaryColor,
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 40),
              
              AnimatedOpacity(
                opacity: _controller.value,
                duration: Duration(milliseconds: 500),
                child: Column(
                  children: [
                    Text(
                      "Rafiki AI",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    
                    SizedBox(height: 10),
                    
                    Text(
                      "Your personal AI guide for university life",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 50),
              
              if (_isLoading) ...[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  _statusMessage,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ],
              
              if (_isError) ...[
                Icon(
                  Icons.error_outline,
                  color: Colors.red.shade300,
                  size: 60,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    _statusMessage,
                    style: TextStyle(color: Colors.white, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                      _isError = false;
                    });
                    _checkBackendStatus();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: RafikiTheme.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  ),
                  child: Text("Retry Connection"),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
