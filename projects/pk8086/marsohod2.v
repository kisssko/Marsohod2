module marsohod2(

    /* ----------------
    * Архитектурно в Марсоходе-2
    * ---------------- */

    // CLOCK    100 Mhz
    input   wire        clk,

    // LED      4 
    output  wire [3:0]  led,

    // KEYS     2
    input   wire [1:0]  keys,

    // ADC      8 bit
    output  wire        adc_clock_20mhz,
    input   wire [7:0]  adc_input,

    // SDRAM
    output  wire        sdram_clock,
    output  wire [11:0] sdram_addr,
    output  wire [1:0]  sdram_bank,
    inout   wire [15:0] sdram_dq,
    output  wire        sdram_ldqm,
    output  wire        sdram_udqm,
    output  wire        sdram_ras,
    output  wire        sdram_cas,
    output  wire        sdram_we,

    // VGA
    output  wire [4:0]  vga_red,
    output  wire [5:0]  vga_green,
    output  wire [4:0]  vga_blue,
    output  wire        vga_hs,
    output  wire        vga_vs,

    // FTDI (PORT-B)
    input   wire        ftdi_rx,
    output  wire        ftdi_tx,

    /* ----------------
    * Шилд расширения
    * ---------------- */

    // USB-A    2 pins
    inout   wire [1:0]  usb,

    // SOUND    2 channel
    output  wire        sound_left,
    output  wire        sound_right,

    // PS/2     keyb / mouse
    inout   wire [1:0]  ps2_keyb,
    inout   wire [1:0]  ps2_mouse   
);

assign sound_left = clk;
assign sound_right = clock;


wire locked;
wire clock;  // 10.00

pll PLL(

    .clk        (clk),          // Входящие 100 Мгц
    .locked     (locked),       // 0 - устройство генератора ещё не сконфигурировано, 1 - готово и стабильно
    .clock      (clock)         // 10,0 Mhz    

);

endmodule