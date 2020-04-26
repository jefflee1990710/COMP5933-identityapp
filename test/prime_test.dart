import 'package:identityapp/crypto/prime.dart';
import 'package:test/test.dart';

void main(){
  test('findNearestPrime', () {
    BigInt p = findNearestPrime(BigInt.parse("347692749827348927348972894728934347692749827348927348972894728934347692749827348927348972894728934347692749827348927348972894728934"), null);
    print(p);
  });
}