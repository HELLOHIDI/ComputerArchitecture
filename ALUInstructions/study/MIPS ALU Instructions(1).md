# ALU Instructions
> 덧셈,뺄셈, 곱셈, 나눗셈 등의 산술 논리 연산 명령어들

#### 잘못된 코드
아래 코드처럼 하면 에러가 발생한다.
```
C code:
	f = g+h
    
-> Compiled MIPS Code:
	add f,g,h #f = g+h
```
이유가 무엇일까?
그 이유는 MIPS 언어에서는 산술 연산 명령어를 사용할 때
피연산자는 무조건 레지스터를 사용해야 되기 때문이다
=> 변수를 그대로 사용할 수 없다!

## 1. Register
> 레지스터 : 프로세서 내부에 있는, 작고 빠른 임시의 메모리
- 극히 소량의 데이터나 처리 중인 중간 결과와도 같은 프로세서가 바로 사용할 수 있는 데이터를 담고 있는 영역
![](https://velog.velcdn.com/images/hello_hidi/post/c00bd484-7104-423a-ae2d-4cd3fd4b8f00/image.jpeg)
MIPS는 32*32-bit의 register을 가지고 있다
- 32bit를 표현할 수 있는 레지스터를
- 32개 가지고 있다. 그리고 각각의 별명을 가지고 있다.($0 ~ $31)
![](https://velog.velcdn.com/images/hello_hidi/post/ca20a9ab-9732-4d81-ae8d-3032e454c293/image.jpeg)


## 2. 덧셈
|Instruction|기능|형식|
|------|---|---|
|add|레지스터의 값을 더하는 명령어|add $3 $4 $5 # $3 = $4+$5|
|addi|레지스터의 값과 상수를 더하는 명령어|addi $3 $4 5 = $3 = $4+5|
```
.text
.globl main
main:
    addi	$t0, $0, 7			# $t0 = $0 + $t2 (=7)
    addi	$t1, $0, 16			# $t0 = $0 + 16 (=16)
    add		$t2, $t0, $t1		# $t2 = $t0 + $t1 (=23)    
    
```

## 3. 뺄셈
컴퓨터에서 빼기를 표현할 때 주로 2의 보수의 값을 더하기를 해서 표현하다.
그러기 위해 알아야 될 개념을 정리 후 mips instruction을 소개하려고 한다.
물론 mips instruction을 썼을 때 크게 신경 쓸 부분은 아니지만 우리는 컴퓨터 구조를 배우는 거이기에 컴퓨터가 어떻게 2진수로 뺄셈을 계산하는지 배워야함으로 설명을 하고 넘어가겠다.

### i) signed int vs unsigned int
* unsigned int : 부호를 가지지 않는(양수만) 정수 (0 ~ 2^32-1)
* signed int : 부호를 가지는 정수 (-2^15 ~ 2^15-1)
=> MSB(Most Signigificant Bit)가 1이면 음수, 0이면 양수


### ii) 2의 보수 표현
1) n을 2진수로 표현한다
2) 1의 보수로 변환한다. (모든 비트의 0->1, 1->0)
3) 2)결과값에 +1을 해준다.

```
ex) 10001100
unsigned int : 128+8+4 = 140
signed int -> 2의 보수
2) 01110011
3) 01110100 : 4+16+32+64 = -116
```

### iii) mips 뺄셈 명령어
|Instruction|기능|형식|
|------|---|---|
|sub|레지스터의 값을 빼는 명령어|sub $3 $4 $5 # $3 = $4-$5|
**+) subi 명령어는 없다. 대신 addi 명령어의 상수값에 음수를 넣는것으로 대체한다.** 
```
.text
.globl main
main:
    addi	$t0, $0, 7			# $t0 = $0 + $t2 (=7)
    addi	$t1, $0, 16			# $t0 = $0 + 0 (=16)
    sub		$t2, $t1, $t0		# $t2 = $t0 + $t1 (=9)
    addi	$t3, $t1, -7		# $t3 = $t1 + (-7) (=9)
```

## 4. OVERFLOW

### overflow란?
overflow : 연산의 결과가 32-bit word로 표현할 수 없을 때

```
ex) 2147483647 - (-2) = 2147483649
   0111 1111 1111 1111 1111 1111 1111 1111
 - 1111 1111 1111 1111 1111 1111 1111 1110 (-2)
   0111 1111 1111 1111 1111 1111 1111 1111 
 + 0000 0000 0000 0000 0000 0000 0000 0010 (-2의 2의보수)
 ----------------------------------------------
   1000 0000 0000 0000 0000 0000 0000 0001
 ->0111 1111 1111 1111 1111 1111 1111 1111
 => -2147483647이 나온다 이런게 overflow다
```
**overflow를 확인하는 방법은 signed bit만 보고 판단이 가능하다**
- 더할때) 둘다 signed bit가 0인데 1이 나올때
- 더할때) 둘다 signed bit가 1인데 0이 나올때
- 뺄때) 둘다 signed bit가 0 - (-1)인데 1이 나올때
- 뺄때) 둘다 signed bit가 1 - (0)인데 0이 나올때

### mips에서 overflow면
- add/addi/sub 명령어는 연산 결과 overflow가 되면 exception을 발생한다.
**- exception : 프로그램의 정상적인 숭행을 방해하는 계획되지 않은 사건**
- exception이 발생되면 자동으로 exception handler을 수행한다.
![](https://velog.velcdn.com/images/hello_hidi/post/2c772514-798d-4fce-8c8a-d4d24c99f86b/image.png)



### addu, subu
: 더하거나 뺄때 overflow가 발생하더라도 exception handler가 수행되지 않는다.
> Q. 그럼 값이 두가지로 해석이 될텐데?
A. 그건 highlevel에서 정의한다. 타입지정(unsigned int/signed int)으로 정의할 수 있다. spin에서는 10진수는 무조건 signed int로 해석한다.

|Instruction|기능|형식|
|------|---|---|
|addu|레지스터의 값을 더하는 명령어|addu $3 $4 $5 # $3 = $4+$5|
addiu|레지스터의 값과 상수를 더하는 명령어|addiu $3 $4 $5 = $3 = $4+$5|
|subu|레지스터의 값을 빼는 명령어|subu $3 $4 $5 = $3 = $4-$5|

```
.text
.globl main
main:
    addi $t1, $0, 0x7fffffff
    add $t2, $t1, $t1   # overflow
    addu $t3, $t1, $t1  # no exception
    addiu $t4, $t1, -1   # negative constant for addiu
```

