`timescale 10ns / 1ns

module icarus;

// --------------------------------------------------------------------------
// ИНИЦИАЛИЗАЦИЯ ВВОДА-ВЫВОДА
// --------------------------------------------------------------------------

reg clk;
reg clock_25;
reg clock_12;
reg clock_6;

// Базовые
reg [3:0]   led;  // Out
reg [1:0]   keys; // In

// ADC
reg         adc_clock_20mhz;
reg [7:0]   adc_input;

// SDRAM
reg        sdram_clock;
reg [11:0] sdram_addr;
reg [1:0]  sdram_bank;
reg [15:0] sdram_dq;        // InOut
reg        sdram_ldqm;
reg        sdram_udqm;
reg        sdram_ras;
reg        sdram_cas;
reg        sdram_we;
    
// VGA
reg [4:0]  vga_red;
reg [5:0]  vga_green;
reg [4:0]  vga_blue;
reg        vga_hs;
reg        vga_vs;

// FTDI (PORT-B)
reg        ftdi_rx;
reg        ftdi_tx;

/* ----------------
* Шилд расширения
* ---------------- */

// USB-A    2 pins
reg [1:0]  usb;

// SOUND    2 channel
reg        sound_left;
reg        sound_right;

// PS/2     keyb / mouse
reg [1:0]  ps2_keyb;
reg [1:0]  ps2_mouse;

// Моделируем сигнал тактовой частоты
always #0.5 clk         = ~clk;      // 100.00
always #2   clock_25    = ~clock_25; //  25.00
always #4   clock_12    = ~clock_12; //  12.50
always #8   clock_6     = ~clock_6;  //   6.25

// От начала времени...
initial begin

  clk      = 1;
  clock_25 = 0;
  clock_12 = 0;
  clock_6  = 0;
  #2000 $finish;

end 
// --------------------------------------------------------------------------

// создаем файл VCD для последующего анализа сигналов
initial
begin

    $dumpfile("icarus_result.vcd");
    $dumpvars(0, icarus);

end

// ПРОЦЕССОР
// --------------------------------------------------------------------------

reg     [15:0] i_data;
wire    [19:0] o_addr;

// Тест
main MAIN(

    clock_25,
    clk,
    o_addr,
    i_data
    
);

// Эмулятор памяти SDRAM
// ---------------------------------------------------------------------

reg [7:0] memory [65535 : 0];

integer j;
initial $readmemh("icarus_memory.hex", memory);

always @(posedge clk) begin

    //                                high byte                     low byte                      
    i_data <= {memory[ {o_addr[15:1], 1'b1} ], memory[ {o_addr[15:1], 1'b0} ]};

end

endmodule
