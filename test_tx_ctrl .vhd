
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity test_tx_ctrl is
    Port ( go : in STD_LOGIC;
           cclk : in STD_LOGIC;
           clr : in STD_LOGIC;---rdrf_clr?
           tdre : in STD_LOGIC;
--           rdrf_clr: in std_logic;
           ready : out STD_LOGIC
                                   );
end test_tx_ctrl;

architecture Behavioral of test_tx_ctrl is
type estado is (wtgo,wtdre, load, wtngo);
signal present_state: estado:=wtgo;

begin


--Definimos maquina de estados
process (clr)
    begin 
        if (clr='1') then 
        present_state <= wtgo;
        elsif (rising_edge (cclk))then
         
            CASE present_state IS
            
            when wtgo =>
                
                if go ='1' then  --btn(0)
                present_state <= wtdre;
                end if;
                
            when wtdre=>
            
                if tdre='1' then
                present_state <= load;
                end if;
                
            when load =>
                
                present_state <= wtngo;
                
            when wtngo =>
            
                if go='0' then
                present_state <= wtgo;
                end if;
                
--             when rdrff_clr =>
             
--             if rdrf_clr='1' then
--             present_state<=wtgo;
--             end if;
            
           
            
            end CASE;
       end if;
end process;
        
-----------------------------------------------
process (present_state)
    begin
        case present_state is
        
            WHEN wtgo =>
               ready<='0'; --hacia el uart_tx
               
            WHEN wtdre =>
                 ready<='0'; 
                   
                
            WHEN load =>
                ready<='1';

            WHEN wtngo =>
               ready<='0';
               
--              when rdrff_clr =>
                
        end case;
end process;



end Behavioral;
