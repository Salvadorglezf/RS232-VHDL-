


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity top_protocolo is
    Port ( mclk : in STD_LOGIC;
           btn:in std_logic;
           clr: in std_logic;
           tx_data: in std_logic_vector(7 downto 0);
--           tdre1:out std_logic;
           shift1:out std_logic;
--           ledclk:out std_logic;
           an: out std_logic_vector(3 downto 0);
           a_to_g:out std_logic_vector(6 downto 0);
           leds: out std_logic_vector(7 downto 0);
           txd: out std_logic;
           rxd: in std_logic;
           
           rdrf_clr1,rdrf2:out std_logic
           

           
                               );
end top_protocolo;

architecture Behavioral of top_protocolo is
signal clk190,clk25,go1,ready,btnd,tdre,rdrf,FE,rdrf1: std_logic;

signal txd1,rdrf_clr: std_logic;
signal rx_data: std_logic_vector(7 downto 0);
signal buffer1:std_logic_vector(7 downto 0);




begin

process
begin
if btnd='1' then

buffer1<=tx_data;

else
buffer1<=rx_data;
end if;
end process;



--ledclk<=clk25;
--tdre1<=tdre;
leds<=rx_data;
rdrf_clr1<=rdrf_clr;
 

rdrf2<=rdrf;


Inst_clk: entity work.clk PORT MAP(
		mclk => mclk,
		clr => clr,
		clk190=>clk190,
		clk25 => clk25
	);


Inst_debounce: entity work.debounce PORT MAP(
		cclk => clk190,
		clr => clr,
		inp => btn,
		outp => btnd
		
	);
	
Inst_test_tx_ctrl: entity work.test_tx_ctrl PORT MAP(
		cclk => clk25,
		go=>btnd,
		clr => clr,
		tdre => tdre,
		ready=>ready
	);

Inst_prueba_tx: entity work.prueba_tx PORT MAP(

  clk=>clk25,
  clr=>clr,
  tdre=>tdre,
  ready=>ready,
  tx_data=>tx_data,
--  shift1=>shift1,
  txd=>txd
		
	);
		
Inst_uart_rx: entity work.uart_rx PORT MAP(
rxd=>rxd,
rdrf_clr=>rdrf_clr,
rx_data=>rx_data,
clk=>clk25,
FE=>FE,
rdrf=>rdrf,
-- shift1=> shift1,
clr=>clr
	);
	
Inst_test_rx_ctrl: entity work.test_rx_ctrl PORT MAP(
clr=>clr,
rdrf=>rdrf,
cclk=>clk25,
rdrf_clr=>rdrf_clr

);

Inst_doubble: entity work.doubble PORT MAP(
inp(7 downto 0)=>rx_data,
inp(8)=>'0',
cclk=>clk190,
clr=>clr,
an=>an,
a_to_g=>a_to_g


);


end Behavioral;
