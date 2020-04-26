import 'package:starfruit/starfruit.dart';

int sign1(int k){
  return 1-2*(k%2);
}

int sign2(int k){
  return 1-2*((k%3)%2);
}

List generate4Possible(int k){
  List l = [];
  for(int i = 0; i < 4; i ++){
    int s1 = sign1(i + 1);
    int s2 = sign2(i + 1);
    int r = s1 * (6*k + s2);
    l.add(r);
  }
  return l;
}

Iterable<BigInt> nextPossiblePrime(BigInt c) sync* {
  int k = 0;
  while(true){
    List l = generate4Possible(k);
    for(int p in l){
      BigInt r = c + BigInt.from(p);
      yield r;
    }
    k ++;
  }
}

bool isPrime(BigInt n){
  BigInt p0 = BigInt.from(0);
  BigInt p1 = BigInt.from(1);
  BigInt p2 = BigInt.from(2);
  BigInt p3 = BigInt.from(3);
  BigInt p5 = BigInt.from(5);
  BigInt p7 = BigInt.from(7);
  BigInt p11 = BigInt.from(11);
  BigInt p13 = BigInt.from(13);
  BigInt p17 = BigInt.from(17);
  BigInt p25 = BigInt.from(25);
  if (n == p2 || n == p3 || n == p5) {
      return true;
    }
    if (n < p2 || n % p2 == p0 || n % p3 == p0 || n % p5 == p0) {
      return false;
    }
    if (n < p25) {
      return true;
    }
    var d = n - p1, s = p0;
    while (d % p2 == p0) {
      d ~/= p2;
      s = s + p1;
    }
    loop:
    for (final a in [p2, p3, p5, p7, p11, p13, p17]) {
      BigInt x = a.modPow(d, n);
      if (x == p1 || x == n - p1) {
        continue loop;
      }
      for (BigInt r = p0; r <= s - p1; r = r + p1) {
        x = x.modPow(p2, n);
        if (x == p1) {
          return false;
        }
        if (x == n - p1) {
          continue loop;
        }
      }
      return false;
    }
    return true;
}

BigInt findNearestPrime(BigInt n, BigInt max){
  BigInt c = n - n%BigInt.from(6);
  int cnt = 0;

  Iterable it = nextPossiblePrime(c);
  for(BigInt p in it){
    if(p > BigInt.from(0) && (max == null || p < max)){
      cnt = 0;
      if(isPrime(p)){
        return p;
      }
    }else{
      cnt = cnt + 1;
    }
    if(cnt == 4){
      throw Exception("Prime number not found in range");
    }
  }
}