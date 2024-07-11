import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../utils/ColorPath.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [

          IconButton(onPressed: (){
            Navigator.pop(context);
          },
          // Get.back(), 
          icon: const Icon(CupertinoIcons.clear)
          )
        ],
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            ///image


            ///title and sub title
            Text("Password Reset Email Send" ,style: Theme.of(context).textTheme.headlineSmall, textAlign: TextAlign.center,),
            const SizedBox(height: 20,),
            Text('basitmurad@gmail.com' ,style: Theme.of(context).textTheme.labelLarge, textAlign: TextAlign.center,),
            const SizedBox(height: 20,),
            Text("Your Account Security is our Priority \n Change Your password and \n Keep your Account Protected"  ,style: Theme.of(context).textTheme.labelMedium, textAlign: TextAlign.center,),

            const SizedBox(height: 30,),


            Container(
              width: double.infinity,
              height: 40,
              decoration: const BoxDecoration(),
              child: ElevatedButton(
                  onPressed:  (){},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colorpath.cardColor,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(16))),
                  child:  Text(
                    "Submit",
                    style: TextStyle(color: Colors.white),
                  )),
            ),

            const SizedBox(height: 20,),

            SizedBox(
              width: double.infinity,
              child: TextButton(onPressed: (){}, child: const Text("Resend Email"  ,style: TextStyle(color: Colorpath.cardColor),),),
            ),

          ],),
        ),
      ),

    );
  }

}
