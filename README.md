# Polygon Advanced Final Project - zkCircuits

## Description
Imagine that you wake up, check your email, and you see an interesting task: Polygon is asking you to design a new zkSNARK circuit that implements some logical operations. You need to implement the circuit and deploy a verifier on-chain to verify proofs generated from this circuit

For this project, you will create a circuit using the circom programming language that implements the above logical gate

## Getting Started
Compile the Multiplier2() circuit and verify it against a smart contract verifier.
```javascript
pragma circom 2.0.0;


template Multiplier2 () {  

   // Declaration of signals.  
   signal input a;  
   signal input b;
   signal x,y;  
   signal output c;  

   //component declarations
   component andGate = AND();
   component orGate = OR();
   component notGate = NOT();

   // Circuit description.
   andGate.a <== a;
   andGate.b <== b;
   x <== andGate.out;
   
   notGate.in <== b;
   y <== notGate.out;

   orGate.a <== x;
   orGate.b <== y;

   //output
   c <== orGate.out;


}
template AND() {
    signal input a;
    signal input b;
    signal output out;

    out <== a*b;
}

template OR() {
    signal input a;
    signal input b;
    signal output out;

    out <== a + b - a*b;
}

template NOT() {
    signal input in;
    signal output out;

    out <== 1 + in - 2*in;
}


component main = Multiplier2();

```

### Install
`npm i`

### Compile
`npx hardhat circom` 
This will generate the **out** file with circuit intermediaries and geneate the **MultiplierVerifier.sol** contract

### Prove and Deploy
Go to '.env.example' file, fill your private key in there and rename the file to '.env' .

Don't forget to connect your wallet to mumbai testnet account,  use this for instructions: https://medium.com/stakingbits/how-to-connect-polygon-mumbai-testnet-to-metamask-fc3487a3871f
![image](https://github.com/Mehak051003/Poly-assessment-3/assets/118992603/854719a9-6e01-47d6-95dd-c6df0bfefa8d)


`npx hardhat run scripts/deploy.ts`
This script does 4 things  
1. Deploys the MultiplierVerifier.sol contract
2. Generates a proof from circuit intermediaries with `generateProof()`
3. Generates calldata with `generateCallData()`
4. Calls `verifyProof()` on the verifier contract with calldata

With two commands you can compile a ZKP, generate a proof, deploy a verifier, and verify the proof 🎉

## Authors

Mehak Thakur[mehakthakur051003@gmail.com]

## License

This project is licensed under the MIT License - see the LICENSE.md file for details



