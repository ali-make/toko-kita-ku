import 'package:flutter/material.dart';
import 'package:tokokita/bloc/produk_bloc.dart';
import 'package:tokokita/model/produk.dart';
import 'package:tokokita/ui/produk_form.dart';
import 'package:tokokita/ui/produk_page.dart';
import 'package:tokokita/widget/warning_dialog.dart';

// ignore: must_be_immutable
class ProdukDetail extends StatefulWidget {
  Produk produk;
  ProdukDetail({this.produk});

  @override
  _ProdukDetailState createState() => _ProdukDetailState();
}

class _ProdukDetailState extends State<ProdukDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Produk"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              "Kode : ${widget.produk.kodeProduk}",
              style: TextStyle(fontSize: 20.0),
            ),
            Text(
              "Nama : ${widget.produk.namaProduk}",
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              "Harga : Rp. ${widget.produk.hargaProduk.toString()}",
              style: TextStyle(fontSize: 18.0),
            ),
            _tombolHapusEdit()
          ],
        ),
      ),
    );
  }

  Widget _tombolHapusEdit() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tombol Edit
        ElevatedButton(
          child: Text("EDIT"),
          onPressed: () {
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (context) => ProdukForm(
                          produk: widget.produk,
                        )));
          },
          style: ElevatedButton.styleFrom(primary: Colors.green),
        ),
        // Tombol Hapus
        ElevatedButton(
          child: Text("DELETE"),
          onPressed: () => confirmHapus(),
          style: ElevatedButton.styleFrom(primary: Colors.red),
        )
      ],
    );
  }

  void confirmHapus() {
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Yakin ingin menghapus data ini?"),
      actions: [
        // Tombol Hapus
        ElevatedButton(
          child: Text("Ya"),
          onPressed: () {
            ProdukBloc.deleteProduk(id: widget.produk.id).then((value) {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => ProdukPage()));
            }, onError: (error) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) => WarningDialog(
                        description: "Hapus data gagal, silahkan coba kembali",
                      ));
            });
          },
          style: ElevatedButton.styleFrom(primary: Colors.green),
        ),
        // Tombol Batal
        ElevatedButton(
          child: Text("Batal"),
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(primary: Colors.grey),
        )
      ],
    );
    showDialog(context: context, builder: (_) => alertDialog);
  }
}
