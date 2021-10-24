import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';



class Transact{
  static String rpcUrl = "http://10.0.2.2:7545";
  static String wsUrl = "ws://10.0.2.2:7545/";

  static void sendEther() async{
    Web3Client client = Web3Client(rpcUrl, Client(), socketConnector: (){
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    String privateKey = 'd47606a20138373307c83e3e87c08a363ec9bf13240129ee097a70a795c7623b';

    Credentials credentials =  EthPrivateKey.fromHex(privateKey);

    EthereumAddress receiver =  EthereumAddress.fromHex('0x566BDD0e82Cc18d35A45c69eF42E94F13EBDa073');
    EthereumAddress ownAddress = await credentials.extractAddress();

    client.sendTransaction(credentials, Transaction(
        from: ownAddress,
        to: receiver,
        value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 20)));
  }

}