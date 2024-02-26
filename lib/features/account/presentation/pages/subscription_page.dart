import 'package:flutter/material.dart';
import 'package:snipit/core/constants/app_colors.dart';
import 'package:snipit/core/constants/app_data.dart';
import 'package:snipit/core/constants/app_text_styles.dart';
import 'package:snipit/core/utils/custom_spacers.dart';
import 'package:snipit/route/app_pages.dart';
import 'package:snipit/route/custom_navigator.dart';
import 'package:snipit/ui/molecules/custom_button.dart';

import '../../../../ui/molecules/custom_scaffold.dart';

class SubscriptionPage extends StatefulWidget {
  const SubscriptionPage({super.key});

  @override
  State<SubscriptionPage> createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  SubscriptionPlan? _selectedPlan;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 30,
                        height: 35 / 30,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF262626),
                        fontFamily: AppFontFamily.maisonNeue,
                      ),
                      children: [
                        TextSpan(text: 'Select '),
                        TextSpan(
                            text: 'subscription type ',
                            style: TextStyle(fontWeight: FontWeight.w600)),
                        TextSpan(text: 'or continue with free trial'),
                      ],
                    ),
                  ),
                  CustomSpacers.height20,
                  Text(
                    'Lorem ipsum dolor sit amet consectetur. Eget quis sagittis feugiat viverra vestibulum eget aliquet. Ultricies sagittis proin in aenean.',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF262626),
                      fontFamily: AppFontFamily.maisonNeue,
                    ),
                  ),
                  CustomSpacers.height60,
                  ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: AppData.subscriptionPlans.length,
                    itemBuilder: (context, index) {
                      final plan = AppData.subscriptionPlans[index];

                      return _buildPlanAmountCard(
                        subscription: plan,
                        isSelected: _isSelected(plan),
                        onTap: (){
                          setState(() {
                            _selectedPlan = plan;
                          });
                        },
                      );
                    },
                    separatorBuilder: (context, index) => CustomSpacers.height15,
                  ),
                  SizedBox(height: 100),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 10,
            child: CustomButton(
              strButtonText: _selectedPlan==null? 'Continue with free trial' : 'Subscribe',
              buttonAction: _submitForm,
              textStyle: AppTextStyles.textStyles_MN_30_600_black
                  .copyWith(fontSize: 16, fontWeight: FontWeight.w700),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPlanAmountCard({
    required SubscriptionPlan subscription,
    required bool isSelected,
    required VoidCallback onTap,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          decoration: ShapeDecoration(
            shape: StadiumBorder(
              side: BorderSide(
                color: isSelected ? AppColors.primary : Color(0xFF3C3C435C),
                width: isSelected ? 2 : 1,
              ),
            ),
            color: Colors.transparent,
          ),
          padding: EdgeInsets.all(18),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: '£${subscription.amount.toStringAsFixed(2)} per month\n',
                      style: TextStyle(
                        fontSize: 16,
                        height: 24 / 16,
                        fontWeight: FontWeight.w300,
                        color: Color(0xFF262626),
                        overflow: TextOverflow.ellipsis,
                        fontFamily: AppFontFamily.maisonNeue,
                      )),
                  TextSpan(
                      text: subscription.description,
                      style: TextStyle(
                        fontSize: 12,
                        height: 20 / 12,
                        fontWeight: FontWeight.w200,
                        color: Color(0xFF262626),
                        overflow: TextOverflow.ellipsis,
                        fontFamily: AppFontFamily.maisonNeue,
                      )),
                ]),
                textAlign: TextAlign.center,
              ),
              if (subscription.isBest)
              Positioned(
                right: 10,
                top: 0,
                bottom: 0,
                child: CircleAvatar(
                  minRadius: 10,
                  maxRadius: 10,
                  backgroundColor: AppColors.primary,
                  child: Icon(
                    Icons.star,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  bool _isSelected(SubscriptionPlan subscriptionPlan) {
    return _selectedPlan !=null && _selectedPlan!.id == subscriptionPlan.id;
  }

  Future<void> _submitForm() async {
    if(_selectedPlan==null) {
      CustomNavigator.pushTo(context, AppPages.loading);
      return;
    }
  }
}
