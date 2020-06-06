import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentageTotal;

  ChartBar(this.label, this.spendingAmount, this.spendingPercentageTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Container(
            height: 20,
            child: FittedBox(
              child: Text('\$${spendingAmount.toStringAsFixed(0)}', style: TextStyle(color: Theme.of(context).accentColor),)
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 60,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentageTotal,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(label, style: TextStyle(color: Theme.of(context).accentColor),)
        ],
    );
  }
}
