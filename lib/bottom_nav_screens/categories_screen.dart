
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:iti_final_project/shared/constants.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('categories').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
        if (snapShot.hasError) {
          return const Center(
            child: Text(
              'Error on Connection',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
          );
        }
        if (snapShot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        
        return ListView(
          children: snapShot.data!.docs.map((DocumentSnapshot document) {
            Map<String , dynamic> data = document.data()! as Map<String , dynamic>;
            return ListTile(
              title: InkWell(
                child: Column(
                  children: [
                    Row(
                      children: [
                        ImageNetwork(
                          image: data['image'],
                          height: 120,
                          width: 150,
                          fitAndroidIos: BoxFit.cover,
                          fitWeb: BoxFitWeb.cover,
                          onLoading: const CircularProgressIndicator(
                            color: defaultColor,
                          ),
                          onError: const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          data['title'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                    const SizedBox(height: 5,),
                    Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                onTap: (){},
              )
            );
          }).toList(),
        );
      },
    );
  }
}
