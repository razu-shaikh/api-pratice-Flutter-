import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Models/productModel.dart';
class LastExampleScreen extends StatefulWidget {
  const LastExampleScreen({Key? key}) : super(key: key);

  @override
  _LastExampleScreenState createState() => _LastExampleScreenState();
}

class _LastExampleScreenState extends State<LastExampleScreen> {



  Future<ProductModel> getProductsApi () async {

    final response = await http.get(Uri.parse('https://webhook.site/d654ab4b-5ae1-4e72-a5e8-752f1b30b7c7'));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      return ProductModel.fromJson(data);
    }else {
      return ProductModel.fromJson(data);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Api Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<ProductModel>(
                future: getProductsApi (),
                builder: (context , snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data!.data!.length,
                        itemBuilder: (context, index){
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(snapshot.data!.data![index].name.toString()),
                                subtitle: Text(snapshot.data!.data![index].shopemail.toString()),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot.data!.data![index].image.toString()),
                                ),
                              ),
                              Container(
                                height: 300.0,
                               /* height: MediaQuery.of(context).size.height *.3,
                                width: MediaQuery.of(context).size.width * 1,*/
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data!.data![index].products!.length,
                                    itemBuilder: (context, position){
                                      return Column(
                                        children:[
                                          Container(
                                            height: MediaQuery.of(context).size.height *.3,
                                            width: MediaQuery.of(context).size.width * 1,
                                            child: ListView.builder(
                                                scrollDirection: Axis.horizontal,
                                                itemCount: snapshot.data!.data![index].products![position].images!.length,
                                                itemBuilder: (context, index2){
                                                  return Padding(
                                                    padding: const EdgeInsets.only(right: 10.0),
                                                    child: Container(
                                                            height: MediaQuery.of(context).size.height *.25,
                                                            width: MediaQuery.of(context).size.width * .5,
                                                            //child:Text(snapshot.data!.data![index].products![position].images![index2].id.toString()),
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10),
                                                                color: Colors.greenAccent,
                                                                image: DecorationImage(
                                                                    fit: BoxFit.cover,
                                                                    image: NetworkImage(snapshot.data!.data![index].products![position].images![index2].url.toString())
                                                                )
                                                            ),
                                                          ),
                                                  );
                                                }),
                                          ),
                                          Icon(snapshot.data!.data![index].products![position].inWishlist! == false ? Icons.favorite : Icons.favorite_outline),
                                        ]

                                      );
                                    }),
                              ),
                            ],
                          );
                        });
                  }else {
                    return Text('Loading');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}