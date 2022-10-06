# MIPS Reprsenting Instructions
우리가 배웠던 MIPS Instruction을 CPU가 이해할 수 있도록 2진수로 해석하는 것을 배워보도록 하겠습니다! MIPS 명령어를 32비트로 format하는 방법은 총 3가지이며 이번 장에서는 R-format과 I-format에 대해 배워보겠습니다.

## R-format Instructions
![](https://velog.velcdn.com/images/hello_hidi/post/f153833e-e125-4131-9562-bb9b958aa395/image.jpeg)

|이름|기능|bits|
|------|---|---|
|op|operation 코드|6bits|
|rs|첫번째 레지스터 번호|5bits|
|rt|두번째 레지스터 번호|5bits|
|rd|결과값 레지스터 번호|5bits|
|shamt|shift를 할 양|5bits|
|funct|function 코드, op의 부가적 내용|6bits|
![](https://velog.velcdn.com/images/hello_hidi/post/9458fdec-ddf7-4f16-ab20-607c88c1aa04/image.jpg)

```
ex) add $t0, $s1, $s2
1. add의 opcode,function 코드를 opcode map에서 찾는다 (000000/100000)

2. $t0 : 8번 레지스터 , $s1 : 17번 레지스터, $s2 : 18번 레지스터
=> 01000 / 10001 / 10010

3. shift 없으니까 00000

이걸 합치면
000000 / 10001 / 10010 / 01000 / 00000 / 100000
=> 0000 0010 0011 0010 0100 0000 0010 0000
=> 0x02324020
```

### Disassemble to MIPS instruction
어셈블을 할 수 있다면 반대도 당연히 할 수 있다.
```
ex) 0x00853022
0000 0000 1000 0101 0011 0000 0010 0010

1. R-format 형태로 바꾼다
000000 / 00100 / 00101 / 00110 / 00000 / 100010

2. opcode + functional code : sub

3. 00100 : rs$4 / 00101 : rt$5 / 00110 : rd$6

4. shift = 0

=> sub $6 $4 $5
```

### sll, srl
sll, srl은 다른 R-format은 rs를 비어두고, shamt에 이동할만큼의 값을 넣어주면 된다.
```
ex) sll $10, $16, 4
1. opcode+functional : 000000 / 000000
2. rs = 00000
3. rt : 01010 / rd : 10000
4. shamt : 00100

000000 00000 10000 01010 00100 000000
0000 0000 0001 0000 0101 0001 0000 0000
=> 0x00105100
```

## I-format Instructions

#### R-format의 한계점
만약 addi나 ori처럼 두번째 operand 상수가 온다면? 5bits로 표현하기 어렵다 ex) 0x8000(16비트)

SO. Immediate arithmetic or load/store instructions에서는 I-format을 사용한다!

![](https://velog.velcdn.com/images/hello_hidi/post/c2e5610c-32c2-4b3b-8c73-58fec207f814/image.jpeg)

|이름|기능|bits|
|------|---|---|
|op|operation 코드|6bits|
|rs|첫번째 레지스터 번호|5bits|
|rt|두번째 레지스터 번호|5bits|
|constant or address|상수값이나 주소|16bits|

이로써 상수나 주소를 16비트까지 표현 가능하게 되었다(-2^15 ~ 2^15-1)

### sign-extention
1. memory에서 control로 요청을 할 때 I-format을 통해 상수를 16비트로 받아온다.
2. 그러나 control에서 확인 후 연산을 위해 ALU 연산자를 부른다. 이때 계산 형태가 32비트가 되어야 된다.

**그러기 위해서 16비트의 상수를 32비트로 확장을 시켜주어야 되는데 이를 Extention이라고 한다.**

extention에서 중요한 것은 32비트로 확장은 시키되 값이 변하면 안되는데 이로 인해서 zero-extention과 sign-extention으로 나누어지게 된다.

#### 1) zero extention
**logical Instruction**은 bit-by-bit 연산을 하기 때문에, MSB가 1이어도 양수 음수로 나누어지지 않는다. 
그렇기 때문에 아래 그림의 ?을 전부 0으로 채워줘도 값의 변화가 나타나지 않는다. 
#### **sign bit와 상관없이 0으로 채우는 것을 zero extention이라 부른다**
**ex) ori, andi**
![](https://velog.velcdn.com/images/hello_hidi/post/d0f17a9c-15e3-4ea2-9187-cc0b225fafd8/image.jpeg)

#### 2) sign extention
반면 Arithmetic Instruction의 경우는 다르다. 산술연산자일 경우는 sign bit에 따라 값이 달라진다. 
```
1101 0010 1100 0001

그냥 무턱대고 0을 넣어버리면
0000 0000 0000 0000 1101 0010 1100 0001 (부호가 바뀌고 값이 달라진다)

```
**그렇기 때문에 산술연산자를 사용할 경우는 sign extention의 값으로 나머지 16비트를 채워준다. 이것을 우리는 sign-extention이라고 부른다.**
**ex) addi**

![](https://velog.velcdn.com/images/hello_hidi/post/d9b1d13d-f55e-4d42-8680-4b7fd56918fe/image.jpeg)
