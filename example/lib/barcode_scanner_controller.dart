import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:gsheets/gsheets.dart';
import 'package:fluttertoast/fluttertoast.dart';



const _credentials = r'''
{
  "type": "service_account",
  "project_id": "alpine-theory-369110",
  "private_key_id": "b1e3206564d360faed44168c6daaeaa4585927e9",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCa7IO2gBoXVlY4\nwHjwSABwbuHH+BVCUBd8+IeHxa2QDHh6GzKSKgVaRjUi4+wyOgfI5ShTXua+40MM\npc3hBzgzi9tG0h1rFp/jW/cjSlHhysaUesD+OOVHil1AltWAqtLsGjcjPN7s/Uor\nOZHrBwBMrlUhXXFxWCpU777q8FffPTuq/BSvEkHOXBFBTrsaDE2rvU64Sz/MhGYk\nv+/Cij64uth1NkgBrfrfRR/Sh5SEYDOpL9fgI/mmVBjUkFlOUyd9x923LVHDeNWU\nBF5j9sDrhbrRzy/PZFoe35aLf0VSKR6iMETFzAcRPUemFXsNHyMxlOdj89BIeu8R\ngeARC+qxAgMBAAECggEAHgpmr+i/Jm9TYMXRraYIj8SwezobxTQKme0HOsiWEyyX\n3/WOJNGJICwk+ZMApeyivc3Rt/ja/YDL65PrDAt+VmB0MJNlqPJGJqwai/lJT2Mm\nhnwXGDSoIOsvkeqtk7mMFMQwlOCkyYeD7kXHia9d24CieUnJSZUzAC1M8/mO0Had\n6szSU81kCQnvaC6FZKyXOh6JqjGlrxE1sBVkpfed+SXsdOaFJktpGxVtC+cT8nmU\n8qvIm6dEBPXimQPwtxdGndef1I6mO9ba6ncLDiFCrBA8lB8tNVZd5bIDZWAU3n3I\nBtuQljMlMQG8TZ2ZZEI0fkQIMaKk65WiGebwp9psUQKBgQDNJ6DI7g6LjTAoyvS5\nlQE+NLHyd9gkT1WRiYzwslm8E8mAV1F58G0CcCrz6a0xLoaYGM2tHQVdHzONRMFk\n1zMrzcGwmDa12o/r0sBlcUUJoIktLtOwQIkRYJXEm5QClrDAFb9h07LIWytU9NYf\n7mzSUQDwshX9G7Pgfh4RC3ysqwKBgQDBUegLhRG8aQS804r3YggpW17Dnr255Ks6\nwSumHeHyZGaimHmsh7Gh13tY7TOsOmwcujB21xsSkl6uO6H09+P/c8lOJ52siiB1\nDLqN6k6/pX+5JGXBYX/C+wv+bd/vM1GPXd/a7szeQUB/EwhCgX6mSByTjIBNNRs6\na5ATYI1OEwKBgE9yECafYYyTIVo6tiiD1lZji6GM3Wu6OTXB4Y14U52sv/RuXAPv\nohc2nruT+1i3XrHZsRRfz6rvIUSMoqPNXmiRJnefilhECkXVeGIQSh7fRx/zKVDw\nvOO41marpNaXylyoT1Ov6mUCQTaGFcGJ0CRl8ApFvJQmvTKrRDNvklk/AoGACDub\nvTnaioKScBQ2O9jR7ij0/TG6dLs3S5ZEbJujLrZ15IDH1cAloXXSy/O2GqSWTBbl\nz3nTrlPLcnIZsJwJ+qwMq6ZmQZ3USgfTvg13cxPyP4k8SCMF1ODqHtjBC6fM1mUy\nDlnTIbf3rjG6TVLEeQJjLSlzoVYcpb1E8n5PJj8CgYAov2k42/i5SaeoYBpSKw7L\nUqOZkNJR9Gjad/2yOaoDpO+EGP/YxVHCxaIL0NF4Lo/3jsamw2rqZ6bFRDbt7rtG\n0ORptaN5km8tZlJSYmkBwjZ2jwHx1ccKEoA5T3gU2UXmzicIrnoaKK+dN9/re98g\nKEKKRvlOpV5s8/wGQje0Qw==\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheetsyogathon@alpine-theory-369110.iam.gserviceaccount.com",
  "client_id": "104435022177006466853",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheetsyogathon%40alpine-theory-369110.iam.gserviceaccount.com"
}
''';


class BarcodeScannerWithController extends StatefulWidget {
  const BarcodeScannerWithController({super.key});

  @override
  State<BarcodeScannerWithController> createState() =>
      _BarcodeScannerWithControllerState();
}

