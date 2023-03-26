import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_language_fonts/google_language_fonts.dart';

import 'Searchscreen.dart';

class SchemesPage extends StatefulWidget {
   SchemesPage({super.key,required this.lang});
String lang;
  @override
  State<SchemesPage> createState() => _SchemesPageState();
}

class _SchemesPageState extends State<SchemesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Schemes"),),body: Column(children: [
      Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 50,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      //set border radius more than 50% of height and width to make circle
                    ),
                    child: Column(children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: widget.lang == "English"
                                ? Text(
                                    "schems",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    "योजना",
                                    style: DevanagariFonts.hind(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          )
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Text(
                                              widget.lang == 'English'
                                                  ? "Detail"
                                                  : "तपशीलवार माहिती",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.lang == 'English'
                                                    ? "Paramparagat Krishi Vikas Yojana (PKVY) is being implemented with a view to promote organic farming in the country.  This will improve soil health and organic matter content and increase net income of the farmer so as to realise premium prices. Under this scheme, an area of 5 lakh acre is targeted to be covered though 10,000 clusters of 50 acre each, from the year 2015-16 to 2017-18. So far 7208 clusters have been formed and remaining  clusters would be formed during 2017-18."
                                                    : "देशात सेंद्रिय शेतीला चालना देण्याच्या उद्देशाने परमपरागत कृषी विकास योजना (PKVY) राबविण्यात येत आहे. यामुळे मातीचे आरोग्य आणि सेंद्रिय पदार्थांचे प्रमाण सुधारेल आणि शेतकऱ्याचे निव्वळ उत्पन्न वाढेल जेणेकरुन प्रिमियम किमती मिळतील. या योजनेंतर्गत, 2015-16 ते 2017-18 या कालावधीत प्रत्येकी 50 एकरच्या 10,000 क्लस्टर्समध्ये 5 लाख एकर क्षेत्र समाविष्ट करण्याचे उद्दिष्ट आहे. आतापर्यंत 7208 क्लस्टर्स तयार करण्यात आले असून उर्वरित क्लस्टर्स 2017-18 मध्ये तयार केले जातील.",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Search(
                                                                url:
                                                                    'https://dmsouthwest.delhi.gov.in/hi/scheme/%E0%A4%AA%E0%A4%B0%E0%A4%82%E0%A4%AA%E0%A4%B0%E0%A4%BE%E0%A4%B5%E0%A4%BE%E0%A4%A6-%E0%A4%95%E0%A5%83%E0%A4%B7%E0%A4%BF-%E0%A4%B5%E0%A4%BF%E0%A4%95%E0%A4%BE%E0%A4%B8-%E0%A4%AF%E0%A5%8B%E0%A4%9C/',
                                                              )));
                                                },
                                                child: Text("More Info"))
                                          ],
                                        );
                                      });
                                },
                                child: Card(
                                    child: Text(widget.lang == 'English'
                                        ? " Paramparagat Krishi Vikas Yojana  (PKVY)"
                                        : "पारंपारिक कृषी विकास योजना")),
                              )
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 25,
                                            ),
                                            Text(
                                              widget.lang == 'English'
                                                  ? "Detail"
                                                  : "तपशीलवार माहिती",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                widget.lang == 'English'
                                                    ? "Launched in 2015, the scheme has been introduced to assist State Governments to issue Soil Health Cards to all farmers in the country.  The Soil Health Cards provide information to farmers on nutrient status of their soil alongwith recommendation on appropriate dosage of nutrients to be applied for improving soil health and its fertility. As on 11.7.2017, against target of 253 lakh soil samples, all 253 lakh soil samples have been collected and 245 lakh (97%) samples have been tested.  Against target of 12 crore Soil Health Cards, so far 9 crore (76%) cards have been distributed to farmers."
                                                    : "2015 मध्ये सुरू करण्यात आलेली, ही योजना देशातील सर्व शेतकऱ्यांना मृदा आरोग्य कार्ड जारी करण्यासाठी राज्य सरकारांना मदत करण्यासाठी सुरू करण्यात आली आहे. मृदा आरोग्य कार्ड्स शेतकऱ्यांना त्यांच्या मातीच्या पोषक स्थितीबद्दल माहिती देतात आणि जमिनीचे आरोग्य आणि त्याची सुपीकता सुधारण्यासाठी पोषक तत्वांच्या योग्य डोसची शिफारस करतात. 11.7.2017 पर्यंत, 253 लाख माती नमुन्यांचे उद्दिष्ट असताना, सर्व 253 लाख मातीचे नमुने गोळा केले गेले आहेत आणि 245 लाख (97%) नमुने तपासण्यात आले आहेत. 12 कोटी मृदा आरोग्य कार्डांच्या उद्दिष्टासमोर आतापर्यंत 9 कोटी (76%) कार्ड शेतकऱ्यांना वितरित करण्यात आले आहेत.",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Search(
                                                              url:
                                                                  'https://soilhealth.dac.gov.in/home',
                                                            )));
                                              },
                                              child: Text(
                                                  widget.lang == 'English'
                                                      ? "More Info"
                                                      : "अधिक माहिती"),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      child: Text(widget.lang == 'English'
                                          ? " Soil Health Card Scheme"
                                          : "मृदा आरोग्य कार्ड योजना")),
                                ),
                              )
                            ],
                          )),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 25,
                                              ),
                                              Text(
                                                widget.lang == 'English'
                                                    ? "Detail"
                                                    : "तपशीलवार माहिती",
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SingleChildScrollView(
                                                  child: Text(
                                                    widget.lang == 'English'
                                                        ? "Pradhan Mantri Fasal Bima Yojana (PMFBY) & Restructured Weather Based Crop Insurance Scheme (RWBCIS) were launched from Kharif 2016 to provide comprehensive crop insurance coverage from pre-sowing to post harvest losses against non-preventable natural risks.  These schemes are only risk mitigation tools available to farmers at extremely low premium rates payable by farmers at 2% for Kharif crops, 1.5% for Rabi Crop and 5% for annual commercial/horticultural crops.  The balance of actuarial premium is shared by the Central and State Governments on 50 : 50 basis.  The schemes are voluntary for States and available in areas and crops that are notified by the State Governments.    Further, the schemes are compulsory for loanee farmers and voluntary for non-loanee farmers. During Kharif 2016 season, a total of 23 States implemented both PMFBY (21) and RWBCS (12) and during Rabi 2016-17, 24 States and 3 Union Territories implemented PMFBY (25) and RWBCIS (9).    Overall coverage of both the schemes is 401.52 lakh farmers and 385 lakh ha. area insured for a sum of Rs. 133106 crore in Kharif 2016 and 172.67 lakh farmers and 195 lakh ha. area insured for a sum of Rs. 71696 crore during Rabi 2016-17 season."
                                                        : "प्रधानमंत्री फसल विमा योजना (PMFBY) आणि पुनर्रचित हवामान आधारित पीक विमा योजना (RWBCIS) खरीप 2016 पासून सुरू करण्यात आली होती ज्यामुळे पेरणीपूर्वीपासून कापणीनंतरच्या नुकसानीपर्यंत सर्वसमावेशक पीक विमा संरक्षण मिळू शकत नाही. खरीप पिकांसाठी 2%, रब्बी पिकांसाठी 1.5% आणि वार्षिक व्यावसायिक/ बागायती पिकांसाठी 5% दराने शेतकऱ्यांना देय असलेल्या अत्यंत कमी प्रीमियम दरात शेतकऱ्यांना या योजना केवळ जोखीम कमी करणारी साधने उपलब्ध आहेत. एक्चुरियल प्रीमियमची शिल्लक केंद्र आणि राज्य सरकार 50 : 50 च्या आधारावर सामायिक करतात. योजना राज्यांसाठी ऐच्छिक आहेत आणि राज्य सरकारांद्वारे अधिसूचित केलेल्या क्षेत्रांमध्ये आणि पिकांमध्ये उपलब्ध आहेत. पुढे, योजना कर्जदार शेतकऱ्यांसाठी अनिवार्य आणि बिगर कर्जदार शेतकऱ्यांसाठी ऐच्छिक आहेत. खरीप 2016 हंगामात, एकूण 23 राज्यांनी PMFBY (21) आणि RWBCS (12) आणि रब्बी 2016-17 दरम्यान, 24 राज्ये आणि 3 केंद्रशासित प्रदेशांनी PMFBY (25) आणि RWBCIS (9) लागू केले. दोन्ही योजनांची एकूण व्याप्ती ४०१.५२ लाख शेतकरी आणि ३८५ लाख हेक्टर आहे. क्षेत्राचा विमा रु. खरीप 2016 मध्ये 133106 कोटी आणि 172.67 लाख शेतकरी आणि 195 लाख हे. क्षेत्राचा विमा रु. रब्बी 2016-17 हंगामात 71696 कोटी.",
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Search(
                                                                      url:
                                                                          'https://pmfby.gov.in/',
                                                                    )));
                                                  },
                                                  child: Text(
                                                      widget.lang == 'English'
                                                          ? "More Info"
                                                          : "अधिक माहिती"))
                                            ],
                                          ),
                                        );
                                      });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                      child: Text(
                                          " Pradhan Mantri Fasal Bima Yojana")),
                                ),
                              )
                            ],
                          ))
                    ]),
                  ),
                ),
    ]),);
  }
}