import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
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

        var totalPhotosCount = 0;
        List<DocumentSnapshot> productItems;

        if (snapShot.hasData) {
          productItems = snapShot.data!.docs;
          totalPhotosCount = productItems.length;

          if (totalPhotosCount > 0) {
            return SingleChildScrollView(
              child: GridView.count(
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(totalPhotosCount,
                      (index) =>
                          buildGridProduct(productItems, context, index),
                ),
              ),
            );

          }
        }
        return const Center(
          child: Text('nothing to show'),
        );
      },
    );
  }

  Widget buildGridProduct(List<DocumentSnapshot> data, BuildContext context, index) =>
      InkWell(

        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 1.0,
                color: Colors.grey[300],
              ),
              Image(
                image: NetworkImage(data[index]['image']),
                width: double.infinity,
                height: 200,
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  data[index]['title'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.3,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: (){},
      );
}

/*
  GridView.count(
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1,
                    childAspectRatio: 1 / 1.3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    children: List.generate(2,
                          (index) =>
                          buildGridProduct(data, context),
                    ),
                  ),
   */


/*
return ListView(
          children: snapShot.data!.docs.map((DocumentSnapshot document) {
            Map<String , dynamic> data = document.data()! as Map<String , dynamic>;
            return ListTile(
                title: Container(
                  color: Colors.grey[300],
                  child: buildGridProduct(data, context),
                ),
            );
          }).toList(),
        );
 */

// GridView.builder(
//
//
//     itemCount: totalPhotosCount,
//     scrollDirection: Axis.vertical,
//     shrinkWrap: true,
//     primary: false,
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2),
//     itemBuilder: (BuildContext context, int index) {
//       return buildGridProduct(tripPhotos, context, index);
//     });



// GridView.builder(
//
//
//     itemCount: totalPhotosCount,
//     scrollDirection: Axis.vertical,
//     shrinkWrap: true,
//     primary: false,
//     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2),
//     itemBuilder: (BuildContext context, int index) {
//       return buildGridProduct(tripPhotos, context, index);
//     });