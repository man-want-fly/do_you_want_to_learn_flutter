import 'package:flutter/material.dart';

class WidgetForm extends StatefulWidget {

  @override
  _WidgetFormState createState() => _WidgetFormState();
}

class _WidgetFormState extends State<WidgetForm> {

  final TextEditingController _payeeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  bool _isTransferButtonEnabled = false;
  TextSpan _summaryText = TextSpan();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16), 
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              controller: _payeeController,
              decoration: const InputDecoration(
                icon: Icon(Icons.sync_alt),
                hintText: '收款人',
                labelText: '转账给'
              ),
              keyboardType: TextInputType.name,
              validator: (text) {
                return (text?.length ?? 0) > 0 ? null : '收款人不能为空';
              },
              onChanged: (_) {
                _updateTransferButtonState();
              }
            ),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(
                icon: Icon(Icons.attach_money),
                hintText: '转账金额',
                labelText: '金额'
              ),
              keyboardType: TextInputType.number,
              validator: (text) {
                return (text?.length ?? 0) > 0 ? null : '金额不能为空';
              },
              onChanged: (_) {
                _updateTransferButtonState();
              }
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 44),
              child: TextButton(
                onPressed: _isTransferButtonEnabled ? _transfer : null, 
                style: TextButton.styleFrom(
                  primary: _isTransferButtonEnabled ? Colors.green : Colors.grey, 
                  // primary: Colors.green,
                  // onSurface: Colors.grey, 
                ),
                child: Row(children: [Text('转账')]),
              )
            ),
            Visibility(
              visible: _isTransferButtonEnabled,
              child: Row(children: [Text.rich(_summaryText)])
            )
          ]
        )
      )
    );
  }

  @override
  void dispose() {
    _payeeController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _updateTransferButtonState() {
    setState(() {
      _isTransferButtonEnabled = _payeeController.text.isNotEmpty && 
      _amountController.text.isNotEmpty;

      _summaryText = TextSpan(
        children: [
          TextSpan(text: '转账给 '),
          TextSpan(
            text: _payeeController.text,
            style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)
          ),
          TextSpan(text: '共计 '),
          TextSpan(
            text: _amountController.text,
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)
          ), 
          TextSpan(text: ' \$')
        ]
      );
    });
  }

  BuildContext? _dialogContext;

  void _transfer() {
    showDialog(
      context: context, 
      barrierColor: null,
      builder: (ctx) {
        _dialogContext = ctx;
        return Center(
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey, 
              borderRadius: BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), 
                  offset: Offset(0, 3), 
                  spreadRadius: 5, 
                  blurRadius: 7
                )
              ]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                width: 64, height: 64, 
                child: Center(child: CircularProgressIndicator())
                )
              ]
            )
          )
        );
      }
    );
    Future.delayed(Duration(seconds: 3), () {
      if (_dialogContext != null) {
        Navigator.pop(_dialogContext!);
        setState(() {
          _summaryText = TextSpan(
            children: [
              TextSpan(
                text: '转账成功',
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 32)
              )
            ]
          );
        });
      }
    });
  }
  // TODO: animate loading to success or failure
}