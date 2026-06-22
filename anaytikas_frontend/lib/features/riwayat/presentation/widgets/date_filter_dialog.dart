import 'package:flutter/material.dart';
import 'package:anaytikas_frontend/core/config/theme/app_color.dart';

class DateFilterDialog extends StatefulWidget {
  final Function(DateFilter) onApply;

  const DateFilterDialog({Key? key, required this.onApply}) : super(key: key);

  @override
  State<DateFilterDialog> createState() => _DateFilterDialogState();
}

class _DateFilterDialogState extends State<DateFilterDialog> {
  bool isLast13Months = false;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    // Set default dates
    endDate = DateTime.now();
    startDate = endDate!.subtract(const Duration(days: 30));
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
        isLast13Months = false;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: endDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != endDate) {
      setState(() {
        endDate = picked;
        isLast13Months = false;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')} ${_getMonthName(date.month)} ${date.year}';
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'Mei',
      'Jun',
      'Jul',
      'Agu',
      'Sep',
      'Okt',
      'Nov',
      'Des',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Filter Tanggal',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColor.darkGray,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, color: AppColor.darkGray),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xffE0E0E0)),
            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Checkbox untuk 13 bulan terakhir
                  Row(
                    children: [
                      Checkbox(
                        value: isLast13Months,
                        onChanged: (value) {
                          setState(() {
                            isLast13Months = value ?? false;
                            if (isLast13Months) {
                              endDate = DateTime.now();
                              startDate = endDate!.subtract(
                                const Duration(days: 365),
                              );
                            }
                          });
                        },
                        activeColor: AppColor.primary,
                      ),
                      const Expanded(
                        child: Text(
                          '13 Bulan Terakhir',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColor.darkGray,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Pilih Tanggal
                  const Text(
                    'Pilih Tanggal',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.darkGray,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Date range pickers
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectStartDate(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xffE0E0E0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              startDate != null
                                  ? _formatDate(startDate!)
                                  : 'Dari Tanggal',
                              style: TextStyle(
                                fontSize: 12,
                                color: startDate != null
                                    ? AppColor.darkGray
                                    : AppColor.lowGray,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '-',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColor.darkGray,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => _selectEndDate(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: const Color(0xffE0E0E0),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              endDate != null
                                  ? _formatDate(endDate!)
                                  : 'Sampai Tanggal',
                              style: TextStyle(
                                fontSize: 12,
                                color: endDate != null
                                    ? AppColor.darkGray
                                    : AppColor.lowGray,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Color(0xffE0E0E0)),
            // Footer dengan tombol Filter
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.primary,
                    foregroundColor: AppColor.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    widget.onApply(
                      DateFilter(
                        startDate: startDate,
                        endDate: endDate,
                        isLast13Months: isLast13Months,
                      ),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Filter',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateFilter {
  final DateTime? startDate;
  final DateTime? endDate;
  final bool isLast13Months;

  DateFilter({this.startDate, this.endDate, required this.isLast13Months});
}
