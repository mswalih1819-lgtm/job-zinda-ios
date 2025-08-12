import 'package:flutter/material.dart';
import '../../../services/wallet_service.dart';
import 'package:jora_customer/Settings/until/PColors.dart';
import '../../../model/wallet_transaction_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jora_customer/model/logged_in_user.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  double walletBalance = 0;
  List<WalletTransaction> transactions = [];
  List<WalletTransaction> withdrawals = [];
  String upiId = '';
  String userId = '';
  bool loading = true;
  bool withdrawalLoading = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('id') ?? LoggedInUser.id ?? '';
    await _fetchWallet();
  }

  Future<void> _fetchWallet() async {
    setState(() => loading = true);
    final ws = WalletService();
    walletBalance = await ws.getWalletBalance(userId);
    transactions = await ws.getWalletTransactions(userId, limit: 5);
    withdrawals = (await ws.getWithdrawalRequests(userId)).where((t) => t.source == 'withdrawal').toList();
    setState(() => loading = false);
  }

  Future<void> _requestWithdrawal() async {
    final ws = WalletService();
    TextEditingController upiController = TextEditingController(text: upiId);
    double amount = walletBalance;
    bool confirmed = false;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Request Withdrawal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enter your UPI ID to receive payment:'),
            TextField(
              controller: upiController,
              decoration: InputDecoration(labelText: 'UPI ID'),
            ),
            SizedBox(height: 12),
            Text('Amount: ₹${amount.toStringAsFixed(2)}'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text('Cancel')),
          ElevatedButton(onPressed: () { confirmed = true; Navigator.pop(ctx); }, child: Text('Request')),
        ],
      ),
    );
    if (confirmed && upiController.text.isNotEmpty) {
      setState(() => withdrawalLoading = true);
      try {
        bool ok = await ws.requestWithdrawal(userId, amount, upiController.text);
        if (ok) {
          upiId = upiController.text;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Withdrawal requested successfully.')));
          await _fetchWallet();
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed: ${e.toString()}')));
      } finally {
        setState(() => withdrawalLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallet'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      backgroundColor: Colors.black,
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Balance Card
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 4,
                      color: const Color(0xFFFFD700),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 28,
                              child: Icon(Icons.account_balance_wallet, color: Colors.black, size: 36),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Balance',
                                    style: TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '₹${walletBalance.toStringAsFixed(2)}',
                                    // '₹3000.00',
                                    style: const TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 120),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: walletBalance >= 100 ? Colors.white : Colors.white.withOpacity(0.5),
                                  foregroundColor: Colors.green[700],
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 0,
                                ),
                                onPressed: withdrawalLoading
                                    ? null
                                    : () {
                                        if (walletBalance < 100) {
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('Minimum amount to withdraw is ₹100.')),
                                          );
                                        } else {
                                          _requestWithdrawal();
                                        }
                                      },
                                child: withdrawalLoading
                                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                                    : FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: const [
                                            Icon(Icons.upload, size: 18),
                                            SizedBox(width: 4),
                                            Text('Withdraw', style: TextStyle(fontSize: 14)),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Recent Transactions Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Recent Transactions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Icon(Icons.history, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (transactions.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('No transactions found.', style: TextStyle(color: Colors.grey)),
                      ),
                    ...transactions.map((txn) => Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: txn.transactionType == 'credit' ? Colors.green[100] : Colors.red[100],
                              child: Icon(
                                txn.transactionType == 'credit' ? Icons.arrow_downward : Icons.arrow_upward,
                                color: txn.transactionType == 'credit' ? Colors.green : Colors.red,
                              ),
                            ),
                            title: Text(
                              '${txn.transactionType == 'credit' ? 'Credited' : 'Debited'} ₹${txn.amount.toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text('${txn.source}\n${_formatDateTime(txn.createdAt)}'),
                            trailing: Text(
                              txn.status,
                              style: TextStyle(
                                color: txn.status == 'paid' ? Colors.green : Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )),

                    const SizedBox(height: 32),
                    // Withdrawals Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text('Withdrawal Requests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Icon(Icons.account_balance, color: Colors.grey),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (withdrawals.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text('No withdrawal requests.', style: TextStyle(color: Colors.grey)),
                      ),
                    ...withdrawals.map((txn) => Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue[50],
                              child: const Icon(Icons.account_balance, color: Colors.blue),
                            ),
                            title: Text(
                              'Withdrawal: ₹${txn.amount.toStringAsFixed(2)}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text(_formatDateTime(txn.createdAt)),
                            trailing: Text(
                              txn.status,
                              style: TextStyle(
                                color: txn.status == 'paid' ? Colors.green : Colors.orange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
    );
  }

  String _formatDateTime(DateTime dt) {
    final d = dt.toLocal();
    return "${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}  ${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}";
  }

}
