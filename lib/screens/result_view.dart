import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/simulation_model.dart';

class ResultView extends StatelessWidget {
  final SimulationModel model;

  const ResultView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final currencyFormat =
        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0);

    final bool isProfit = model.netProfitPerMonth > 0;

    return Column(
      children: [
        // Summary Cards
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isProfit ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isProfit ? const Color(0xFF2E7D32) : const Color(0xFFC62828),
              width: 2,
            ),
          ),
          child: Column(
            children: [
              Text(
                'Estimasi Laba Bersih / Bulan',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                currencyFormat.format(model.netProfitPerMonth),
                style: GoogleFonts.outfit(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isProfit
                      ? const Color(0xFF2E7D32)
                      : const Color(0xFFC62828),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildTag(
                      'Margin: ${model.profitMargin.toStringAsFixed(1)}%',
                      isProfit ? Colors.green : Colors.red),
                  const SizedBox(width: 8),
                  _buildTag(
                      'ROI: ${model.roiInMonths.toStringAsFixed(1)} Bulan',
                      Colors.blue),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildInfoCard(
                'BEP (Unit)',
                '${NumberFormat.decimalPattern('id').format(model.bepInUnits)} Unit',
                Icons.inventory_2_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildInfoCard(
                'BEP (Rupiah)',
                currencyFormat.format(model.bepInRupiah),
                Icons.monetization_on_outlined,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          'Proporsi Biaya Bulanan',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sections: [
                PieChartSectionData(
                  color: Colors.blue[400],
                  value: model.rawMaterialCostPerUnit *
                      model.productionCapacityPerMonth,
                  title: 'Bahan',
                  radius: 50,
                  titleStyle: GoogleFonts.outfit(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                PieChartSectionData(
                  color: Colors.green[400],
                  value: model.laborCostPerMonth,
                  title: 'Gaji',
                  radius: 50,
                  titleStyle: GoogleFonts.outfit(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                PieChartSectionData(
                  color: Colors.orange[400],
                  value: model.energyCostPerMonth,
                  title: 'Energi',
                  radius: 50,
                  titleStyle: GoogleFonts.outfit(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
                PieChartSectionData(
                  color: Colors.purple[400],
                  value: model.otherOperationalCostPerMonth +
                      (model.packagingCostPerUnit *
                          model.productionCapacityPerMonth),
                  title: 'Lainnya',
                  radius: 50,
                  titleStyle: GoogleFonts.outfit(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
              sectionsSpace: 2,
              centerSpaceRadius: 40,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        text,
        style: GoogleFonts.outfit(
            fontSize: 12, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Icon(icon, color: Colors.grey[600]),
            const SizedBox(height: 8),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
