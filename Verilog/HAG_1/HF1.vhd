----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:24:43 10/07/2017 
-- Design Name: 
-- Module Name:    HF1 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity HF1 is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           man_out : out  STD_LOGIC_VECTOR (2 downto 0);
           std_out : out  STD_LOGIC_VECTOR (2 downto 0);
           ind_out : out  STD_LOGIC_VECTOR (2 downto 0));
end HF1;

architecture Behavioral of HF1 is

begin


end Behavioral;

