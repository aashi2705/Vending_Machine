module vending_machine_tb;
  
  //inputs
  reg clk;
  reg[1:0] in;
  reg rst;
  
  //output
  wire out;
  wire[1:0] change;
  
  vending_machine_2503 uut(
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out),
    .change(change)
  );
  
  initial begin
    
    //initialise inputs
    $dumpfile("vending_machine.vcd");
    $dumpvars(0,vending_machine_tb);

    clk = 0;
    rst = 1;
    in  = 2'b00;

    #5 rst = 0;

    #5  in = 2'b01;   // first 5
    #10 in = 2'b01;   // second 5
    #10 in = 2'b01;   // third 5 => vend
    #10 in = 2'b00;   // no coin now

    #20 $finish;
  end
  always #4 clk = ~clk;
  
endmodule