
---EL codigo esta acondicionado para 4 switches,implica la cuenta de cuantos bits va a transmitir,desde que se declara el rango
---de los enteros, y las condiciones al final del programa, el tamaño de los vectores, buff, y tx_data, y de los desplazamientos
---eso esta al final de programa abajo del process C A C A , viene un segundo contador ahi se asignan tamaños de buffer 
---y otras cosas
--un boton clr,un boton de inicio
---3 leds: txd,tdre y shift1(para visualizar cuando entra a shift)
--- se probo el programa a medio hz, maso..



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity prueba_tx is
    Port ( ready,rdrf_clr : in STD_LOGIC;
           tx_data : in STD_LOGIC_VECTOR (7 downto 0);
           clk : in STD_LOGIC;
           clr : in STD_LOGIC;
           txd : out STD_LOGIC;
           shift1:out std_logic;
           tdre : out STD_LOGIC);
end prueba_tx;

architecture Behavioral of prueba_tx is

type estado is (mark,start,delay,shift,stop);
signal present_state: estado:=mark;

signal txbuff: std_logic_vector ( 9 downto 0 );

signal reset_cuenta: boolean:=false;
signal baud_count: boolean; -- cuenta bauds
signal bit_time: integer range 0 to 2600; --tiempo de bit

signal bit_count,aux: integer range 0 to 9; -- cuenta numero de bits
signal bit_tx: boolean; -- bandera de byte transmitido
signal bit_tx_process: boolean; -- bandera byte en proceso de transmision

signal no_variable,simon,fin,limpia: boolean;
signal tiempo: integer range 0 to 2600; --tiempo de bit








begin



--------------Definimos maquina de estados----------------
process (clr)
    begin 
        if (clr='1') then 
        present_state <= mark;
--        no_variable<=true;
        
        
        elsif (rising_edge (clk))then
         
            CASE present_state IS
            
            when mark =>
            if ready='1' or rdrf_clr='1' then
            present_state<=start;
            end if;
                
                
            when start=>
            
            
            present_state<=delay;
            
                
            when delay =>
                
            
                
                if ( bit_tx and baud_count) then -- se cumple bit_count=8 y el bit de stop ya incluido en el shift
              present_state<=stop;
              
               elsif ( baud_count ) then -- se cumple bit_count=8 y el bit de stop ya incluido en el shift
              present_state<=shift;
              end if;
              
  
            
                
            when shift => --duda con la jearquia de los dos if's
            
             present_state <= delay;
         

             when stop =>
             
             if fin then
             present_state<=mark;
             end if;
            
              
             
      
            end CASE;
       end if;
end process;
        
---------------------------------------------------
process (present_state)
    begin
        case present_state is
        
            WHEN mark =>
            
--          txbuff<="100000";
            tdre<='1';
            txd<=txbuff(9);
            shift1<='0';
            no_variable<=true;
            
            
             simon<=false;
                 
            
        
               
               
            WHEN start =>
            
              txd<=txbuff(0); --mantener timepo de bit
              tdre<='0';
              reset_cuenta <= true; -- duda ¿cuando se manda el reset de la cuenta, para que la inicie
--            txbuff( 4 downto 1)<=tx_data( 3 downto 0);
              shift1<='0';
--              reinicia_marca<=true;
                  no_variable<=true;
                  
                 
             simon<=false;
             
       
                
            WHEN delay =>
               
                txd<=txbuff(0); --bit START  mantener timepo de bit
                tdre<='0';-- Indica que la transmisión empezó           ---PARA PRUEBA TDRE ES 1
              reset_cuenta <= false;
              
              no_variable<=false;
             simon<=false;
              
              shift1<='0';
              
              limpia<=true;



            WHEN shift =>
            
             
--               txbuff(3 downto 0) <=txbuff(4 downto 1); 
               
              txd<=txbuff(0);
              tdre<='0';
              shift1<='1';
              reset_cuenta <= true;
              
              simon<=true;
              no_variable<=false;

        
               when stop =>
            
             txd<=txbuff(9);
             tdre<='0';
             shift1<='0';
             no_variable<=true;
             simon<=false;
             
             limpia<=false;
             
            
             
          
              
               
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
       
 caca:      process (no_variable,simon)
       begin
      
       if (rising_edge(clk)) then 
       

       if(no_variable) then
       bit_count<=0;
       txbuff<="1000000000";
        txbuff( 8 downto 1)<=tx_data( 7 downto 0);
      
       
       elsif(simon) then
      bit_count<=bit_count+1;
      
       txbuff(7 downto 0) <=txbuff(8 downto 1); 
               
       end if;
       end if;
       end process caca;
                   
-------segundo contador, se usa para stop-----

process (clk)
    begin 
        
        if (rising_edge(clk)) then 
            
            if limpia then 
            tiempo <= 0;
            
            else 
            tiempo <= tiempo + 1;
            end if;
            
       end if;
       
       end process;
-------- fin de contador del estado de stop------




--Definicion de los tiempos
baud_count <= true when bit_time = 2600 else false;
bit_tx <= true when bit_count = 8 else false; 


fin <= true when tiempo = 2600 else false;





end Behavioral;
