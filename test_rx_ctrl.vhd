
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


----
entity test_rx_ctrl is
    Port ( rdrf_clr : out STD_LOGIC;
           clr : in STD_LOGIC;
           rdrf : in STD_LOGIC;
           cclk : in STD_LOGIC);
           
end test_rx_ctrl;

architecture Behavioral of test_rx_ctrl is
type estado is (wtrdrf,load);
signal present_state: estado:=wtrdrf;

begin


--Definimos maquina de estados
process (clr)
    begin 
        if (clr='1') then 
        present_state <= wtrdrf;
        elsif (rising_edge (cclk))then
         
            CASE present_state IS
            
            
            when wtrdrf =>
                
                if rdrf ='1' then  --btn(0)
                present_state <= load;
                  
                end if;
       
       
            when load =>
--                if rdrf ='0' then  --btn(0)
                present_state <= wtrdrf;
               
--                end if;
                
         
           
            
            end CASE;
       end if;
end process;
        
------------------------------------------------
process (present_state)
    begin
        case present_state is
        
            WHEN wtrdrf =>
                rdrf_clr<='0';
    
            WHEN load =>
                rdrf_clr<='1';

           
                
        end case;
end process;

end Behavioral;
