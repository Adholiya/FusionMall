import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [
    {"user": "bot", "text": "Welcome to FusionMall, How may I help you?"}
  ];
  int _currentStep = 1;
  final mobileKeywords = [
    "mobile",
    "smartphone",
    "smart phone",
    "cellphone",
    "cell phone"
  ];
  final fridgeKeywords = [
    "fridge",
    "refrigerator",
    "icebox",
    "chiller",
    "freezer"
  ];
  String _selectedCategory = "";
  String _selectedPurpose = "";
  double? _selectedTonnage;
  int? _selectedCapacity;
  int? _budget;
  Timer? _loadingTimer;

  void _sendMessage(String userInput) async {
    if (userInput.trim().isEmpty) return;

    // Add user's message
    setState(() {
      _messages.insert(0, {"user": "user", "text": userInput});
    });

    _controller.clear();

    // Show the loading indicator with animation
    _showLoadingAnimation();

    // Simulate delay
    await Future.delayed(const Duration(seconds: 3));

    // Stop the loading animation and fetch actual response
    _stopLoadingAnimation();

    // Handle chatbot response
    String response;
    if (_currentStep == 1) {
      if (mobileKeywords
          .any((keyword) => userInput.toLowerCase().contains(keyword))) {
        _selectedCategory = "mobile";
        response =
            "What is your purpose? i.e., Gaming, Photography, Regular Use.";
        _currentStep++;
      } else if (userInput.toLowerCase().contains("air conditioner") ||
          userInput.toLowerCase().contains("ac")) {
        _selectedCategory = "air conditioner";
        response = "What is the tonnage you need? e.g., 1.0, 1.5, or 2.0.";
        _currentStep = 3; // Skip purpose step for ACs
      } else if (fridgeKeywords.any((keyword) => userInput.toLowerCase().contains(keyword)) ) {
        _selectedCategory = "refrigerator";
        response = "What capacity do you need? 200L, 300L, 500L?";
        _currentStep = 5; // Skip budget step for refrigerator
      } else {
        response =
            "I can help you find mobile phones, air conditioners, refrigerators. Please specify.";
        _currentStep == 1;
      }
    } else if (_currentStep == 2 && _selectedCategory == "mobile") {
      _selectedPurpose = userInput.toLowerCase();
      response =
          "What is your budget?, I have Mobiles under 20000, 25000 and 35000, Please enter your budget (Enter among the present Budget)";
      _currentStep++;
    } else if (_currentStep == 3 && _selectedCategory == "mobile") {
      final budgetMatch = RegExp(r'\d+').firstMatch(userInput);
      if (budgetMatch != null) {
        _budget = int.parse(budgetMatch.group(0)!);

        // Fetch filtered mobile phones
        final filteredProducts = await _fetchFilteredProducts();
        if (filteredProducts.isNotEmpty) {
          response =
              "Here are some available mobile phones as per your requirements: ${filteredProducts.join(' ')}";
        } else {
          response =
              "Sorry, currently we have no mobile phones match your requirements \n\n Please try different purpose and budget variations";
        }
      } else {
        response =
            "Please specify your budget as a number, e.g., 'Under 30000.'";
      }
      _currentStep = 1; // Reset the flow
    } else if (_currentStep == 3 && _selectedCategory == "air conditioner") {
      final tonnageMatch = RegExp(r'\d+(\.\d+)?').firstMatch(userInput);
      if (tonnageMatch != null) {
        _selectedTonnage = double.parse(tonnageMatch.group(0)!);

        // Directly fetch filtered air conditioners based on the tonnage
        final filteredProducts = await _fetchFilteredProducts();
        if (filteredProducts.isNotEmpty) {
          response =
              "Here are some available air conditioners based on your tonnage ($userInput): ${filteredProducts.join(', ')}.\n\nHow may I help you?";
        } else {
          response =
              "Sorry, no air conditioners match your requirements for tonnage $userInput.\n\nHow may I help you?";
        }
        _currentStep = 1; // Reset the flow after showing the results
      } else {
        response = "Please specify the tonnage, e.g., 1.0, 1.5, or 2.0.";
      }
    } else if (_currentStep == 5 && _selectedCategory == "refrigerator") {
      final capacityMatch = RegExp(r'\d+').firstMatch(userInput);
      if (capacityMatch != null) {
        _selectedCapacity = int.parse(capacityMatch.group(0)!);
        // Fetch refrigerators based on capacity
        final filteredProducts = await _fetchFilteredProducts();
        if (filteredProducts.isNotEmpty) {
          response =
              "Here are some refrigerators as per your needs: ${filteredProducts.join(' ')}";
        } else {
          response =
              "Sorry, no refrigerators match your requirements. Please try different capacity variations.";
        }
      } else {
        response = "Please specify the capacity, e.g., 200, 300, 500.";
      }
      _currentStep = 1; // Reset the flow
    } else {
      response = "I'm sorry, I didn't understand that.";
      _currentStep = 1;
    }

    // Add chatbot's response
    setState(() {
      _messages.insert(0, {"user": "bot", "text": response});
    });
  }

  Future<List<String>> _fetchFilteredProducts() async {
    final jsonString = await rootBundle.loadString('assets/products.json');
    final Map<String, dynamic> data = json.decode(jsonString);
    final products = List<Map<String, dynamic>>.from(data['products']);

    if (_selectedCategory == "mobile") {
      // Filter products based on category and purpose
      final filteredProducts = products
          .where((product) =>
              product['category'] == "mobile" &&
              product['purpose'].contains(_selectedPurpose))
          .toList();

      // Group products by price in descending order
      final groupedByBudget = filteredProducts
          .where((product) => product['price'] <= _budget!)
          .toList()
        ..sort((a, b) => b['price'].compareTo(a['price'])); // Sort descending

      return groupedByBudget
          .map((product) => product['name'] as String)
          .toList();
    } else if (_selectedCategory == "air conditioner") {
      // Filter products based only on tonnage for air conditioners
      final filteredProducts = products
          .where((product) =>
              product['category'] == "air conditioner" &&
              product['tonnage'] == _selectedTonnage)
          .toList();

      // No budget filtering for air conditioners
      return filteredProducts
          .map((product) => product['name'] as String)
          .toList();
    } else if (_selectedCategory == "refrigerator") {
      // Filter products based on capacity
      final filteredProducts = products
          .where((product) => product['category'] == "refrigerator")
          .toList();

      // Sort products by capacity in descending order
      filteredProducts.sort((a, b) {
        double capacityA = double.tryParse(a['capacity'].toString()) ?? 0;
        double capacityB = double.tryParse(b['capacity'].toString()) ?? 0;
        return capacityB.compareTo(capacityA); // Sort descending
      });

      // Now, filter by the selected capacity and lower capacities
      final filteredByCapacity = filteredProducts.where((product) {
        // Ensure product['capacity'] is a number (double)
        double productCapacity =
            double.tryParse(product['capacity'].toString()) ?? 0;
        // Ensure _selectedCapacity is treated as a double
        double selectedCapacity = _selectedCapacity?.toDouble() ?? 0.0;
        return productCapacity <= selectedCapacity;
      }).toList();

      return filteredByCapacity
          .map((product) => product['name'] as String)
          .toList();
    }

    return [];
  }

  void _showLoadingAnimation() {
    setState(() {
      _messages.insert(0, {"user": "bot", "text": "Loading..."});
    });

    _loadingTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        // Safely find the first bot message
        final botMessageIndex = _messages.indexWhere(
          (message) => message["user"] == "bot",
        );

        if (botMessageIndex != -1) {
          // Update the existing bot message text
          _messages[botMessageIndex]["text"] =
              "Loading${'.' * ((DateTime.now().millisecondsSinceEpoch ~/ 500) % 3 + 1)}";
        }
      });
    });
  }

  void _stopLoadingAnimation() {
    _loadingTimer?.cancel();
    _loadingTimer = null;

    setState(() {
      // Remove the loading message if it exists
      _messages.removeWhere((message) =>
          message["user"] == "bot" &&
          message["text"]?.startsWith("Loading") == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat with FusionMall"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          // Chat messages list
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message["user"] == "user";

                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft:
                            isUser ? const Radius.circular(12) : Radius.zero,
                        bottomRight:
                            isUser ? Radius.zero : const Radius.circular(12),
                      ),
                    ),
                    child: Text(
                      message["text"]!,
                      style: TextStyle(
                        color: isUser ? Colors.black : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Input field with send button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  offset: const Offset(0, -1),
                  blurRadius: 3,
                ),
              ],
            ),
            child: Row(
              children: [
                // Text input field
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: TextStyle(color: Colors.black, fontSize: 16), // Set text color to black
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    ),
                  ),
                ),

                // Send button
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.black),
                  onPressed: () => _sendMessage(_controller.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