class _BarcodeScannerWithControllerState
    extends State<BarcodeScannerWithController>
    with SingleTickerProviderStateMixin {
  BarcodeCapture? barcode;


  MobileScannerController controller = MobileScannerController(
    // torchEnabled: true,
    // formats: [BarcodeFormat.qrCode]
    // facing: CameraFacing.front,
    // detectionSpeed: DetectionSpeed.normal
    // detectionTimeoutMs: 1000,
    // returnImage: false,
  );

  // _onDetect(/*My args here*/){
  //   isEnabled.value = false;
  //   // ... my code to run
  //   timer = Timer(
  //     const Duration(seconds: 3),
  //     () => isEnabled.value = true,
  //   );
  // }

  bool isStarted = true;
  int counter =0;

  void _startOrStop() {
    try {
      if (isStarted) {
        controller.stop();
      } else {
        controller.start();
      }
      setState(() {
        isStarted = !isStarted;
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Something went wrong! $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  int? numberOfCameras;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('With controller')),
      backgroundColor: Colors.black,
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              MobileScanner(
                onScannerStarted: (arguments) {
                  if (mounted && arguments?.numberOfCameras != null) {
                    numberOfCameras = arguments!.numberOfCameras;
                    setState(() {});
                  }
                },
                controller: controller,
                errorBuilder: (context, error, child) {
                  return ScannerErrorWidget(error: error);
                },
                fit: BoxFit.contain,
                // controller: MobileScannerController(
                //   torchEnabled: true,
                //   facing: CameraFacing.front,
                // ),
                onDetect: (barcode) async {
                  setState(() {
                    this.barcode = barcode;
                  });
                  counter++;
                  if(counter==1) {
                    print('---------------CEntered--------');
                    String? url = barcode?.barcodes.first.rawValue.toString();
                    var uri = Uri.dataFromString(url.toString()); //converts string to a uri    
                    Map<String, String> params = uri.queryParameters; // query parameters automatically populated
                    // var param1 = params['entry.510012953'];
                    String uniqId = params['entry.510012953'].toString();
                    // String scanned = params['entry.1726464026'].toString();
                    print(uniqId);
                    final gsheets = GSheets(_credentials);
                    // fetch spreadsheet by its id
                    final ss = await gsheets.spreadsheet('1S8SX4PXHHALyig4xwxyj9_n-dBDVq7PuEz9XU1wW_5w');
                    var sheet = ss.worksheetByTitle('QRCode Generator');
                    var rows = await sheet?.values.rowByKey(uniqId);
                    print('rows');
                    print(rows);
                    
                    // await sheet.values.insertValue('new', column: 2, row: 2);


                    setState(() {
                      this.barcode = barcode;
                    });
                     if(rows != null && rows.length > 0 && rows.last == uniqId + 'scanned') {
                      print('----------------Empty------------');
                      controller.stop();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Duplicate'),
                              content: Text('Cannot scan again'),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    controller.start();
                                    Navigator.pop(context);
                                  },
                                )
                              ]
                            );
                          });
                        // Navigator.pop(context);
                     } else{
                      print('----------------response------------');
                      final response = await http
                            .get(Uri.parse(url.toString()+ '&entry.1726464026=' +uniqId + 'scanned'));
                      print('----------------scanned------------');
                        if (response.statusCode == 200) {
                          // If the server did return a 200 OK response,
                          // then parse the JSON.
                          Fluttertoast.showToast(
                              msg: "Scanned Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0
                          );

                          Navigator.pop(context);
                        } else {
                          // If the server did not return a 200 OK response,
                          // then throw an exception.
                          throw Exception('Failed to load album');
                        }
                     }
                  }
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  height: 100,
                  color: Colors.black.withOpacity(0.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ValueListenableBuilder(
                        valueListenable: controller.hasTorchState,
                        builder: (context, state, child) {
                          if (state != true) {
                            return const SizedBox.shrink();
                          }
                          return IconButton(
                            color: Colors.white,
                            icon: ValueListenableBuilder<TorchState>(
                              valueListenable: controller.torchState,
                              builder: (context, state, child) {
                                switch (state) {
                                  case TorchState.off:
                                    return const Icon(
                                      Icons.flash_off,
                                      color: Colors.grey,
                                    );
                                  case TorchState.on:
                                    return const Icon(
                                      Icons.flash_on,
                                      color: Colors.yellow,
                                    );
                                }
                              },
                            ),
                            iconSize: 32.0,
                            onPressed: () => controller.toggleTorch(),
                          );
                        },
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: isStarted
                            ? const Icon(Icons.stop)
                            : const Icon(Icons.play_arrow),
                        iconSize: 32.0,
                        onPressed: _startOrStop,
                      ),
                      Center(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 200,
                          height: 50,
                          child: FittedBox(
                            child: Text(
                              barcode?.barcodes.first.rawValue ??
                                  'Scan something!',
                              overflow: TextOverflow.fade,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: ValueListenableBuilder<CameraFacing>(
                          valueListenable: controller.cameraFacingState,
                          builder: (context, state, child) {
                            switch (state) {
                              case CameraFacing.front:
                                return const Icon(Icons.camera_front);
                              case CameraFacing.back:
                                return const Icon(Icons.camera_rear);
                            }
                          },
                        ),
                        iconSize: 32.0,
                        onPressed: (numberOfCameras ?? 0) < 2
                            ? null
                            : () => controller.switchCamera(),
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: const Icon(Icons.image),
                        iconSize: 32.0,
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          // Pick an image
                          final XFile? image = await picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (image != null) {
                            if (await controller.analyzeImage(image.path)) {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Barcode found!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                            } else {
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No barcode found!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
