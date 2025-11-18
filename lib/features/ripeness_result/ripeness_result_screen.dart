

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RipenessResultScreen extends StatelessWidget {
  final bool isRipe;
  final String fruitName;

  const RipenessResultScreen({
    super.key,
    required this.isRipe,
    required this.fruitName,
  });

  @override
  Widget build(BuildContext context) {
    
    final Color backgroundColor = isRipe ? const Color(0xFF4CAF50) : const Color.fromARGB(255, 243, 64, 44);
    final IconData icon = isRipe ? Icons.sentiment_very_satisfied_outlined : Icons.sentiment_very_dissatisfied_outlined;
    final String title = isRipe ? "Perfectly Ripe!" : "Not Ripe Yet";
    final String subTitle = isRipe ? "Ready to enjoy." : "This fruit needs a little more time to become sweet and juicy.";

    
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false, // Remove the default 'back' arrow
        actions: [
          Visibility(
            visible: !isRipe, // not ripe fruit
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 40),
              onPressed: () {
                Navigator.of(context).pop(); // This is close screen
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        // Keep the phone away from the top's content
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Makes buttons fill the width
            children: [
              // --TOP PART (ICON & TEXT) --
              const Spacer(flex: 1), // Push the content down
              Icon(icon, color: Colors.white, size: 100),
              const SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                // FIX: Removed space after 'plusJakartaSans'
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                subTitle,
                textAlign: TextAlign.center,
                // FIX: Removed space after 'plusJakartaSans'
                style: GoogleFonts.plusJakartaSans(
                  color: Colors.white, 
                  fontSize: 14,
                ),
              ),
              const Spacer(),

              // -- MIDDLE PART --
              // appear only if the fruit is RIPE
              Visibility(
                visible: isRipe,
                // We pass the fruitName to our helper method
                child: _buildFruitChip(fruitName),
              ),

              const Spacer(flex: 2),

              // -- BOTTOM PART(BUTTONS) --
              ElevatedButton(
                onPressed: () {/* TODO: Navigate to Scan Screen*/},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  fixedSize: const Size(150, 50),
                  foregroundColor: backgroundColor, // This is a great trick!
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Scan Another Fruit',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 12),

              // Show "View details" ONLY if ripe
              Visibility(
                visible: isRipe,
                child: TextButton(
                  onPressed: () {/*TODO: Show details */},
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: Colors.white, width: 1),
                    ),
                  ),
                  child: const Text(
                    "View Details",
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // Show "View Tips" ONLY if NOT RIPE
              Visibility(
                visible: !isRipe,
                child: TextButton(
                  onPressed: () {/*TODO: show tips*/},
                  child: const Text(
                    "View Tips & Tricks",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // This is a helper method
  // It now takes the fruit's name as a parameter
  Widget _buildFruitChip(String name) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.2), // Semi-transparent white
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          // FIX: Removed 'const' because 'Text(name)' is not const
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name, // Use the 'name' parameter
                  // FIX: Removed space after 'plusJakartaSans'
                  style: GoogleFonts.plusJakartaSans(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Analyzed just now',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
          // Placeholder for the avocado image in a circle
          // FIX: Removed 'const' because the parent Row is not const
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: Icon(Icons.food_bank_rounded, color: Colors.green), // depend on the fruit name ---
          ),
        ],
      ),
    );
  }
}