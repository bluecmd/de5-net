`timescale 1 ps / 1 ps
`include "version.sv"

module de5net_identity (
    output wire [31:0] mm_readdata, //    mm.readdata
    input  wire  [0:0] mm_address,  //    mm.address
    input  wire        clk,         //   clk.clk
    input  wire        reset        // reset.reset
  );

  assign mm_readdata = mm_address[0] ? `DE5NET_GIT_HASH : {32'h01FDE5};

endmodule
