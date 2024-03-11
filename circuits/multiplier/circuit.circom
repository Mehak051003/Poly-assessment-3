pragma circom 2.0.0;

template Multiplier2 () {  
   // Declaration of signals.  
   signal input a;  
   signal input b;
   signal x, y;  
   signal output q;  

   // component declarations
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

   // output
   q <== orGate.out;
}

template AND() {
    signal input a;
    signal input b;
    signal output out;

    out <== a * b;
}

template OR() {
    signal input a;
    signal input b;
    signal output out;

    out <== a + b - a * b;
}

template NOT() {
    signal input in;
    signal output out;

    out <== 1 + in - 2 * in;
}

// Change the main component name
component multiplier = Multiplier2();

// Change the instantiation name to match the main component
component main = multiplier;