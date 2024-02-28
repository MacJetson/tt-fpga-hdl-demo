//_\TLV_version 1d: tl-x.org, generated by SandPiper(TM) 1.14-2022/10/10-beta-Pro
//_\source top.tlv 43

//_\SV
   // Included URL: "https://raw.githubusercontent.com/efabless/chipcraft---mest-course/main/tlv_lib/calculator_shell_lib.tlv"
   // Include Tiny Tapeout Lab.
   // Included URL: "https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/35e36bd144fddd75495d4cbc01c4fc50ac5bde6f/tlv_lib/tiny_tapeout_lib.tlv"// Included URL: "https://raw.githubusercontent.com/os-fpga/Virtual-FPGA-Lab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlv_lib/fpga_includes.tlv"
//_\source top.tlv 152

//_\SV

// ================================================
// A simple Makerchip Verilog test bench driving random stimulus.
// Modify the module contents to your needs.
// ================================================

module top(input logic clk, input logic reset, input logic [31:0] cyc_cnt, output logic passed, output logic failed);
   // Tiny tapeout I/O signals.
   logic [7:0] ui_in, uo_out;
   
   logic [31:0] r;
   always @(posedge clk) r <= 0;
   assign ui_in = r[7:0];
   
   logic ena = 1'b0;
   logic rst_n = ! reset;

   // Instantiate the Tiny Tapeout module.
   my_design tt(.*);

   assign passed = top.cyc_cnt > 60;
   assign failed = 1'b0;
endmodule


