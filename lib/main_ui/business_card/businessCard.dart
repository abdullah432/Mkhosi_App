import 'package:flutter/material.dart';
import 'package:makhosi_app/utils/app_colors.dart';

class BusinessCard extends StatefulWidget {
  @override
  _BusinessCardState createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.COLOR_PRIMARY,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        child: Column(
          children: [
            sizeBox(50),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back,color: Colors.white,)),
                )),
            sizeBox(20),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal:20.0),
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      child: Padding(
                        padding: EdgeInsets.only(top: 50.0),
                        child: Container(
                          // height: 500,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        sizeBox(14),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Container(
                                height: 40,
                                width: width * .3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.REQUEST_UPPER_O,
                                ),
                                child: Center(
                                  child: Text('Edit Business Information',style: TextStyle(
                                    color: AppColors.BUSINESS_TEXT1,fontWeight: FontWeight.w600,fontSize: 9,
                                  ),),
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: 140,
                                  width: 140,
                                  decoration: BoxDecoration(
                                    boxShadow: [BoxShadow(
                                        color: Colors.black87,
                                        blurRadius: 0.1
                                    )],
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(30.0),
                                    child: Image.asset('images/administration_images/avatar.png'),
                                  ),
                                ),
                                Positioned(
                                    bottom: 10,
                                    right: 5,
                                    child: Image.asset('images/administration_images/check.png',height: 22,))
                              ],
                            ),
                          ],
                        ),
                        sizeBox(10),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Center(
                                child: Text('Gogo Thembi Ndlovu',style: TextStyle(
                                  color: AppColors.BUSINESS_TEXT2,fontWeight: FontWeight.w600,fontSize: 18,
                                ),),
                              ),
                              Center(
                                child: Text('Centurion, South Africa 0081',style: TextStyle(
                                  color: AppColors.BUSINESS_TEXT3,fontWeight: FontWeight.w400,fontSize: 11,
                                ),),
                              ),
                              sizeBox(10),
                              Center(
                                child: Text('● Available Now',style: TextStyle(
                                  color: AppColors.BUSINESS_TEXT1,fontWeight: FontWeight.w600,fontSize: 13,
                                ),),
                              ),
                              sizeBox(5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.star,color:AppColors.BUSINESS_STAR1,),
                                  Icon(Icons.star,color:AppColors.BUSINESS_STAR1,),
                                  Icon(Icons.star,color:AppColors.BUSINESS_STAR1,),
                                  Icon(Icons.star,color:AppColors.BUSINESS_STAR1,),
                                  Icon(Icons.star,color:AppColors.BUSINESS_STAR2,),
                                ],
                              ),
                              sizeBox(5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('images/administration_images/insta.png'),
                                  sizeBoxW(30),
                                  Image.asset('images/administration_images/linkedIn.png'),
                                  sizeBoxW(30),
                                  Image.asset('images/administration_images/whatsApp.png'),
                                  sizeBoxW(30),
                                  Image.asset('images/administration_images/facebook.png'),
                                ],
                              ),
                              sizeBox(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('Years of Service',style: TextStyle(
                                    color: AppColors.BUSINESS_TEXT4,fontWeight: FontWeight.w400,fontSize: 11,
                                  ),),
                                  Text('Languages',style: TextStyle(
                                    color: AppColors.BUSINESS_TEXT4,fontWeight: FontWeight.w400,fontSize: 11,
                                  ),),
                                  Text('Service',style: TextStyle(
                                    color: AppColors.BUSINESS_TEXT4,fontWeight: FontWeight.w400,fontSize: 11,
                                  ),),
                                ],
                              ),
                              sizeBox(30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text('4 years',style: TextStyle(
                                    color: AppColors.BUSINESS_TEXT2,fontWeight: FontWeight.w500,fontSize: 11,
                                  ),),
                                  Text('Zulu, English',style: TextStyle(
                                    color: AppColors.BUSINESS_TEXT2,fontWeight: FontWeight.w500,fontSize: 11,
                                  ),),
                                  Text('Traditional Healer',style: TextStyle(
                                    color: AppColors.BUSINESS_TEXT2,fontWeight: FontWeight.w500,fontSize: 11,
                                  ),),
                                ],
                              ),
                              sizeBox(40),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Divider(
                                  thickness: 1,
                                ),
                              ),
                              sizeBox(20),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Text('About',style: TextStyle(
                                    color: AppColors.BUSINESS_TEXT2,fontWeight: FontWeight.w500,fontSize: 14,
                                  ),),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Text('Thembi Ndlovu is an acreditated Herbalist, with over 5 years experience.  Currently based in Gauteng Province, ',style: TextStyle(
                                    color: AppColors.BUSINESS_TEXT3,fontWeight: FontWeight.w400,fontSize: 10,
                                  ),),
                                ),
                              ),
                              sizeBox(10),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Text('Business Rules',style: TextStyle(
                                    color: AppColors.BUSINESS_TEXT2,fontWeight: FontWeight.w500,fontSize: 14,
                                  ),),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Text('Thembi Ndlovu is an acreditated Herbalist, with over 5 years experience.  Currently based in Gauteng Province, ',style: TextStyle(
                                    color: AppColors.BUSINESS_TEXT3,fontWeight: FontWeight.w400,fontSize: 10,
                                  ),),
                                ),
                              ),
                              sizeBox(10),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Text('Hours',style: TextStyle(
                                    color: AppColors.BUSINESS_TEXT2,fontWeight: FontWeight.w500,fontSize: 14,
                                  ),),
                                ),
                              ),
                              hourRow('●   Monday to Thursday', '07:00am : 10:00pm'),
                              sizeBox(10),
                              hourRow('●   Friday', '08:30am : 05:00pm'),
                              sizeBox(10),
                              hourRow('●   Saturday and Sunday', '08:00am : 08:00pm'),
                              sizeBox(40),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: width * .2),
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: AppColors.COLOR_PRIMARY
                                  ),
                                  child: Center(
                                    child:Text('Send Business Card',style: TextStyle(
                                        color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                  ),
                                ),
                              ),
                              sizeBox(20)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget sizeBox(double height){
    return SizedBox(
      height: height,
    );
  }
  Widget sizeBoxW(double width){
    return SizedBox(
      width: width,
    );
  }
  Widget align(){
    return Align(
      alignment: Alignment.topLeft,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
    ),
    );
  }

  Widget hourRow(String text1, String text2){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text1,style: TextStyle(
            color: AppColors.BUSINESS_TEXT3,fontWeight: FontWeight.w400,fontSize: 10,
          ),),
          Text(text2,style: TextStyle(
            color: AppColors.BUSINESS_TEXT3,fontWeight: FontWeight.w400,fontSize: 10,
          ),),
        ],
      ),
    );
  }
}
