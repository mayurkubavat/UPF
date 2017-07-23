module design_top(input top_pwr_sw, in1, in2, in3, output op1);

   wire op0;

   and andGate(op0, in1, in2);
   or  orGate (op1, op0, in3);
   
endmodule