// Provide a wrapper module to debounce input signals if requested.
// The Tiny Tapeout top-level module.
// This simply debounces and synchronizes inputs.
// Debouncing is based on a counter. A change to any input will only be recognized once ALL inputs
// are stable for a certain duration. This approach uses a single counter vs. a counter for each
// bit.
module tt_um_template (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    /*   // The FPGA is based on TinyTapeout 3 which has no bidirectional I/Os (vs. TT6 for the ASIC).
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    */
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    
    // Synchronize.
    logic [9:0] inputs_ff, inputs_sync;
    always @(posedge clk) begin
        inputs_ff <= {ui_in, ena, rst_n};
        inputs_sync <= inputs_ff;
    end

    // Debounce.
    `define DEBOUNCE_MAX_CNT 14'h3fff
    logic [9:0] inputs_candidate, inputs_captured;
    logic sync_rst_n = inputs_sync[0];
    logic [13:0] cnt;
    always @(posedge clk) begin
        if (!sync_rst_n)
           cnt <= `DEBOUNCE_MAX_CNT;
        else if (inputs_sync != inputs_candidate) begin
           // Inputs changed before stablizing.
           cnt <= `DEBOUNCE_MAX_CNT;
           inputs_candidate <= inputs_sync;
        end
        else if (cnt > 0)
           cnt <= cnt - 14'b1;
        else begin
           // Cnt == 0. Capture candidate inputs.
           inputs_captured <= inputs_candidate;
        end
    end
    logic [7:0] clean_ui_in;
    logic clean_ena, clean_rst_n;
    assign {clean_ui_in, clean_ena, clean_rst_n} = inputs_captured;

    my_design my_design (
        .ui_in(clean_ui_in),
        
        .ena(clean_ena),
        .rst_n(clean_rst_n),
        .*);
endmodule
//_\SV



// =======================
// The Tiny Tapeout module
// =======================

module my_design (
    input  wire [7:0] ui_in,    // Dedicated inputs - connected to the input switches
    output wire [7:0] uo_out,   // Dedicated outputs - connected to the 7 segment display
    /*   // The FPGA is based on TinyTapeout 3 which has no bidirectional I/Os (vs. TT6 for the ASIC).
    input  wire [7:0] uio_in,   // IOs: Bidirectional Input path
    output wire [7:0] uio_out,  // IOs: Bidirectional Output path
    output wire [7:0] uio_oe,   // IOs: Bidirectional Enable path (active high: 0=input, 1=output)
    */
    input  wire       ena,      // will go high when the design is enabled
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
   wire reset = ! rst_n;

// ---------- Generated Code Inlined Here (before 1st \TLV) ----------
// Generated by SandPiper(TM) 1.14-2022/10/10-beta-Pro from Redwood EDA, LLC.
// (Installed here: /usr/local/mono/sandpiper/distro.)
// Redwood EDA, LLC does not claim intellectual property rights to this file and provides no warranty regarding its correctness or quality.


// For silencing unused signal messages.
`define BOGUS_USE(ignore)


genvar digit, input_label, leds, switch;


//
// Signals declared top-level.
//

// For $slideswitch.
logic [7:0] L0_slideswitch_a0;

// For $sseg_decimal_point_n.
logic L0_sseg_decimal_point_n_a0;

// For $sseg_digit_n.
logic [7:0] L0_sseg_digit_n_a0;

// For $sseg_segment_n.
logic [6:0] L0_sseg_segment_n_a0;

// For /fpga_pins/fpga|calc$a.
logic [7:0] FpgaPins_Fpga_CALC_a_a3;

// For /fpga_pins/fpga|calc$b.
logic [7:0] FpgaPins_Fpga_CALC_b_a3;

// For /fpga_pins/fpga|calc$c.
logic [7:0] FpgaPins_Fpga_CALC_c_a3;

// For /fpga_pins/fpga|calc$d.
logic [7:0] FpgaPins_Fpga_CALC_d_a3;

// For /fpga_pins/fpga|calc$digit.
logic [3:0] FpgaPins_Fpga_CALC_digit_a3;

// For /fpga_pins/fpga|calc$e.
logic [7:0] FpgaPins_Fpga_CALC_e_a3;

// For /fpga_pins/fpga|calc$eight.
logic [7:0] FpgaPins_Fpga_CALC_eight_a3;

// For /fpga_pins/fpga|calc$equals_in.
logic [0:0] FpgaPins_Fpga_CALC_equals_in_a0,
            FpgaPins_Fpga_CALC_equals_in_a1,
            FpgaPins_Fpga_CALC_equals_in_a2;

// For /fpga_pins/fpga|calc$f.
logic [7:0] FpgaPins_Fpga_CALC_f_a3;

// For /fpga_pins/fpga|calc$five.
logic [7:0] FpgaPins_Fpga_CALC_five_a3;

// For /fpga_pins/fpga|calc$four.
logic [7:0] FpgaPins_Fpga_CALC_four_a3;

// For /fpga_pins/fpga|calc$mem.
logic [7:0] FpgaPins_Fpga_CALC_mem_a2,
            FpgaPins_Fpga_CALC_mem_a3,
            FpgaPins_Fpga_CALC_mem_a4;

// For /fpga_pins/fpga|calc$nine.
logic [7:0] FpgaPins_Fpga_CALC_nine_a3;

// For /fpga_pins/fpga|calc$odiff.
logic [7:0] FpgaPins_Fpga_CALC_odiff_a1,
            FpgaPins_Fpga_CALC_odiff_a2;

// For /fpga_pins/fpga|calc$one.
logic [7:0] FpgaPins_Fpga_CALC_one_a3;

// For /fpga_pins/fpga|calc$op.
logic [2:0] FpgaPins_Fpga_CALC_op_a0,
            FpgaPins_Fpga_CALC_op_a1,
            FpgaPins_Fpga_CALC_op_a2;

// For /fpga_pins/fpga|calc$oprod.
logic [7:0] FpgaPins_Fpga_CALC_oprod_a1,
            FpgaPins_Fpga_CALC_oprod_a2;

// For /fpga_pins/fpga|calc$oquot.
logic [7:0] FpgaPins_Fpga_CALC_oquot_a1,
            FpgaPins_Fpga_CALC_oquot_a2;

// For /fpga_pins/fpga|calc$osum.
logic [7:0] FpgaPins_Fpga_CALC_osum_a1,
            FpgaPins_Fpga_CALC_osum_a2;

// For /fpga_pins/fpga|calc$out.
logic [7:0] FpgaPins_Fpga_CALC_out_a2,
            FpgaPins_Fpga_CALC_out_a3;

// For /fpga_pins/fpga|calc$reset.
logic FpgaPins_Fpga_CALC_reset_a0,
      FpgaPins_Fpga_CALC_reset_a1,
      FpgaPins_Fpga_CALC_reset_a2,
      FpgaPins_Fpga_CALC_reset_a3;

// For /fpga_pins/fpga|calc$seven.
logic [7:0] FpgaPins_Fpga_CALC_seven_a3;

// For /fpga_pins/fpga|calc$six.
logic [7:0] FpgaPins_Fpga_CALC_six_a3;

// For /fpga_pins/fpga|calc$three.
logic [7:0] FpgaPins_Fpga_CALC_three_a3;

// For /fpga_pins/fpga|calc$two.
logic [7:0] FpgaPins_Fpga_CALC_two_a3;

// For /fpga_pins/fpga|calc$val1.
logic [7:0] FpgaPins_Fpga_CALC_val1_a1,
            FpgaPins_Fpga_CALC_val1_a2;

// For /fpga_pins/fpga|calc$val2.
logic [7:0] FpgaPins_Fpga_CALC_val2_a0,
            FpgaPins_Fpga_CALC_val2_a1;

// For /fpga_pins/fpga|calc$valid.
logic [0:0] FpgaPins_Fpga_CALC_valid_a1,
            FpgaPins_Fpga_CALC_valid_a2;

// For /fpga_pins/fpga|calc$valid_or_reset.
logic FpgaPins_Fpga_CALC_valid_or_reset_a1;

// For /fpga_pins/fpga|calc$zero.
logic [7:0] FpgaPins_Fpga_CALC_zero_a3;




   //
   // Scope: /fpga_pins
   //


      //
      // Scope: /fpga
      //


         //
         // Scope: |calc
         //

            // Staging of $equals_in.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_equals_in_a1[0] <= FpgaPins_Fpga_CALC_equals_in_a0[0];
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_equals_in_a2[0] <= FpgaPins_Fpga_CALC_equals_in_a1[0];

            // Staging of $mem.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_mem_a3[7:0] <= FpgaPins_Fpga_CALC_mem_a2[7:0];
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_mem_a4[7:0] <= FpgaPins_Fpga_CALC_mem_a3[7:0];

            // Staging of $odiff.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_odiff_a2[7:0] <= FpgaPins_Fpga_CALC_odiff_a1[7:0];

            // Staging of $op.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_op_a1[2:0] <= FpgaPins_Fpga_CALC_op_a0[2:0];
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_op_a2[2:0] <= FpgaPins_Fpga_CALC_op_a1[2:0];

            // Staging of $oprod.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_oprod_a2[7:0] <= FpgaPins_Fpga_CALC_oprod_a1[7:0];

            // Staging of $oquot.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_oquot_a2[7:0] <= FpgaPins_Fpga_CALC_oquot_a1[7:0];

            // Staging of $osum.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_osum_a2[7:0] <= FpgaPins_Fpga_CALC_osum_a1[7:0];

            // Staging of $out.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_out_a3[7:0] <= FpgaPins_Fpga_CALC_out_a2[7:0];

            // Staging of $reset.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_reset_a1 <= FpgaPins_Fpga_CALC_reset_a0;
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_reset_a2 <= FpgaPins_Fpga_CALC_reset_a1;
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_reset_a3 <= FpgaPins_Fpga_CALC_reset_a2;

            // Staging of $val1.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_val1_a2[7:0] <= FpgaPins_Fpga_CALC_val1_a1[7:0];

            // Staging of $val2.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_val2_a1[7:0] <= FpgaPins_Fpga_CALC_val2_a0[7:0];

            // Staging of $valid.
            always_ff @(posedge clk) FpgaPins_Fpga_CALC_valid_a2[0] <= FpgaPins_Fpga_CALC_valid_a1[0];








//
// Debug Signals
//

   if (1) begin : DEBUG_SIGS_GTKWAVE

      (* keep *) logic [7:0] \@0$slideswitch ;
      assign \@0$slideswitch = L0_slideswitch_a0;
      (* keep *) logic  \@0$sseg_decimal_point_n ;
      assign \@0$sseg_decimal_point_n = L0_sseg_decimal_point_n_a0;
      (* keep *) logic [7:0] \@0$sseg_digit_n ;
      assign \@0$sseg_digit_n = L0_sseg_digit_n_a0;
      (* keep *) logic [6:0] \@0$sseg_segment_n ;
      assign \@0$sseg_segment_n = L0_sseg_segment_n_a0;

      //
      // Scope: /digit[0:0]
      //
      for (digit = 0; digit <= 0; digit++) begin : \/digit 

         //
         // Scope: /leds[7:0]
         //
         for (leds = 0; leds <= 7; leds++) begin : \/leds 
            (* keep *) logic  \//@0$viz_lit ;
            assign \//@0$viz_lit = L1_Digit[digit].L2_Leds[leds].L2_viz_lit_a0;
         end
      end

      //
      // Scope: /fpga_pins
      //
      if (1) begin : \/fpga_pins 

         //
         // Scope: /fpga
         //
         if (1) begin : \/fpga 

            //
            // Scope: |calc
            //
            if (1) begin : P_calc
               (* keep *) logic [7:0] \///@3$a ;
               assign \///@3$a = FpgaPins_Fpga_CALC_a_a3;
               (* keep *) logic [7:0] \///@3$b ;
               assign \///@3$b = FpgaPins_Fpga_CALC_b_a3;
               (* keep *) logic [7:0] \///@3$c ;
               assign \///@3$c = FpgaPins_Fpga_CALC_c_a3;
               (* keep *) logic [7:0] \///@3$d ;
               assign \///@3$d = FpgaPins_Fpga_CALC_d_a3;
               (* keep *) logic [3:0] \///@3$digit ;
               assign \///@3$digit = FpgaPins_Fpga_CALC_digit_a3;
               (* keep *) logic [7:0] \///@3$e ;
               assign \///@3$e = FpgaPins_Fpga_CALC_e_a3;
               (* keep *) logic [7:0] \///@3$eight ;
               assign \///@3$eight = FpgaPins_Fpga_CALC_eight_a3;
               (* keep *) logic [0:0] \///@0$equals_in ;
               assign \///@0$equals_in = FpgaPins_Fpga_CALC_equals_in_a0;
               (* keep *) logic [7:0] \///@3$f ;
               assign \///@3$f = FpgaPins_Fpga_CALC_f_a3;
               (* keep *) logic [7:0] \///@3$five ;
               assign \///@3$five = FpgaPins_Fpga_CALC_five_a3;
               (* keep *) logic [7:0] \///@3$four ;
               assign \///@3$four = FpgaPins_Fpga_CALC_four_a3;
               (* keep *) logic [7:0] \///@2$mem ;
               assign \///@2$mem = FpgaPins_Fpga_CALC_mem_a2;
               (* keep *) logic [7:0] \///@3$nine ;
               assign \///@3$nine = FpgaPins_Fpga_CALC_nine_a3;
               (* keep *) logic [7:0] \///?$valid_or_reset@1$odiff ;
               assign \///?$valid_or_reset@1$odiff = FpgaPins_Fpga_CALC_odiff_a1;
               (* keep *) logic [7:0] \///@3$one ;
               assign \///@3$one = FpgaPins_Fpga_CALC_one_a3;
               (* keep *) logic [2:0] \///@0$op ;
               assign \///@0$op = FpgaPins_Fpga_CALC_op_a0;
               (* keep *) logic [7:0] \///?$valid_or_reset@1$oprod ;
               assign \///?$valid_or_reset@1$oprod = FpgaPins_Fpga_CALC_oprod_a1;
               (* keep *) logic [7:0] \///?$valid_or_reset@1$oquot ;
               assign \///?$valid_or_reset@1$oquot = FpgaPins_Fpga_CALC_oquot_a1;
               (* keep *) logic [7:0] \///?$valid_or_reset@1$osum ;
               assign \///?$valid_or_reset@1$osum = FpgaPins_Fpga_CALC_osum_a1;
               (* keep *) logic [7:0] \///@2$out ;
               assign \///@2$out = FpgaPins_Fpga_CALC_out_a2;
               (* keep *) logic  \///@0$reset ;
               assign \///@0$reset = FpgaPins_Fpga_CALC_reset_a0;
               (* keep *) logic [7:0] \///@3$seven ;
               assign \///@3$seven = FpgaPins_Fpga_CALC_seven_a3;
               (* keep *) logic [7:0] \///@3$six ;
               assign \///@3$six = FpgaPins_Fpga_CALC_six_a3;
               (* keep *) logic [7:0] \///@3$three ;
               assign \///@3$three = FpgaPins_Fpga_CALC_three_a3;
               (* keep *) logic [7:0] \///@3$two ;
               assign \///@3$two = FpgaPins_Fpga_CALC_two_a3;
               (* keep *) logic [7:0] \///@1$val1 ;
               assign \///@1$val1 = FpgaPins_Fpga_CALC_val1_a1;
               (* keep *) logic [7:0] \///@0$val2 ;
               assign \///@0$val2 = FpgaPins_Fpga_CALC_val2_a0;
               (* keep *) logic [0:0] \///@1$valid ;
               assign \///@1$valid = FpgaPins_Fpga_CALC_valid_a1;
               (* keep *) logic  \///@1$valid_or_reset ;
               assign \///@1$valid_or_reset = FpgaPins_Fpga_CALC_valid_or_reset_a1;
               (* keep *) logic [7:0] \///@3$zero ;
               assign \///@3$zero = FpgaPins_Fpga_CALC_zero_a3;
            end
         end
      end

      //
      // Scope: /switch[7:0]
      //
      for (switch = 0; switch <= 7; switch++) begin : \/switch 
         (* keep *) logic  \/@0$viz_switch ;
         assign \/@0$viz_switch = L1_Switch[switch].L1_viz_switch_a0;
      end


   end

// ---------- Generated Code Ends ----------
//_\TLV
   /* verilator lint_off UNOPTFLAT */
   // Connect Tiny Tapeout I/Os to Virtual FPGA Lab.
   //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/35e36bd144fddd75495d4cbc01c4fc50ac5bde6f/tlvlib/tinytapeoutlib.tlv 76   // Instantiated from top.tlv, 207 as: m5+tt_connections()
      assign L0_slideswitch_a0[7:0] = ui_in;
      assign L0_sseg_segment_n_a0[6:0] = ~ uo_out[6:0];
      assign L0_sseg_decimal_point_n_a0 = ~ uo_out[7];
      assign L0_sseg_digit_n_a0[7:0] = 8'b11111110;
   //_\end_source

   // Instantiate the Virtual FPGA Lab.
   //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 307   // Instantiated from top.tlv, 210 as: m5+board(/top, /fpga, 7, $, , calc)
      
      //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 355   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 309 as: m4+thanks(m5__l(309)m5_eval(m5_get(BOARD_THANKS_ARGS)))
         //_/thanks
            
      //_\end_source
      
   
      // Board VIZ.
   
      // Board Image.
      
      //_/fpga_pins
         
         //_/fpga
            //_\source top.tlv 51   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 340 as: m4+calc.
            
               //_|calc
                  //_@0
                     assign FpgaPins_Fpga_CALC_reset_a0 = reset;
            
                     // connect to board inputs
                     assign FpgaPins_Fpga_CALC_op_a0[2:0] = ui_in[6:4];
                     assign FpgaPins_Fpga_CALC_val2_a0[7:0] = {4'b0, ui_in[3:0]};
            
                     assign FpgaPins_Fpga_CALC_equals_in_a0[0] = ui_in[7];
            
            
                  //_@1
                     // register ouput
                     //$val1[7:0] = >>1$out[7:0];
                     assign FpgaPins_Fpga_CALC_val1_a1[7:0] = FpgaPins_Fpga_CALC_reset_a1 ? 8'b00000000 : FpgaPins_Fpga_CALC_out_a3[7:0];
            
                     //$val2[7:0] = $rand2[3:0];
                     //$val2[7:0] = *ui_in[3:0];
            
                     //$valid[0] = $reset ? 1'b0 : (>>1$valid + 1'b1);
                     assign FpgaPins_Fpga_CALC_valid_a1[0] = FpgaPins_Fpga_CALC_reset_a1 ? 1'b0 : FpgaPins_Fpga_CALC_equals_in_a1[0] && ! FpgaPins_Fpga_CALC_equals_in_a2[0];
                     assign FpgaPins_Fpga_CALC_valid_or_reset_a1 = FpgaPins_Fpga_CALC_valid_a1 || FpgaPins_Fpga_CALC_reset_a1;
            
                     //_?$valid_or_reset
                        assign FpgaPins_Fpga_CALC_osum_a1[7:0]  = FpgaPins_Fpga_CALC_val1_a1[7:0] + FpgaPins_Fpga_CALC_val2_a1[7:0]; // calculate sum
                        assign FpgaPins_Fpga_CALC_odiff_a1[7:0] = FpgaPins_Fpga_CALC_val1_a1[7:0] - FpgaPins_Fpga_CALC_val2_a1[7:0]; // calculate difference
                        assign FpgaPins_Fpga_CALC_oprod_a1[7:0] = FpgaPins_Fpga_CALC_val1_a1[7:0] * FpgaPins_Fpga_CALC_val2_a1[7:0]; // calculate product
                        assign FpgaPins_Fpga_CALC_oquot_a1[7:0] = FpgaPins_Fpga_CALC_val1_a1[7:0] / FpgaPins_Fpga_CALC_val2_a1[7:0]; // calculate quotient
            
                  //_@2
                     //_?$valid
                     assign FpgaPins_Fpga_CALC_out_a2[7:0] = FpgaPins_Fpga_CALC_reset_a2 ? 8'b0 :
                                 FpgaPins_Fpga_CALC_valid_a2 == 1'b0 ? FpgaPins_Fpga_CALC_out_a3[7:0] :
                                 FpgaPins_Fpga_CALC_op_a2[2:0] == 3'b000 ? FpgaPins_Fpga_CALC_osum_a2 :
                                 FpgaPins_Fpga_CALC_op_a2[2:0] == 3'b001 ? FpgaPins_Fpga_CALC_odiff_a2:
                                 FpgaPins_Fpga_CALC_op_a2[2:0] == 3'b010 ? FpgaPins_Fpga_CALC_oprod_a2:
                                 FpgaPins_Fpga_CALC_op_a2[2:0] == 3'b011 ? FpgaPins_Fpga_CALC_oquot_a2:
                                 FpgaPins_Fpga_CALC_op_a2[2:0] == 3'b100 ? FpgaPins_Fpga_CALC_mem_a4:
                                 FpgaPins_Fpga_CALC_out_a3; //default
            
            
                     assign FpgaPins_Fpga_CALC_mem_a2[7:0] = FpgaPins_Fpga_CALC_reset_a2 ? 8'b0 :
                                 FpgaPins_Fpga_CALC_valid_a2 && (FpgaPins_Fpga_CALC_op_a2[2:0] == 3'b101) ? FpgaPins_Fpga_CALC_val1_a2 : FpgaPins_Fpga_CALC_mem_a3;
            
            
                  //_@3
                     assign FpgaPins_Fpga_CALC_digit_a3[3:0] = FpgaPins_Fpga_CALC_out_a3[3:0];
            
                     //$digit[3:0] == $reset4'd0 ? *ui_out[7:0]=8'b000011111';
                     //               876543210
                     assign FpgaPins_Fpga_CALC_zero_a3[7:0] =  8'b000111111;
                     assign FpgaPins_Fpga_CALC_one_a3[7:0] =   8'b000000110;
                     assign FpgaPins_Fpga_CALC_two_a3[7:0] =   8'b001011011;
                     assign FpgaPins_Fpga_CALC_three_a3[7:0] = 8'b001001111;
                     assign FpgaPins_Fpga_CALC_four_a3[7:0] =  8'b001100110;
                     assign FpgaPins_Fpga_CALC_five_a3[7:0] =  8'b001101101;
                     assign FpgaPins_Fpga_CALC_six_a3[7:0] =   8'b001111101;
                     assign FpgaPins_Fpga_CALC_seven_a3[7:0] = 8'b000000111;
                     assign FpgaPins_Fpga_CALC_eight_a3[7:0] = 8'b011111111;
                     assign FpgaPins_Fpga_CALC_nine_a3[7:0] =  8'b001100111;
                     assign FpgaPins_Fpga_CALC_a_a3[7:0] =     8'b001110111;
                     assign FpgaPins_Fpga_CALC_b_a3[7:0] =     8'b001111100;
                     assign FpgaPins_Fpga_CALC_c_a3[7:0] =     8'b000111001;
                     assign FpgaPins_Fpga_CALC_d_a3[7:0] =     8'b001011110;
                     assign FpgaPins_Fpga_CALC_e_a3[7:0] =     8'b001111001;
                     assign FpgaPins_Fpga_CALC_f_a3[7:0] =     8'b001110001;
            
                     //*uo_out[7:0] = $reset ? 8'b00000000 : 8'b00111111;
                     //*uo_out[7:0] = $reset ? 8'b00000000 : $zero;
                     //$digit[3:0] = 4'b0011;
            
                     assign uo_out[7:0] = FpgaPins_Fpga_CALC_reset_a3 ? 8'b00000000 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b0000 ? FpgaPins_Fpga_CALC_zero_a3 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b0001 ? FpgaPins_Fpga_CALC_one_a3 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b0010 ? FpgaPins_Fpga_CALC_two_a3 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b0011 ? FpgaPins_Fpga_CALC_three_a3 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b0100 ? FpgaPins_Fpga_CALC_four_a3 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b0101 ? FpgaPins_Fpga_CALC_five_a3 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b0110 ? FpgaPins_Fpga_CALC_six_a3 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b0111 ? FpgaPins_Fpga_CALC_seven_a3 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b1000 ? FpgaPins_Fpga_CALC_eight_a3 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b1001 ? FpgaPins_Fpga_CALC_nine_a3 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b1010 ? FpgaPins_Fpga_CALC_a_a3 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b1011 ? FpgaPins_Fpga_CALC_b_a3 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b1100 ? FpgaPins_Fpga_CALC_c_a3 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b1101 ? FpgaPins_Fpga_CALC_d_a3 :
                                    FpgaPins_Fpga_CALC_digit_a3[3:0] == 4'b1110 ? FpgaPins_Fpga_CALC_e_a3 : FpgaPins_Fpga_CALC_f_a3;
            
                     //*ui_out = $digit[3:0] ==
            
               // Note that pipesignals assigned here can be found under /fpga_pins/fpga.
            
            
            
            //   m5+cal_viz(@2, /fpga)
            
               // Connect Tiny Tapeout outputs. Note that uio_ outputs are not available in the Tiny-Tapeout-3-based FPGA boards.
               //*uo_out = 8'b0;
               
               
            //_\end_source
   
      // LEDs.
      
   
      // 7-Segment
      //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 395   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 346 as: m4+fpga_sseg.
         for (digit = 0; digit <= 0; digit++) begin : L1_Digit //_/digit
            
            for (leds = 0; leds <= 7; leds++) begin : L2_Leds //_/leds

               // For $viz_lit.
               logic L2_viz_lit_a0;

               assign L2_viz_lit_a0 = (! L0_sseg_digit_n_a0[digit]) && ! ((leds == 7) ? L0_sseg_decimal_point_n_a0 : L0_sseg_segment_n_a0[leds % 7]);
               
            end
         end
      //_\end_source
   
      // slideswitches
      //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv 454   // Instantiated from /raw.githubusercontent.com/osfpga/VirtualFPGALab/a069f1e4e19adc829b53237b3e0b5d6763dc3194/tlvlib/fpgaincludes.tlv, 349 as: m4+fpga_switch.
         for (switch = 0; switch <= 7; switch++) begin : L1_Switch //_/switch

            // For $viz_switch.
            logic L1_viz_switch_a0;

            assign L1_viz_switch_a0 = L0_slideswitch_a0[switch];
            
         end
      //_\end_source
   
      // pushbuttons
      
   //_\end_source
   // Label the switch inputs [0..7] (1..8 on the physical switch panel) (top-to-bottom).
   //_\source /raw.githubusercontent.com/osfpga/VirtualFPGALab/35e36bd144fddd75495d4cbc01c4fc50ac5bde6f/tlvlib/tinytapeoutlib.tlv 82   // Instantiated from top.tlv, 212 as: m5+tt_input_labels_viz(⌈"Value[0]", "Value[1]", "Value[2]", "Value[3]", "Op[0]", "Op[1]", "Op[2]", "="⌉)
      for (input_label = 0; input_label <= 7; input_label++) begin : L1_InputLabel //_/input_label
         
      end
   //_\end_source

//_\SV
endmodule


// Undefine macros defined by SandPiper.
`undef BOGUS_USE
