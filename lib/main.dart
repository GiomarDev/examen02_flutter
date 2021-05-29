import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(title: ' Giomar Limo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  String nombres = "";
  String pedido = "";
  double precio = 0;
  int cantidad = 0;
  double subtotal = 0;
  double descuento = 0;
  double delivery = 0;
  double total = 0;
  String mensaje = "";
  bool validacion = false;
  String titulo = "Registro de pedido de Menu";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _tfNombres = TextEditingController();
  final _tfPedido = TextEditingController();
  final _tfPrecio = TextEditingController();
  final _tfCantidad = TextEditingController();

  void _calcularTotal() {
    setState(() {
      widget.validacion = false;
      if (_tfPrecio.text.toString() == "" ||
          _tfCantidad.text.toString() == "") {
        widget.validacion = true;
        widget.mensaje = "Falta ingresar datos";
      }
      widget.precio = double.parse(_tfPrecio.text);
      widget.cantidad = int.parse(_tfCantidad.text);
      widget.subtotal = widget.precio * widget.cantidad;
      if (widget.subtotal > 500) {
        widget.descuento = widget.subtotal * 0.05;
        widget.delivery = 20;
      }
      widget.total = (widget.subtotal + widget.delivery) - widget.descuento;
    });
  }

  bool state = false;
  double delivery = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sistema de Notas" + widget.title),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              child: Text(
                  "Bienvenido por favor complete sus datos para completar su pedido",
                  style: TextStyle(fontSize: 14)),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Column(
                children: <Widget>[
                  TextField(
                      controller: _tfNombres,
                      decoration: InputDecoration(
                        hintText: "Nombres",
                        labelText: "Nombres",
                      )),
                  TextField(
                      controller: _tfPedido,
                      decoration: InputDecoration(
                        hintText: "Pedido",
                        labelText: "Ingrese el nombre del pedido",
                      )),
                  TextField(
                      controller: _tfPrecio,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: "Precio",
                        labelText: "Ingrese el precio del pedido",
                        errorText: _tfPrecio.text.toString() == ""
                            ? widget.mensaje
                            : null,
                      )),
                  TextField(
                      controller: _tfCantidad,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: "Cantidad",
                        labelText: "Ingrese la cantidad",
                        errorText: _tfCantidad.text.toString() == ""
                            ? widget.mensaje
                            : null,
                      )),
                  Text("Subtotal:" + widget.subtotal.toString()),
                  Text("Descuento:" + widget.descuento.toString()),
                  Container(
                    margin: EdgeInsets.only(
                        left: 30.0, top: 10.0, right: 30.0, bottom: 5.0),
                    child: Text(
                      "Delivery",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Center(
                    child: Switch(
                      value: state,
                      onChanged: (bool s) {
                        setState(() {
                          state = s;
                          if (state = true) {
                            widget.delivery = widget.delivery + 20;
                          } else {
                            delivery = 0;
                          }
                        });
                      },
                      activeColor: Colors.yellow,
                      activeTrackColor: Colors.orangeAccent,
                    ),
                  ),
                  Text("Total a pagar: " + widget.total.toString()),
                  RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      color: Colors.deepPurple,
                      child: Text(
                        "Calcular",
                        style: TextStyle(fontSize: 18, fontFamily: "rbold"),
                      ),
                      onPressed: _calcularTotal)
                ],
              ),
            )
          ],
        ));
  }
}
