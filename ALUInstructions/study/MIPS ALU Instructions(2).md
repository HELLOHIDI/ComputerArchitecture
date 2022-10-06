## 1. 곱셈

|Instruction|기능|형식|
|------|---|---|
|mult|레지스터의 값을 곱하는 명령어|mult $3 $4 |
|multu|레지스터의 값을 곱하는 명령어<br>(no overflow exception)|multu $3 $4|

## 2. 나눗셈

|Instruction|기능|형식|
|------|---|---|
|div|레지스터의 값을 나누는 명령어|div $3 $4 |
|divu|레지스터의 값을 나누는 명령어<br>(no overflow exception)|divu $3 $4|

## 3. mfhi, mflo
> 덧셈, 뺄셈과 다르게 2개의 operand밖에 보이지 않는다 그 이유는?
**곱셈과 나눗셈은 값이 overflow가 될 가능성이 큼으로 64비트를 나눠서 표현을 한다**

|Instruction|기능|형식|
|------|---|---|
|mfhi|mult : 값을 2진수로 표현할때 상위 32비트<br>div : 몫|mfhi $4|
|mflw|mult : 값을 2진수로 표현할때 하위 32비트<br>div : 나머지<br>|mflo $3 $5|

## 4. 예시코드
```
// 곱셈 예시코드
.text
.globl main
main:
    addi $t0, $0, 2 
    addi $t1, $0, 3
    mult $t0, $t1
    mflo $t2
    mfhi $t3
```

```
// 나눗셈 예시코드
.text
.globl main
main:
    addi $t0, $0, 2 
    addi $t1, $0, 3
    div $t0, $t1
    mflo $t2
    mfhi $t3
```
