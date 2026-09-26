import 'package:flutter/material.dart';
import '../models/category_model.dart';

class CategoryGrid extends StatelessWidget {
  final List<CategoryModel> categories; 

  const CategoryGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3.0,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF282828),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Icon(category.icon, color: Colors.white), 
              const SizedBox(width: 12),
              Text(
                category.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}