
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity uart_rx is
    Port ( rxd,rdrf_clr : in STD_LOGIC;
           rx_data : out STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           rdrf : out STD_LOGIC;
           shift1:out std_logic;
           FE : out STD_LOGIC);
end uart_rx;

architecture Behavioral of uart_rx is

type estado is (mark,start,delay,shift,stop,rx_complete);
signal present_state: estado:=mark;

signal rxbuff: std_logic_vector ( 7 downto 0 );

signal reset_cuenta,reset_half: boolean:=false;
signal baud_count,half_baud_count: boolean; --- cuenta bauds
signal bit_time: integer range 0 to 2600; --tiempo de bit
signal half_bit_time: integer range 0 to 1300; --mitad tiempo de bit
signal bit_count,aux: integer range 0 to 7; -- cuenta numero de bits
signal bit_tx: boolean; -- bandera de byte transmitido
signal bit_tx_process: boolean; -- bandera byte en proceso de transmision

signal no_variable,simon,fin,limpia,salida: boolean;
signal tiempo: integer range 0 to 2600; --tiempo de bit


begin



--------------Definimos maquina de estados----------------
process (clr)
    begin 
        if (clr='1') then 
        present_state <= mark;
        
        
        elsif (rising_edge (clk))then
         
            CASE present_state IS
            
            when mark =>
            
            if rxd='0' then
            present_state<=start;
            end if;
                
                
            when start=>
            
            if ( half_baud_count ) then 
              present_state<=delay;
              end if;

                
            when delay =>
                
            
                
                if ( bit_tx and baud_count) then 
              present_state<=stop;
              
               elsif ( baud_count ) then 
              present_state<=shift;
              end if;
              
  
            
                
            when shift => 
             present_state <= delay;
         

             when stop =>
             
             if rxd<='1' then
             present_state<=rx_complete;
             end if;
             
--               
             
            
              when rx_complete =>
              
--              if rdrf_clr='1' then
--              present_state<=mark;
--              end if;
              
              
              
             
      
            end CASE;
       end if;
end process;
        
---------------------------------------------------
process (present_state)
    begin
        case present_state is
        
            WHEN mark =>
           
            shift1<='0';
            no_variable<=true;
            
            rdrf<='0';
            
            
             simon<=false;
             
             reset_half<=true;
                 
           
       
               
               
            WHEN start =>
            
             
              reset_cuenta <= true; 
              
              shift1<='0';
              
                  no_variable<=true;
                  
                    reset_half<=false;
                     rdrf<='0';
                 
             simon<=false;
             
       
                
            WHEN delay =>
               
               
              reset_cuenta <= false;
              
              no_variable<=false;
             simon<=false;
              
              shift1<='0';
              
              limpia<=true;
              
               rdrf<='0';
               
                           rxbuff(7) <= rxd;  




            WHEN shift =>
            
--             rxbuff(3) <= rxd; --almacena el bit en la ultima posición
----               rxbuff(3 downto 0)<=rxbuff(3 downto 0);

              rdrf<='0';
              shift1<='0';
              reset_cuenta <= true;
              
              simon<=true;
              no_variable<=false;
--               rx_data<=rxbuff; 

        
               when stop =>
            
              rdrf<='0';
             shift1<='0';
             no_variable<=true;
             simon<=false;
                            rx_data<=rxbuff; ---CON ESTE FUNCIONABA
                             
                             

             
--             if rxd='0' then
--             fe<='1';
--             end if;
             
              
             
           when rx_complete =>
             rdrf<='1';
             shift1<='1';
             no_variable<=true;
             simon<=false;
            
           
          
              
               
        end case;
end process;

------END MAQUINA DE ESTADOS--------


--contador
process (clk)
    begin 
        
        if (rising_edge(clk)) then 
            
            if reset_cuenta then 
            bit_time <= 0;
            
            else 
            bit_time <= bit_time + 1;
            end if;
            
       end if;
       
       end process;
       
-------cuenta de bits transmitidos e inicializacion del buffer chipocludo------- 

--contador de mitad de tiempo de bit
process (clk)
    begin 
        
        if (rising_edge(clk)) then 
            
            if reset_half then 
            half_bit_time <= 0;
            
            else 
            half_bit_time <= half_bit_time + 1;
            end if;
            
       end if;
       
       end process;
       
-------cuenta de bits transmitidos e inicializacion del buffer chipocludo---------    
       
 caca:      process (no_variable,simon)
       begin
      
       if (rising_edge(clk)) then 
      
                             

       if(no_variable) then
       
       bit_count<=0;
     
      
       
       elsif(simon) then
       
         bit_count<=bit_count+1;
      
         rxbuff(6 downto 0) <= rxbuff(7 downto 1); 
--           rx_data<=rxbuff;     
       end if;
       end if;
       end process caca;
                   




--Definicion de los tiempos
baud_count <= true when bit_time = 2600 else false;
bit_tx <= true when bit_count = 7 else false; 

half_baud_count <= true when half_bit_time = 1300 else false;


  
end Behavioral;

