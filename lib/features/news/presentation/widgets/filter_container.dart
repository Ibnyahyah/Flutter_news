import 'package:flutter/material.dart';

import 'custom_button.dart';

class FilterContainer extends StatelessWidget {
  const FilterContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 1.2,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Column(
        children: [
          const Text(
            "Filter News",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          _singleFilter(
            keyText: 'Country',
            valueText: 'Nigeria',
          ),
          _singleFilter(
            keyText: 'Category',
            valueText: 'General',
          ),
          _singleFilter(
            keyText: 'Content',
            valueText: 'Everything',
          ),
          const Spacer(),
          CustomButton(
              text: 'Cancel',
              onPressed: () {
                Navigator.of(context).pop();
              }),
          const SizedBox(height: 15),
          CustomButton(
            text: 'Continue',
            outlined: true,
            onPressed: () {},
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _singleFilter({
    required String keyText,
    required String valueText,
    Function()? onTap,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$keyText:",
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Text(valueText),
                const Icon(Icons.arrow_drop_down, size: 22),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
