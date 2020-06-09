vsim -gui work.IOBlock
add wave -position end sim:/IOBlock/*
force -freeze sim:/IOBlock/clk 1 0, 0 {50 ps} -r 100
force -freeze sim:/IOBlock/rst 1 0
force -freeze sim:/IOBlock/WrLd 10 0
run
force -freeze sim:/IOBlock/rst 0 0
force -freeze sim:/IOBlock/new 0 0
force -freeze sim:/IOBlock/demuxSel 1 0
force -freeze sim:/IOBlock/CPUBus 32'h3 0
run
force -freeze sim:/IOBlock/demuxSel 0 0
force -freeze sim:/IOBlock/new 1 0
force -freeze sim:/IOBlock/CPUBus 01110010010111000111001001011100 0
force -freeze sim:/IOBlock/new St1 0
force -freeze sim:/IOBlock/demuxSel 0 0
run
force -freeze sim:/IOBlock/new 0 0
run
run
run
run
run
run
run
force -freeze sim:/IOBlock/new 1 0
force -freeze sim:/IOBlock/CPUBus 00000001000001110010001100000001 0
run
force -freeze sim:/IOBlock/new 0 0
force -freeze sim:/IOBlock/new St0 0
run
run
run
run
run
run
run
force -freeze sim:/IOBlock/new 1 0
force -freeze sim:/IOBlock/CPUBus 01001111111011110000001101000001 0
run
force -freeze sim:/IOBlock/new 0 0
run
run
run
run
run
run
run
run
run