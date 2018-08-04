
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


      // Signals will be corrupted, unless provided with these supplies
      $display($time, " All Power Supply ON");
      status = supply_on("/dut_top/VDD_1d0", 1.0);
      status = supply_on("/dut_top/VDD_0d8", 0.8);
      status = supply_on("/dut_top/VSS", 0);


      // Apply Stimulus to the design
      #10;
      {in1, in2, in3} = 3'b000;

      #10;
      {in1, in2, in3} = 3'b110;

      #10;
      $display($time, " #1 Power Switch STATE:1 - Switch ON PD_OR");
      top_pwr_sw = 1;

      for(int val = 0; val < 8; val++)
      begin
         #10;
         {in1, in2, in3} = val;
      end

      #10;
      $display($time, " #2 Power Switch STATE:0 - Switch OFF PD_OR");
      top_pwr_sw = 0;

      for(int val = 0; val < 8; val++)
      begin
         #10;
         {in1, in2, in3} = val;
      end
      
      #10;
      $display($time, " #3 Power Switch STATE:1 - Switch ON PD_OR");
      top_pwr_sw = 1;

      for(int val = 0; val < 8; val++)
      begin
         #10;
         {in1, in2, in3} = val;
      end

      #100 $finish;

   end


endmodule
