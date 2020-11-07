import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trooper_hackout/Screens/NavDrawer.dart';
import 'package:trooper_hackout/Screens/sellerInfo.dart';
import 'package:trooper_hackout/resources/color.dart';
import 'package:trooper_hackout/widgets/app_bar.dart';
import 'package:trooper_hackout/widgets/customButton.dart';
import 'package:trooper_hackout/widgets/custom_text.dart';
import 'package:trooper_hackout/widgets/textField.dart';

class BuyScreen extends StatefulWidget {
  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {

  bool clickedSearch = false;

  final searchedText = TextEditingController();


  getStream() {
    Stream stream =  Firestore.instance.collection("Sell").orderBy("timeStamp",descending: true).snapshots();

    return stream;
  }

  //listcard widget
  Widget ListCard({dynamic commodityName,
    dynamic sellerName, dynamic price,
    dynamic quantity, dynamic location,
    dynamic btnOnClick}){
    return Column(
      children: [
        Card(
          child :  Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    CustomText(
                      fontFamily: 'sf_pro_bold',
                      text: "Commodity : ",
                    ),
                    CustomText(
                      fontFamily: 'sf_pro_regular',
                      text : commodityName,
                    )
                  ],
                ),

                SizedBox(height: 3,),

                Row(
                  children: [
                    CustomText(
                      fontFamily: 'sf_pro_bold',
                      text: "Seller Name : ",
                      fontSize: 14.0,
                    ),
                    CustomText(
                      fontFamily: 'sf_pro_regular',
                      text : sellerName,
                      fontSize: 14.0,
                    )
                  ],
                ),

                SizedBox(height: 3,),

                Row(
                  children: [
                    CustomText(
                      fontFamily: 'sf_pro_bold',
                      text: "Price : ",
                      fontSize: 14.0,
                    ),
                    CustomText(
                      fontFamily: 'sf_pro_regular',
                      text : price,
                      fontSize: 14.0,
                    )
                  ],
                ),

                SizedBox(height: 3,),

                Row(
                  children: [
                    CustomText(
                      fontFamily: 'sf_pro_bold',
                      text: "Quantity : ",
                      fontSize: 14.0,
                    ),
                    CustomText(
                      fontFamily: 'sf_pro_regular',
                      text : quantity,
                      fontSize: 14.0,
                    )
                  ],
                ),
                SizedBox(height: 3,),

                Container(
                  child: Row(
                    children: [
                      Flexible(
                        child: CustomText(
                          fontFamily: 'sf_pro_bold',
                          text: "Location : ",
                          fontSize: 14.0,
                        ),
                      ),
                      Flexible(
                        child: CustomText(
                          fontFamily: 'sf_pro_regular',
                          text : location,
                          fontSize: 14.0,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 3,),

                CustomButton(
                  label: "View",
                  onPressed: (){
                    btnOnClick();
                  },
                  color: secondary,
                  labelColor: white,
                )

              ],
            ),

          ),
        ),

        SizedBox(height: 20,)
      ],
    );
  }
  //listcard widget

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
     appBar: AppBar(
       title: clickedSearch == false ?  Text("What do you want to buy") :
       CustomTextField(
         label : "Search",
         controller: searchedText,
       ),
       centerTitle: true,
       actions: [
         IconButton(
           icon: Icon(Icons.search),
           onPressed: (){
             setState(() {
               clickedSearch = !clickedSearch;
             });
           },

         )
       ],
     ),

     body: Container(
       padding: EdgeInsets.all(10),
       child: StreamBuilder(
         stream: getStream(),
         builder: (context, snapshots) {
           return snapshots.hasData ? ListView.builder(
             itemCount: snapshots.data.documents.length,
             itemBuilder: (context,index){
               DocumentSnapshot doc = snapshots.data.documents[index];
               return doc['itemName'] == searchedText.text.toLowerCase() && searchedText.text.isNotEmpty ?
               ListCard(
                   commodityName: doc['itemName'],
                   sellerName: doc['name'],
                   price : doc['price'],
                   location: doc['address'],
                   quantity: doc['quantity'],
                   btnOnClick: (){

                     Navigator.push(context, MaterialPageRoute(
                       builder: (context) => SellerInfo(
                         sellerId: doc['userId'],
                         quantity: doc['quantity'],
                         itemName: doc['itemName'],
                         sellerName: doc['name'],
                         address: doc['address'],
                         district: doc['district'],
                         state: doc['state'],
                         photo: doc['photo'],
                         price: doc['price'],
                       ),
                     ));
                   }
               )  : searchedText.text.isEmpty ? ListCard(
                 commodityName: doc['itemName'],
                 sellerName: doc['name'],
                 price : doc['price'],
                 location: doc['address'],
                 quantity: doc['quantity'],
                 btnOnClick: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => SellerInfo(
                          sellerId: doc['userId'],
                          quantity: doc['quantity'],
                          itemName: doc['itemName'],
                          sellerName: doc['name'],
                          address: doc['address'],
                          district: doc['district'],
                          state: doc['state'],
                          photo: doc['photo'],
                          price: doc['price'],
                        ),
                    ));
                 }
               ) :Container();
             }
           ) : Container();
         }
       )
     ),

    );
  }
}
