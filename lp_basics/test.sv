
import UPF::*;

module test;

   reg  in1, in2, in3;
   reg  top_pwr_sw;
   wire op1;

   bit status;

   design_top dut_top(.top_pwr_sw(top_pwr_sw), .in1(in1), .in2(in2), .in3(in3), .op1(op1));


   initial
   begin
      $monitor($time, " | Power %b | State Values in1:%b in2:%b in3:%b op1:%b",
      top_pwr_sw, in1, in2, in3, op1);

      // Apply Stimulus to the design
      #10;

      // Signals will be corrupted, unless provided with these supplies
      status = supply_on("/dut_top/VDD_1d0", 1.0);
      status = supply_on("/dut_top/VDD_0d8", 0.8);
      status = supply_on("/dut_top/VSS", 0);

      #10;
      {in1, in2, in3} = 3'b000;

      #10;
      {in1, in2, in3} = 3'b110;

      #10;
      //[ISSUE]: No effect of Power Switch ON/OFF
      top_pwr_sw = 1;

      #10;
      {in1, in2, in3} = 3'b111;

      #10;
      {in1, in2, in3} = 3'b000;

      #10;
      {in1, in2, in3} = 3'b101;

      #10;
      top_pwr_sw = 0;

      #10;
      {in1, in2, in3} = 3'b010;

      #10;
      {in1, in2, in3} = 3'b111;

      #10;
      {in1, in2, in3} = 3'b110;

      #10;
      {in1, in2, in3} = 3'b001;

      #100 $finish;

   end


endmodule
