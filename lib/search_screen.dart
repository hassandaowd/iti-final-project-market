import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var formKey = GlobalKey<FormState>();

  var searchController = TextEditingController();

  bool isSearching = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value!.isEmpty) return 'enter text for search';
                  return null;
                },
                onFieldSubmitted: (value) {
                  setState(() {
                    isSearching = false;
                  });
                  const Duration(milliseconds: 10,);
                  setState(() {
                    isSearching = true;
                  });
                },
                decoration: const InputDecoration(
                  label: Text('Search'),
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ConditionalBuilder(
                condition: isSearching,
                builder: (context) => Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 40),
                            child: Text(
                              'There is nothing to show',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                      ),
                fallback: (context) => const LinearProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
