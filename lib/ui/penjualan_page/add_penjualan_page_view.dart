import 'package:app_sawit/ui/penjualan_page/add_penjualan_page_provider.dart';
import 'package:app_sawit/ui/penjualan_page/penjualan_page_view.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddPenjualanPageView extends StatefulWidget {
  const AddPenjualanPageView({Key? key}) : super(key: key);

  @override
  State<AddPenjualanPageView> createState() => _AddPenjualanPageViewState();
}

class _AddPenjualanPageViewState extends State<AddPenjualanPageView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddPenjualanPageProvider(),
      child: Consumer<AddPenjualanPageProvider>(
        builder: (context, addPenjualan, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.green,
              elevation: 2,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => PenjualanPageView()),
                        (route) => false,
                  );
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
              ),
              title: Text(
                "Tambah Penjualan",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            ),
            body: Form(
              key: addPenjualan.addPenjualanFormKey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pilih Supir", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),),
                        SizedBox(height: 10),
                        Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField2<String>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1),
                                  )),
                              hint: Text(
                                'Pilih Supir',
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                              value: addPenjualan.selectedSupir,
                              items: addPenjualan.listSupir
                                  .map((item) => DropdownMenuItem<String>(
                                  value: item.id.toString() ?? '',
                                  child: Text(
                                    "${item.nama}",
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  )))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  print(value);
                                  addPenjualan.selectedSupir = value;
                                });
                              },
                              onSaved: (value) {
                                addPenjualan.selectedSupir = value.toString();
                              },
                              buttonStyleData: ButtonStyleData(
                                padding: EdgeInsets.only(right: 8),
                              ),
                              iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 24),
                              menuItemStyleData: MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            )),

                        SizedBox(height: 25),
                        Text("Pilih Pemuat", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600),),
                        SizedBox(height: 10),
                        Container(
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: DropdownButtonFormField2<String>(
                              isExpanded: true,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 16),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1),
                                  )),
                              hint: Text(
                                'Pilih Pemuat',
                                style: GoogleFonts.poppins(fontSize: 16),
                              ),
                              value: addPenjualan.selectedPemuat,
                              items: addPenjualan.listPemuat
                                  .map((item) => DropdownMenuItem<String>(
                                  value: item.id.toString() ?? '',
                                  child: Text(
                                    "${item.nama}",
                                    style: GoogleFonts.poppins(fontSize: 14),
                                  )))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  print(value);
                                  addPenjualan.selectedPemuat = value;
                                });
                              },
                              onSaved: (value) {
                                addPenjualan.selectedPemuat = value.toString();
                              },
                              buttonStyleData: ButtonStyleData(
                                padding: EdgeInsets.only(right: 8),
                              ),
                              iconStyleData: IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black45,
                                  ),
                                  iconSize: 24),
                              menuItemStyleData: MenuItemStyleData(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                            )),

                        SizedBox(height: 25),
                        Text("Tanggal",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: addPenjualan.tanggalTxt,
                          readOnly: true,
                          decoration: InputDecoration(
                              hintText: "Masukan tanggal",
                              hintStyle: GoogleFonts.poppins(fontSize: 12),
                              prefixIcon: Icon(
                                CupertinoIcons.calendar,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.grey),
                              )),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100),
                            );

                            if (pickedDate != null) {
                              addPenjualan.setDate(pickedDate);
                            }
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tanggal wajib diisi';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 25),
                        Text("Jumlah TBS",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: addPenjualan.quantityTbsTxt,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Masukan jumlah TBS",
                              hintStyle: GoogleFonts.poppins(fontSize: 12),
                              prefixIcon: Icon(
                                CupertinoIcons.money_dollar,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.grey),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Jumlah TBS wajib diisi';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 25),
                        Text("Jumlah Berondolan",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500, fontSize: 12)),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: addPenjualan.quantityBerondolanTxt,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: "Masukan jumlah Berondolan",
                              hintStyle: GoogleFonts.poppins(fontSize: 12),
                              prefixIcon: Icon(
                                CupertinoIcons.money_dollar,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(color: Colors.grey),
                              )),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Jumlah Berondolan wajib diisi';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(20),
              child: MaterialButton(
                onPressed: () async {
                  if (addPenjualan.addPenjualanFormKey.currentState
                      ?.validate() ==
                      true) {
                    await addPenjualan.addDataPenjualan(context);
                  }
                },
                minWidth: double.infinity,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.green,
                child: Text("Simpan Data", style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),),
              ),
            ),
          );
        },
      ),
    );
  }
}
