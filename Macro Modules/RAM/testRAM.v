module testRAM
#(parameter N = 16, M = 6000, K = 13,tests = 5) // generic paramter
();
reg [K-1:0]address;
reg[K-1:0]addressPortOne;
reg[K-1:0]addressPortTwo;
reg[K-1:0]addressWritePort;
wire[N-1:0]readPortOneData;
wire[N-1:0]readPortTwoData;
reg[N-1:0]writePortData;
reg WE,Clk;
RAM#(.N(16), .M(6000), .K(13)) ram0(
  .WE(WE),
  .Clk(Clk),
  .addressPortOne(addressPortOne),
  .addressPortTwo(addressPortTwo),
  .addressWritePort(addressWritePort),
  .readPortOneData(readPortOneData),
  .readPortTwoData(readPortTwoData),
  .writePortData(writePortData)
);
integer CLK_PERIOD = 50;
integer i,j = 10;
//making process for the clock
initial begin
  
  address = 0;
  Clk = 1'b0; //initially zero level clock
  WE = 1'b1;
  
  //loop
  for(i = 0;i < tests;i = i + 1) begin
    #CLK_PERIOD Clk = ~Clk; // zero level clock
    writePortData  = j;
    addressWritePort = address;
    addressPortOne = address;
  
    #CLK_PERIOD Clk = ~Clk; // one level clock
    if (readPortOneData !== j)// expected sum
      $display("ERROR: readPortOneData != ", j);
  
    writePortData  = j;
    addressWritePort = address;
    addressPortOne = address;
    #CLK_PERIOD Clk = ~Clk; // zero level clock
    address = address + 1;
    j = j + 1;
    addressWritePort = address;
    	addressPortTwo = address;
    writePortData  = j;
  
    #CLK_PERIOD Clk = ~Clk; // one level clock
    if (readPortTwoData !== j)// expected sum
      $display("ERROR: readPortTwoData != %d", j);
    address = address + 1;
    j = j + 1;
  end
end
endmodule 
/*
*/
/*
architecture testFSMArch of testFSM is
    component FSM is
        port(
            inp,clk,rst : in std_logic;
            oup : out std_logic
        );
    end component;
    signal inpsig,oupsig,rstsig : std_logic;
    signal clksig : std_logic := '0'; -- starting from the falling edge
    signal test_input : std_logic_vector(10 downto 0) := "11100001111";
    signal test_output : std_logic_vector(10 downto 0) := "11000000110";
    constant CLK_PER : time := 100 ps;

    
    begin

        testprocess : process
            begin
                for i in 0 to test_input'length-1 loop
                    --test one at input = 1 and rst = 1
                    if i = 3 then
                        rstsig <= '1';
                    else
                        rstsig <= '0';
                    end if;
                    wait for CLK_PER/2;
                    clksig <= not(clksig); --level one
                    inpsig <= test_input(i);
                    wait for CLK_PER/2;
                    assert(oupsig = test_output(i))
                    report "error as output isn't correct"
                    severity error;
                    clksig <= not(clksig); --level zero
                end loop;
                                
                wait;
            end process;
        blackbox : FSM port Map(inpsig,clksig,rstsig,oupsig);
end architecture;

*/