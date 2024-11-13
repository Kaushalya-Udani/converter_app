import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../utils/app_constants.dart';
import '../../../core/dependency_injection.dart';
import '../../../utils/colors.dart';
import '../../domain/data/datasources/shared_preference.dart';
import 'home_cubit/home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = injection.call<HomeCubit>();
  final appSharedData = injection.call<AppSharedData>();
  List<String> favoriteList = [];
  List<String> currencyList = [];


  double insertAmount = 0.00;
  double selectedKey = 0.00;
  List<double> totalAmount = [];
  String selectedType = "";

  final TextEditingController _controller = TextEditingController();
  String _selectedCurrency = 'USD';


  @override
  void initState() {
    currencyList.addAll(AppConstants.currencyList!.keys);
    totalAmount.clear();
    if (appSharedData.hasData(savedCurrencies)) {
      List<dynamic> jsonResponse = jsonDecode(appSharedData.getData(savedCurrencies));
      favoriteList = jsonResponse.map((item) => item as String).toList();
      if (favoriteList.isNotEmpty) {
        for (var x in favoriteList) {
          totalAmount.add(0.00);
        }
      }
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorPrimary,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: InkWell(
            splashFactory: NoSplash.splashFactory,
            splashColor: Colors.transparent,
            onTap: () {},
            child: Icon(
              Icons.arrow_back_rounded,
              color: AppColors.fontColorWhite,
              size: 22.sp,
            ),
          ),
          title: Text(
            "Advanced Exchanger",
            style: TextStyle(
              color: AppColors.fontColorWhite,
              fontSize: 18.sp,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => _bloc,
          child: BlocListener<HomeCubit, HomeState>(
            listener: (context, state) {
              if (state is HomeSuccessState) {
                setState(() {
                  AppConstants.currencyList = state.currenciesResponse!.data;
                });
                List.generate(favoriteList.length, (index) {
                  AppConstants.currencyList!.forEach((key, value) {
                    if (favoriteList[index] == key) {
                      setState(() {
                        totalAmount[index] = value * insertAmount;
                      });
                    }
                  });
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0, top: 24.0,bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "INSERT AMOUNT:",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.colorSecondary,
                              borderRadius: BorderRadius.circular(4.w),
                            ),
                            padding: const EdgeInsets.only(right: 10),
                            child: TextFormField(
                              controller: _controller,
                              enabled: true,
                              keyboardType: const TextInputType.numberWithOptions(decimal: true),
                              style: TextStyle(color: AppColors.fontColorWhite, fontSize: 18.sp),
                              onChanged: (value) {
                                setState(() {
                                  insertAmount = double.parse(value);
                                  List.generate(favoriteList.length, (index) {
                                    AppConstants.currencyList!.forEach((key, value) {
                                      if (favoriteList[index] == key) {
                                        setState(() {
                                          totalAmount[index] = value * insertAmount;
                                        });
                                      }
                                    });
                                  });
                                });
                              },
                              decoration: InputDecoration(
                                hintText: '0.00',
                                contentPadding: const EdgeInsets.all(18),
                                hintStyle: TextStyle(color: AppColors.fontColorWhite, fontSize: 18.sp),
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                suffixIcon: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: _selectedCurrency,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      size: 20.sp,
                                    ),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedType = newValue!;
                                        _selectedCurrency = newValue;
                                      });
                                      _bloc.getCurrencyConvertData(type: newValue);
                                    },
                                    items: AppConstants.currencyList!.keys.map<DropdownMenuItem<String>>((String key) {
                                      return DropdownMenuItem<String>(
                                        value: key,
                                        child: Container(
                                         // color: Colors.greenAccent,
                                          child: Center(child: Text(key,style: TextStyle(color: AppColors.colorBlack),)),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                      
                          SizedBox(
                            height: 3.h,
                          ),
                      
                          Text(
                            "CONVERT TO:",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: favoriteList.length,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child:Container(
                                decoration: BoxDecoration(
                                  color: AppColors.colorSecondary,
                                  borderRadius: BorderRadius.circular(4.w),
                                ),
                                padding: const EdgeInsets.only(
                                  right: 10,
                                  left: 15,
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      (totalAmount[index].toStringAsFixed(2)).toString(),
                                      style: TextStyle(
                                        color: AppColors.fontColorWhite,
                                        fontSize: 18.sp,
                                      ),
                                    ),
                                    DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: favoriteList[index],
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          size: 20.sp,
                                        ),
                                        onChanged: (String? newValue) {
                                          AppConstants.currencyList!.entries.any((element) {
                                            if (element.key == newValue) {
                                              setState(() {
                                                favoriteList[index] = newValue!;
                                                selectedKey = element.value;
                                                totalAmount[index] = (selectedKey * insertAmount);
                                              });
                                              return true;
                                            }
                                            return false;
                                          });
                                        },
                                        items: AppConstants.currencyList!.keys.map<DropdownMenuItem<String>>((String key) {
                                          return DropdownMenuItem<String>(
                                            value: key,
                                            child: Text(key),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 2.h),
                        ],
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        splashFactory: NoSplash.splashFactory,
                        splashColor: Colors.transparent,
                        onTap: () {
                          _showSelectedBottomSheet(context);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.buttonColorGreen.withOpacity(0.30),
                            borderRadius: BorderRadius.circular(
                              10.dp,
                            ),
                          ),
                          padding: EdgeInsets.all(2.5.w),
                          child: const Text(
                            "+ ADD CONVERTER",
                            style: TextStyle(color: AppColors.textColorGreen),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  void _showSelectedBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: AppColors.fontColorGray,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, innerSetState) => Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(22.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "FAVORITE CURRENCIES",
                        style: TextStyle(
                          color: AppColors.fontColorWhite,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        width: 100.w - 44,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: List.generate(
                              growable: true,
                              favoriteList.length,
                                  (index) => InkWell(
                                splashFactory: NoSplash.splashFactory,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  innerSetState(() {
                                    currencyList.add(favoriteList[index]);
                                    setState(() {
                                      favoriteList.removeAt(index);
                                      totalAmount.removeAt(index);
                                    });
                                  });
                                  appSharedData.clearData(savedCurrencies);
                                  if (favoriteList.isNotEmpty) {
                                    appSharedData.setData(savedCurrencies, jsonEncode(favoriteList));
                                  }
                                  setState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.colorPrimary,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        favoriteList[index],
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Icon(
                                        Icons.cancel_rounded,
                                        color: AppColors.removeColorRed,
                                        size: 3.w,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      Text(
                        "ADD CURRENCIES",
                        style: TextStyle(
                          color: AppColors.fontColorWhite,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        width: 100.w - 44,
                        child: Wrap(
                          // gap between adjacent items
                          runSpacing: 4.0,
                          children: List.generate(
                            currencyList.length,
                                (index) {
                              return !favoriteList.contains(currencyList[index])
                                  ? InkWell(
                                splashFactory: NoSplash.splashFactory,
                                splashColor: Colors.transparent,
                                onTap: () {
                                  innerSetState(() {
                                    favoriteList.add(currencyList[index]);
                                    AppConstants.currencyList!.forEach((key, value) {
                                      if (key == currencyList[index]) {
                                        setState(() {
                                          totalAmount.add(insertAmount * value);
                                        });
                                      }
                                    });
                                    currencyList.removeAt(index);
                                  });
                                  if (appSharedData.hasData(savedCurrencies)) {
                                    appSharedData.clearData(savedCurrencies);
                                    appSharedData.setData(savedCurrencies, jsonEncode(favoriteList));
                                  } else {
                                    appSharedData.setData(savedCurrencies, jsonEncode(favoriteList));
                                  }
                                  setState(() {});
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: AppColors.colorPrimary,
                                  ),
                                  margin: const EdgeInsets.only(right: 8),
                                  padding: const EdgeInsets.all(10),
                                  child: Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.center,
                                    children: [
                                      Text(
                                        currencyList[index],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                                  : const SizedBox.shrink();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
